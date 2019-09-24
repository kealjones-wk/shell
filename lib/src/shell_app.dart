import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:shell_events/shell_events.dart';

import './shell_experience.dart';
import './shell_experience_manager.dart';
part 'shell_app.over_react.g.dart';

@Factory()
UiFactory<ShellAppProps> ShellApp = _$ShellApp;

@Props()
class _$ShellAppProps extends UiProps {
  bool showMessages;

  List messages;
}

@State()
class _$ShellAppState extends UiState {
  bool showMessages;

  List messages;
}

@Component()
class ShellAppComponent extends UiStatefulComponent<ShellAppProps, ShellAppState>  {
  ShellExperienceManager _shellExperienceManager;
  DivElement _messagesBox;

  @override
  Map getDefaultProps() => (newProps()
    ..showMessages = true
    ..messages = []
  );

  @override
  Map getInitialState() => (newState()
    ..showMessages = props.showMessages
    ..messages = props.messages
  );

  @override
  void componentWillMount() {
    super.componentWillMount();

    _shellExperienceManager = new ShellExperienceManager();
    _shellExperienceManager.initializeEventHandlers();

    document.addEventListener(ShellEventConstants.POST_MESSAGE.event, _handlePostMessage);
    document.addEventListener(ShellEventConstants.TOGGLE_MESSAGES.event, _handleToggleMessages);
  }

  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    _shellExperienceManager.disposeEventHandlers();

    document.removeEventListener(ShellEventConstants.POST_MESSAGE.event, _handlePostMessage);
    document.removeEventListener(ShellEventConstants.TOGGLE_MESSAGES.event, _handleToggleMessages);
  }

  @override
  void componentDidUpdate(prevProps, prevState) {
    if(state.showMessages) {
      var _messagesBoxNode = findDomNode(_messagesBox);
      _messagesBoxNode.scrollTo(0, _messagesBoxNode.scrollHeight);
    }
  }

  render() {
    return (Dom.div()..className = 'shell')(
      Dom.h2()('Using over_react 1.18.0'),
      _renderShellControls(),
      _renderMessagesBox()
    );
  }

  void _handlePostMessage(event) {
    var messages = new List.from(state.messages);
    var postBy = (event.target == findDomNode(this)) ? '' : 'Message posted from ${event.target}:';

    messages.add('${new DateTime.now().toString()} - ${postBy} ${event.detail['message']}');
    setState(newState()..messages = messages);
  }

  void _handleToggleMessages(event) {
    var toggledBy = (event.target is ButtonElement) ? 'shell' : event.target;
    findDomNode(this).dispatchEvent(new ShellPostMessageEvent(
      'Message panel ${state.showMessages ? 'disabled' : 'enabled'} by ${toggledBy}'
    ).e);

    setState(newState()..showMessages = !state.showMessages);
  }

  List<ReactElement> _renderMessages() {
    List<ReactElement> messages = [];

    for (var i = 0; i < state.messages.length; i++) {
      messages.add(Dom.em()(Dom.p()(state.messages[i])));
    }

    return messages;
  }

  ReactElement _renderMessagesBox() {
    var classes = new ClassNameBuilder()
      ..add('shell__messages')
      ..add('shell__messages--hidden', !state.showMessages);

    return (Dom.div()
      ..className = classes.toClassName()
      ..ref = (ref) {
        _messagesBox = ref;
      }
    )(
      Dom.h4()('Messages'),
      _renderMessages()
    );
  }

  ReactElement _renderShellControls() {
    return (Dom.div()..className = 'shell__controls')(
      (Dom.button()
        ..onClick = (event) {
          event.target.dispatchEvent(new ShellExperienceRequstedEvent(ShellExperience.DOCS.prefix).e);
        }
      )('New Docs Experience'),
      (Dom.button()..onClick = (event) {
        event.target.dispatchEvent(new ShellExperienceRequstedEvent(ShellExperience.SPREADSHEETS.prefix).e);
      })('New Spreadsheets Experience'),
      (Dom.button()
        ..onClick = (event) {
          event.target.dispatchEvent(new ShellToggleMessagesEvent().e);
        }
      )('Toggle Messages')
    );
  }
}

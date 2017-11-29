import 'dart:html';

import 'package:over_react/over_react.dart';
import 'package:shell_events/shell_events.dart';

@Factory()
UiFactory<ShellAppProps> ShellApp;

@Props()
class ShellAppProps extends UiProps {
  bool showMessages;

  List messages;
}

@State()
class ShellAppState extends UiState {
  bool showMessages;
  
  List<String> messages;
}

@Component()
class ShellAppComponent extends UiStatefulComponent<ShellAppProps, ShellAppState>  {
  ReactElement _toggleMessagesButton;
  ReactElement _messagesBox;
  
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

    document.addEventListener(ShellEventConstants.TOGGLE_MESSAGES.event, _handleToggleMessages);
    document.addEventListener(ShellEventConstants.POST_MESSAGE.event, _handlePostMessage);
  }
  
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    document.removeEventListener(ShellEventConstants.TOGGLE_MESSAGES.event, _handleToggleMessages);
    document.removeEventListener(ShellEventConstants.POST_MESSAGE.event, _handlePostMessage);
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

  ReactElement _renderShellControls() {
    return (Dom.div()..className = 'shell__controls')(
      (Dom.button()..onClick = (event) => document.body.append(new Element.tag('docs-experience')))('New Docs Experience'),
      (Dom.button()..onClick = (event) => document.body.append(new Element.tag('ss-experience')))('New Spreadsheets Experience'),
      (Dom.button()
        ..onClick = (event) {
            findDomNode(_toggleMessagesButton).dispatchEvent(new ShellToggleMessagesEvent());
          }
        ..ref = (ref) {
          _toggleMessagesButton = ref;
        }
      )('Toggle Messages')
    );
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

  List<ReactElement> _renderMessages() {
    List messages = [];

    for (var i = 0; i < state.messages.length; i++) {
      messages.add(Dom.em()(Dom.p()(state.messages[i])));
    }

    return messages;
  }

  void _handleToggleMessages(event) {
    var toggledBy = (event.target == findDomNode(_toggleMessagesButton) ? 'shell' : event.target);
    findDomNode(this).dispatchEvent(new ShellPostMessageEvent(detail:
        {'message': 'Message panel ${state.showMessages ? 'disabled' : 'enabled'} by ${toggledBy}'}));
    
    setState(newState()..showMessages = !state.showMessages);
  }

  void _handlePostMessage(event) {
    var messages = new List.from(state.messages);
    messages.add('${new DateTime.now().toString()} - ${event.detail['message']}');
    
    setState(newState()..messages = messages);
  }
}

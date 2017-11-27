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
  
  List messages;
}

@Component()
class ShellAppComponent extends UiStatefulComponent<ShellAppProps, ShellAppState>  {
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
  }
  
  @override
  void componentWillUnmount() {
    super.componentWillUnmount();

    document.removeEventListener(ShellEventConstants.TOGGLE_MESSAGES.event, _handleToggleMessages);
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
      (Dom.button()..onClick = (event) => document.dispatchEvent(new ToggleMessages()))('Toggle Messages')
    );
  }

  ReactElement _renderMessagesBox() {
    var classes = new ClassNameBuilder()
      ..add('shell__messages')
      ..add('shell__messages--hidden', !state.showMessages);
    
    return (Dom.div()..className = classes.toClassName())(
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

  void _handleToggleMessages(Event event) {
    setState(newState()..showMessages = !state.showMessages);
  }
}

import 'package:over_react/over_react.dart';

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
  
  render() {
    return (Dom.div()..className = 'shell')(
      Dom.h2()('Using over_react 1.18.0'),
      _renderShellControls(),
      _renderMessagesBox()
    );
  }

  _renderShellControls() {
    return (Dom.div()..className = 'shell__controls')(
      Dom.button()('Toggle Messages')
    );
  }

  _renderMessagesBox() {
    var classes = new ClassNameBuilder()
      ..add('shell__messages')
      ..add('shell__messages--hidden', !state.showMessages);
    
    return (Dom.div()..className = classes.toClassName())(
      Dom.h4()('Messages'),
      _renderMessages()
    );
  }

  _renderMessages() {
    List messages = [];

    for (var i = 0; i < state.messages.length; i++) {
      messages.add(Dom.em()(Dom.p()(state.messages[i])));
    }

    return messages;
  }
}

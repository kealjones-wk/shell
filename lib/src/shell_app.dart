import 'package:over_react/over_react.dart';

@Factory()
UiFactory<ShellAppProps> ShellApp;

@Props()
class ShellAppProps extends UiProps {
  bool showMessages;
}

@State()
class ShellAppState extends UiState {
  bool showMessages;
}

@Component()
class ShellAppComponent extends UiStatefulComponent<ShellAppProps, ShellAppState>  {
  @override
  Map getDefaultProps() => (newProps()
    ..showMessages = true
  );
  
  @override
  Map getInitialState() => (newState()
    ..showMessages = props.showMessages
  );
  
  render() {
    return (Dom.div()..className = 'shell')(
      Dom.h2()('Using over_react 1.18.0'),
      _renderShellControls(),
      _renderMessages()
    );
  }

  _renderShellControls() {
    return (Dom.div()..className = 'shell__controls')(
      Dom.button()('Toggle Messages')
    );
  }

  _renderMessages() {
    var classes = new ClassNameBuilder()
      ..add('shell__messages')
      ..add('shell__messages--hidden', !state.showMessages);
    
    return (Dom.div()..className = classes.toClassName())(
      Dom.h4()('Messages')
    );
  }
}

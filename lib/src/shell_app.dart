import 'package:over_react/over_react.dart';

@Factory()
UiFactory<ShellAppProps> ShellApp;

@Props()
class ShellAppProps extends UiProps {
}

@State()
class ShellAppState extends UiState {
  int counter;
}

@Component()
class ShellAppComponent extends UiStatefulComponent<ShellAppProps, ShellAppState>  {
  Map getInitialState() => (newState()
    ..counter = 0
  );
  
  render() {
    return Dom.div()(
      Dom.h2()('Using over_react 1.18.0')
    );
  }
}

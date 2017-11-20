import 'package:over_react/over_react.dart';

@Factory()
UiFactory<DocsExperienceAppProps> DocsExperienceApp;

@Props()
class DocsExperienceAppProps extends UiProps {
}

@State()
class DocsExperienceAppState extends UiState {
  int counter;
}

@Component()
class DocsExperienceAppComponent extends UiStatefulComponent<DocsExperienceAppProps, DocsExperienceAppState>  {
  Map getInitialState() => (newState()
    ..counter = 0
  );
  
  render() {
    return Dom.div()(
      Dom.h3()('Using over_react 1.17.0'),
      Dom.span()('Counter: ' + state.counter.toString()),
      Dom.div()(
        (Dom.button()
          ..onClick = (event) => setState(newState()..counter = ++state.counter)
        )('Increment'),
        (Dom.button()
          ..onClick = (event) => setState(newState()..counter = --state.counter)
        )('Decrement')
      )
    );
  }
}

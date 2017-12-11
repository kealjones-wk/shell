import 'dart:async';
import 'dart:html';

class AsyncScriptLoader {
    AsyncScriptLoader(scriptSource) {
      _scriptElement = new ScriptElement()
        ..type = 'text/javascript'
        ..src = scriptSource
        ..async = true;
    }

    ScriptElement _scriptElement;

    Future loadScript() {
      var firstScriptTag = document.getElementsByTagName('script')[0];
      firstScriptTag.parentNode.insertBefore(_scriptElement, firstScriptTag);

      return _scriptElement.onLoad.first;
    }
}
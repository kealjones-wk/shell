import 'dart:html';

import 'package:react/react_client.dart';
import 'package:react/react_dom.dart' as react;

import 'docs_experience_app.dart';

class DocsExperience extends HtmlElement {
  DocsExperience.created() : super.created() {}
  
  void attached() {
    setClientConfiguration();

    ShadowRoot shadow = attachShadow({'mode': 'open'});
    react.render(DocsExperienceApp()(), shadow);
  }
}
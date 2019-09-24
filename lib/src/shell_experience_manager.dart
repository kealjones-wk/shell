import 'dart:async';
import 'dart:html';

import 'package:shell_events/shell_events.dart' show ShellEventConstants;

import './async_script_loader.dart';
import './shell_experience.dart';
import './shell_experience_meta.dart';

class ShellExperienceManager {
  static final ShellExperienceManager _instance = new ShellExperienceManager._internal();

  factory ShellExperienceManager() {
    return _instance;
  }

  Map _registeredExperiences = new Map<String, ShellExperienceMeta>();

  ShellExperienceManager._internal() {
    ShellExperience.experiences.forEach((ShellExperience experience) {
      _registeredExperiences[experience.prefix] = new ShellExperienceMeta(experience);
    });
  }

  void _handleAddExperience(event) {
    addExperience(event.detail['experience']);
  }

  Future addExperience(String experience) async {
    var experienceMeta = _registeredExperiences[experience];

    if(!experienceMeta.isLoaded) {
      var asyncExperienceLoader = new AsyncScriptLoader(experienceMeta.source);
      var asyncExperienceLoaderOnLoad = asyncExperienceLoader.loadScript();
      asyncExperienceLoaderOnLoad.whenComplete(await () => experienceMeta.isLoaded = true);
    }

    document.body.append(new Element.tag(experienceMeta.tag));
  }

  void disposeEventHandlers() {
    document.removeEventListener(ShellEventConstants.EXPERIENCE_REQUESTED.event, _handleAddExperience);
  }

  void initializeEventHandlers() {
    document.addEventListener(ShellEventConstants.EXPERIENCE_REQUESTED.event, _handleAddExperience);
  }
}

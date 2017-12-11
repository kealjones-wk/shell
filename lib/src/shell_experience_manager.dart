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

  Map _registeredExperiences = new Map<ShellExperience, ShellExperienceMeta>();

  ShellExperienceManager._internal() {
    ShellExperience.experiences.forEach((experience) {
      _registeredExperiences[experience] = new ShellExperienceMeta(experience);
    });
  }

  void _handleAddExperience(event) {
    addExperience(event.detail['experience']);
  }

  Future addExperience(ShellExperience experience) async {
    var experienceMeta = getShellExperienceMeta(experience);
    
    if(!experienceMeta.isLoaded) {
      var asyncExperienceLoader = new AsyncScriptLoader(experienceMeta.source);
      var asyncExperienceLoaderOnLoad = asyncExperienceLoader.loadScript();
      await asyncExperienceLoaderOnLoad.whenComplete(() => experienceMeta.isLoaded = true);
    }
    
    document.body.append(new Element.tag(experienceMeta.tag));
  }

  void disposeEventHandlers() {
    document.removeEventListener(ShellEventConstants.EXPERIENCE_REQUESTED.event, _handleAddExperience);
  }

  ShellExperienceMeta getShellExperienceMeta(ShellExperience experience) {
    return _registeredExperiences[experience];
  }

  void initializeEventHandlers() {
    document.addEventListener(ShellEventConstants.EXPERIENCE_REQUESTED.event, _handleAddExperience);
  }
}
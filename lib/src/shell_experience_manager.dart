import 'dart:html';

import 'package:shell_events/shell_events.dart' show ShellEventConstants;

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

  void addExperience(ShellExperience experience) {
    document.body.append(new Element.tag(getShellExperienceMeta(experience).tag));
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
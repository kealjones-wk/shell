import './shell_experience.dart';
import './shell_experience_meta.dart';

class ShellExperienceRegistry {
  static final ShellExperienceRegistry _instance = new ShellExperienceRegistry._internal();

  factory ShellExperienceRegistry() {
    return _instance;
  }

  Map _registeredExperiences = new Map<ShellExperience, ShellExperienceMeta>();

  ShellExperienceRegistry._internal() {
    ShellExperience.experiences.forEach((experience) {
      _registeredExperiences[experience] = new ShellExperienceMeta(experience);
    });
  }

  ShellExperienceMeta getShellExperienceMeta(ShellExperience experience) {
    return _registeredExperiences[experience];
  }
}
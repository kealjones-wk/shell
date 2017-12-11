import './shell_experience.dart';

class ShellExperienceMeta {
  static const CDN_URL = 'localhost:9000';
  static const RELEASE_DIR = 'latest';
  static const SCRIPT_NAME = 'index.dart.js';
  static const TAG_POSTFIX = '-experience';

  ShellExperienceMeta(this.shellExperience) {
    prefix = shellExperience.prefix;
    source = 'http://${CDN_URL}/${prefix}-experience/${RELEASE_DIR}/${SCRIPT_NAME}';
  }

  ShellExperience shellExperience;
  
  String prefix;

  String get tag {
    return '${prefix}${TAG_POSTFIX}';
  }

  String source;

  bool isLoaded = false;
}
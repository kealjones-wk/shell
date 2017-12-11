import './shell_experience.dart';

class ShellExperienceMeta {
  static const CDN_URL = 'localhost:9000';
  static const RELEASE_DIR = 'latest';
  static const SCRIPT_NAME = 'index.dart.js';
  static const TAG_POSTFIX = '-experience';

  ShellExperienceMeta(this.shellExperience) {
    prefix = shellExperience.prefix;
    source = 'http://${CDN_URL}/${tag}/${RELEASE_DIR}/${SCRIPT_NAME}';
  }

  bool isLoaded = false;

  String prefix;

  ShellExperience shellExperience;

  String source;

  String get tag {
    return '${prefix}${TAG_POSTFIX}';
  }
}
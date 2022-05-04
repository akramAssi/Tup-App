enum LanguageType { english, arabic }

const String _arabic = "ar";
const String _english = "en";

extension LanguageTypeExtenstion on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return _english;
      case LanguageType.arabic:
        return _arabic;
    }
  }
}

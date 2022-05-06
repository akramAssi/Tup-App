import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/presentation/resources/language_manager.dart';

const String prefsKeyLang = "PREFS_KEY_LANG";

class AppPrefernces {
  final SharedPreferences _sharedPreferences;

  AppPrefernces(this._sharedPreferences);

  Future<String> getApplicationLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language?.isNotEmpty ?? false) {
      return language!;
    } else {
      return LanguageType.english.getValue();
    }
  }
}

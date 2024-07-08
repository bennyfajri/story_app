import 'package:shared_preferences/shared_preferences.dart';

class SettingPrefs {
  final Future<SharedPreferences> sharedPreferences;

  SettingPrefs({required this.sharedPreferences});

  static const darkTheme = 'DARK_THEME';
  static const appLocale = 'APP_LOCALE';
  static const premiumUser = 'PREMIUM_USER';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isPremiumUser async {
    final prefs = await sharedPreferences;
    return prefs.getBool(premiumUser) ?? false;
  }

  void setPremiumUser(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(premiumUser, value);
  }

  Future<String> get appLanguage async {
    final prefs = await sharedPreferences;
    return prefs.getString(appLocale) ?? "id";
  }

  void setAppLanguace(String locale) async {
    final prefs = await sharedPreferences;
    prefs.setString(appLocale, locale);
  }
}

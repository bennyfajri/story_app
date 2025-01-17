import 'package:flutter/material.dart';
import 'package:story_app/common/styles.dart';
import 'package:story_app/data/db/settings_prefs.dart';

class SettingsProvider extends ChangeNotifier {
  SettingPrefs settingPrefs;


  SettingsProvider({required this.settingPrefs}) {
    _getTheme();
    _getLanguage();
    _getPremiumUser();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isPremiumUser = false;
  bool get isPremiumUser => _isPremiumUser;

  String _languageCode = "";
  String get languageCode => _languageCode;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  Locale get locale => Locale(_languageCode.isEmpty ? "id" : _languageCode, "");

  void _getTheme() async {
    _isDarkTheme = await settingPrefs.isDarkTheme;
    notifyListeners();
  }

  void _getLanguage() async {
    _languageCode = await settingPrefs.appLanguage;
    notifyListeners();
  }

  void _getPremiumUser() async {
    _isPremiumUser = await settingPrefs.isPremiumUser;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    settingPrefs.setDarkTheme(value);
    _getTheme();
  }

  void setLanguage(String languageCode) {
    settingPrefs.setAppLanguace(languageCode);
    _getLanguage();
  }

  void enablePremiumUser(bool value) {
    settingPrefs.setPremiumUser(value);
    _getPremiumUser();
  }
}

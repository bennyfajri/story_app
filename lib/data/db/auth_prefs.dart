import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/models/login/login_result.dart';

class AuthPrefs {
  final Future<SharedPreferences> sharedPreferences;
  AuthPrefs({required this.sharedPreferences});

  final loginDelay = const Duration(milliseconds: 1500);
  final String stateKey = "state";
  final String userKey = "user";

  Future<bool> isLoggedIn() async {
    final preferences = await sharedPreferences;
    return preferences.getBool(stateKey) ?? false;
  }

  Future<bool> login() async {
    final preferences = await sharedPreferences;
    return preferences.setBool(stateKey, true);
  }

  Future<bool> logout() async {
    final preferences = await sharedPreferences;
    return preferences.setBool(stateKey, false);
  }

  Future<bool> saveLoginInfo(LoginResult loginResults) async {
    final preferences = await sharedPreferences;
    return preferences.setString(userKey, loginResults.toJsonString());
  }

  Future<bool> deleteLoginInfo() async {
    final preferences = await sharedPreferences;
    await Future.delayed(loginDelay);
    return preferences.setString(userKey, "");
  }

  Future<LoginResult?> getLoginInfo() async {
    final preferences = await sharedPreferences;
    final json = preferences.getString(userKey) ?? "";
    LoginResult? loginResults;
    try {
      loginResults = LoginResult.fromJsonDecode(json);
    } catch (e) {
      loginResults = null;
    }
    return loginResults;
  }
}

import 'package:flutter/material.dart';
import 'package:story_app/data/models/login/login_request.dart';
import 'package:story_app/data/models/login/login_result.dart';
import 'package:story_app/data/models/register/register_request.dart';

import '../data/api/auth_service.dart';
import '../data/db/auth_prefs.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  final AuthPrefs authPrefs;

  AuthProvider({
    required this.authService,
    required this.authPrefs,
  }) {
    _initLoginInfo();
  }

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;
  bool isLoggedIn = false;
  LoginResult? loginResults;
  String errorMessage = "";

  Future<bool> login(LoginRequest loginRequest) async {
    isLoadingLogin = true;
    notifyListeners();

    final serverResponse = await authService.loginUser(loginRequest);
    if (!serverResponse.error) {
      await authPrefs.login();
      await authPrefs.saveLoginInfo(serverResponse.loginResult!);
    } else {
      errorMessage = serverResponse.message;
    }
    isLoggedIn = await authPrefs.isLoggedIn();
    loginResults = await authPrefs.getLoginInfo();

    isLoadingLogin = false;
    notifyListeners();

    return isLoggedIn;
  }

  Future<bool> register(RegisterRequest registerRequest) async {
    isLoadingRegister = true;
    notifyListeners();

    final serverResponse = await authService.registerUser(registerRequest);
    if (serverResponse.error) {
      errorMessage = serverResponse.message;
    }

    isLoadingRegister = false;
    notifyListeners();

    return !serverResponse.error;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();
 
    final logout = await authPrefs.logout();
    if (logout) {
      await authPrefs.deleteLoginInfo();
    }
    isLoggedIn = await authPrefs.isLoggedIn();
    loginResults = await authPrefs.getLoginInfo();

    print("isLoggedIn : $isLoggedIn");

    isLoadingLogout = false;
    notifyListeners();

    return !isLoggedIn;
  }

  void _initLoginInfo() async {
    isLoggedIn = await authPrefs.isLoggedIn();
    loginResults = await authPrefs.getLoginInfo();
    notifyListeners();
  }
}

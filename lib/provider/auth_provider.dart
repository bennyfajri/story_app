import 'package:flutter/material.dart';
import 'package:story_app/data/models/api_state/api_state.dart';
import 'package:story_app/data/models/loading_state/loading_state.dart';
import 'package:story_app/data/models/login/login_request.dart';
import 'package:story_app/data/models/register/register_request.dart';

import '../data/api/auth_service.dart';
import '../data/db/auth_prefs.dart';
import '../data/models/login/login_result.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  final AuthPrefs authPrefs;

  ApiState loginState = const ApiState.initial();
  ApiState registerState = const ApiState.initial();
  DataState<LoginResult?> accountState = const DataState.loading();
  DataState logoutState = const DataState.loading();

  AuthProvider({
    required this.authService,
    required this.authPrefs,
  }) {
    _initLoginInfo();
  }

  Future<bool> login(LoginRequest loginRequest) async {
    loginState = const ApiState.loading();
    notifyListeners();

    final serverResponse = await authService.loginUser(loginRequest);
    if (!serverResponse.error) {
      await authPrefs.login();
      await authPrefs.saveLoginInfo(serverResponse.loginResult!);
    } else {
      loginState = ApiState.error(serverResponse.message);
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1500));
    }
    loginState = ApiState.loaded(serverResponse.loginResult);
    accountState = DataState.loaded(serverResponse.loginResult);

    notifyListeners();

    return await authPrefs.isLoggedIn();
  }

  Future<bool> register(RegisterRequest registerRequest) async {
    registerState = const ApiState.loading();
    notifyListeners();

    final serverResponse = await authService.registerUser(registerRequest);
    if (serverResponse.error) {
      registerState = ApiState.error(serverResponse.message);
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 1500));
    }

    registerState = ApiState.loaded(await authPrefs.getLoginInfo());
    notifyListeners();

    return !serverResponse.error;
  }

  Future<bool> logout() async {
    logoutState = const DataState.loading();
    notifyListeners();

    final logout = await authPrefs.logout();
    if (logout) {
      await authPrefs.deleteLoginInfo();
    }

    accountState = DataState.loaded(await authPrefs.getLoginInfo());
    logoutState = DataState.loaded(await authPrefs.getLoginInfo());
    notifyListeners();

    return !await authPrefs.isLoggedIn();
  }

  void _initLoginInfo() async {
    final loginInfo = await authPrefs.getLoginInfo();
    accountState = DataState.loaded(loginInfo);
    notifyListeners();
  }
}

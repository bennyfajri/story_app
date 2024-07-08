import 'package:flutter/material.dart';
import 'package:story_app/data/models/api_state/api_state.dart';
import 'package:story_app/data/models/loading_state/loading_state.dart';
import 'package:story_app/data/models/login/login_request.dart';
import 'package:story_app/data/models/register/register_request.dart';

import '../data/api/auth_service.dart';
import '../data/db/auth_prefs.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService;
  final AuthPrefs authPrefs;

  ApiState loginState = const ApiStateInitial();
  ApiState registerState = const ApiStateInitial();
  LoadingState accountState = const LoadingState.loaded();
  LoadingState logoutState = const LoadingState.loaded();

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
    accountState = LoadingState.loaded(serverResponse.loginResult);

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
    logoutState = const LoadingState.loading();
    notifyListeners();

    final logout = await authPrefs.logout();
    if (logout) {
      await authPrefs.deleteLoginInfo();
    }

    accountState = LoadingState.loaded(await authPrefs.getLoginInfo());
    logoutState = LoadingState.loaded(await authPrefs.getLoginInfo());
    notifyListeners();

    return !await authPrefs.isLoggedIn();
  }

  void _initLoginInfo() async {
    final loginInfo = await authPrefs.getLoginInfo();
    accountState = LoadingState.loaded(loginInfo);
    notifyListeners();
  }
}

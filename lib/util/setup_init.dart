import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/data/api/story_service.dart';
import 'package:story_app/provider/add_location_provider.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/settings_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/provider/take_image_provider.dart';
import 'package:story_app/routes/route_information_parser.dart';
import 'package:story_app/routes/router_delegate.dart';

import '../data/api/auth_service.dart';
import '../data/db/auth_prefs.dart';
import '../data/db/settings_prefs.dart';

GetIt getIt = GetIt.I;

void setupLocator() {
  final sharedPrefs = SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => Dio()..interceptors.add(LogInterceptor(requestBody: true)));
  getIt.registerLazySingleton(() => AuthService(client: getIt<Dio>()));
  getIt.registerLazySingleton(() => StoryService(client: getIt<Dio>()));
  getIt.registerLazySingleton(() {
    return AuthPrefs(sharedPreferences: sharedPrefs);
  });
  getIt.registerLazySingleton(() {
    return SettingPrefs(sharedPreferences: sharedPrefs);
  });
  getIt.registerLazySingleton(() => MyRoute(authPrefs: getIt.get<AuthPrefs>()));
  getIt.registerLazySingleton(() => MyRouteInformationParser());
  getIt.registerLazySingleton(() => AuthProvider(authService: getIt<AuthService>(), authPrefs: getIt<AuthPrefs>()));
  getIt.registerLazySingleton(() => SettingsProvider(settingPrefs: getIt<SettingPrefs>()));
  getIt.registerLazySingleton(() => StoryProvider(storyService: getIt<StoryService>(), authPrefs: getIt<AuthPrefs>()));
  getIt.registerLazySingleton(() => TakeImageProvider());
  getIt.registerLazySingleton(() => AddLocationProvider());
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/common.dart';
import 'package:story_app/data/api/auth_service.dart';
import 'package:story_app/data/db/auth_prefs.dart';
import 'package:story_app/data/db/settings_prefs.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/settings_provider.dart';
import 'package:story_app/provider/story_provider.dart';
import 'package:story_app/provider/take_image_provider.dart';
import 'package:story_app/routes/route_information_parser.dart';
import 'package:story_app/routes/router_delegate.dart';
import 'package:story_app/util/setup_init.dart';

import 'common/url_strategy.dart';

void main() {
  setupLocator();
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => authProvider),
        ChangeNotifierProvider(create: (context) => settingsProvider),
        ChangeNotifierProvider(create: (context) => storyProvider),
        ChangeNotifierProvider(create: (context) => takeImageProvider),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, provider, child) {
          return MaterialApp.router(
            routerDelegate: myRouterDelegate,
            locale: provider.locale,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationParser: myRouteInformationParser,
            backButtonDispatcher: RootBackButtonDispatcher(),
            theme: provider.themeData,
          );
        },
      ),
    );
  }
}

MyRouterDelegate get myRouterDelegate => getIt<MyRouterDelegate>();

AppLocalizations get appLocale => AppLocalizations.of(
    getIt<MyRouterDelegate>().navigatorKeys.currentContext!)!;

AuthService get authService => getIt<AuthService>();

AuthPrefs get authPrefs => getIt<AuthPrefs>();

SettingPrefs get settingPrefs => getIt<SettingPrefs>();

MyRouteInformationParser get myRouteInformationParser =>
    getIt<MyRouteInformationParser>();

AuthProvider get authProvider => getIt<AuthProvider>();

SettingsProvider get settingsProvider => getIt<SettingsProvider>();

StoryProvider get storyProvider => getIt<StoryProvider>();

TakeImageProvider get takeImageProvider => getIt<TakeImageProvider>();


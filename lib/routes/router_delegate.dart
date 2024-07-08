import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:story_app/data/db/auth_prefs.dart';
import 'package:story_app/data/models/page_config/page_configuration.dart';
import 'package:story_app/screen/add_story_screen.dart';
import 'package:story_app/screen/buy_premium_screen.dart';
import 'package:story_app/screen/home_screen.dart';
import 'package:story_app/screen/pick_location_screen.dart';

import '../screen/login_screen.dart';
import '../screen/register_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/story_detail_screen.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> navigatorKeys;
  final AuthPrefs authRepository;
  bool? isUnknown;

  MyRouterDelegate({
    required this.authRepository,
  }) : navigatorKeys = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => navigatorKeys;

  String? selectedStory;
  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isAddStory = false;
  bool isAddLocation = false;
  bool isRegister = false;
  bool isBuyPremium = false;

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == false) {
      historyStack = _loggedOutStack;
    } else {
      historyStack = _loggedInStack;
    }
    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister = false;
        isAddStory = false;
        if(isAddLocation) {
          isAddLocation = false;
          isAddStory = true;
        }
        isBuyPremium = false;
        selectedStory = null;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage ||
        configuration.isBuyPremiumPage) {
      isUnknown = false;
      selectedStory = null;
      isRegister = false;

      isAddLocation = false;
      isBuyPremium = false;
    } else if (configuration.isAddStoryPage) {
      isUnknown = false;
      selectedStory = null;
      isRegister = false;
      isAddStory = true;
      isAddLocation = false;
    }else if (configuration.isAddLocationPage) {
      isUnknown = false;
      selectedStory = null;
      isRegister = false;
      isAddStory = true;
      isAddLocation = isAddLocation;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      selectedStory = configuration.storyId.toString();
    } else {
      log(' Could not set new route');
    }
    notifyListeners();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isAddStory == true) {
      return PageConfiguration.addStory();
    } else if (isAddLocation == true) {
      return PageConfiguration.addLocation();
    } else if (isBuyPremium == true) {
      return PageConfiguration.buyPremium();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (selectedStory == null) {
      return PageConfiguration.home();
    } else if (selectedStory != null) {
      return PageConfiguration.detailStory(selectedStory!);
    } else {
      return null;
    }
  }

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashPage"),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey("LoginPage"),
          child: LoginScreen(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey("RegisterPage"),
            child: RegisterScreen(
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey("StoryListPage"),
          child: HomePage(
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
            onAddStory: () {
              isAddStory = true;
              notifyListeners();
            },
            onStoryClicked: (storyId) {
              selectedStory = storyId;
              notifyListeners();
            },
            onPremium: () {
              isBuyPremium = true;
              notifyListeners();
            },
          ),
        ),
        if (selectedStory != null)
          MaterialPage(
            key: ValueKey(selectedStory),
            child: StoryDetailScreen(
              storyId: selectedStory ?? "",
            ),
          ),
        if (isAddStory == true)
          MaterialPage(
            key: const ValueKey("AddStoryPage"),
            child: AddStoryScreen(
              onSuccessUpload: () {
                isAddStory = false;
                notifyListeners();
              },
              onAddLocation: () {
                isAddLocation = true;
                notifyListeners();
              },
            ),
          ),
        if (isAddLocation == true)
          MaterialPage(
            key: const ValueKey("AddLocationPage"),
            child: PickLocationScreen(
              onAdded: () {
                isAddLocation = false;
                notifyListeners();
              },
            ),
          ),
        if (isBuyPremium == true)
          MaterialPage(
            key: const ValueKey("BuyPremiumPage"),
            child: BuyPremiumScreen(
              onSuccess: () {
                isBuyPremium = false;
                notifyListeners();
              },
            ),
          ),
      ];
}

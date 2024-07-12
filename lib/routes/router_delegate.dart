import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/data/db/auth_prefs.dart';
import 'package:story_app/screen/add_story_screen.dart';
import 'package:story_app/screen/buy_premium_screen.dart';
import 'package:story_app/screen/home_screen.dart';
import 'package:story_app/screen/pick_location_screen.dart';

import '../screen/login_screen.dart';
import '../screen/register_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/story_detail_screen.dart';

class MyRoute {
  static String auth = "/auth";
  static String login = "login";
  static String register = "auths/register";

  static String home = "/";

  static String buyPremium = "/buy_premium";
  static String splash = "/splash";

  static String detailStory = "story/:storyId";
  static String addStory = "add_story";
  static String addLocation = "/add_location";

  static String toDetailStory(String storyId) => "/story/$storyId";

  static String toAddStory() => "/add_story";

  static String toSettingBuyPremium() => "/buy_premium";

  static String toLogin() => "/auth/login";

  static String toRegister() => "/auth/register";

  final AuthPrefs authPrefs;
  bool isLoggedIn = false;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  MyRoute({required this.authPrefs}) {
    _init();
  }

  GoRouter appRouter() => GoRouter(
        navigatorKey: navigatorKey,
        routes: <GoRoute>[
          GoRoute(
            path: splash,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: const SplashScreen(),
            ),
            redirect: (_, __) => isLoggedIn ? home : login,
          ),
          GoRoute(
              path: home,
              pageBuilder: (context, state) => FadeTransitionPage(
                    key: state.pageKey,
                    child: HomePage(
                      onAddStory: () => context.go(toAddStory()),
                      onPremium: () => context.go(toSettingBuyPremium()),
                      onLogout: () => context.go(toLogin()),
                      onStoryClicked: (id) => context.go(toDetailStory(id)),
                    ),
                  ),
              routes: [
                GoRoute(
                  path: detailStory,
                  pageBuilder: (context, state) => FadeTransitionPage(
                    key: state.pageKey,
                    child: StoryDetailScreen(
                      storyId: state.pathParameters['storyId']!,
                    ),
                  ),
                ),
                GoRoute(
                  path: addStory,
                  pageBuilder: (context, state) => FadeTransitionPage(
                    key: state.pageKey,
                    child: AddStoryScreen(
                      onAddLocation: () {},
                      onSuccessUpload: () {},
                    ),
                  ),
                ),
              ]),
          GoRoute(
            path: auth,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: LoginScreen(
                onLogin: () => context.go(home),
                onRegister: () => context.push(toRegister()),
              ),
            ),
            routes: [
              GoRoute(
                path: register,
                pageBuilder: (context, state) => FadeTransitionPage(
                  key: state.pageKey,
                  child: RegisterScreen(
                    onLogin: () => context.go(auth),
                    onRegister: () {},
                  ),
                ),
              ),
            ],
          ),
          GoRoute(
            path: addLocation,
            pageBuilder: (context, state) => FadeTransitionPage(
              key: state.pageKey,
              child: PickLocationScreen(
                onAdded: () {},
              ),
            ),
          ),
          GoRoute(
            path: buyPremium,
            pageBuilder: (pageContext, state) => FadeTransitionPage(
              key: state.pageKey,
              child: BuyPremiumScreen(onSuccess: () {}),
            ),
          ),
        ],
        redirect: _guard,
        debugLogDiagnostics: true,
      );

  Future<String?> _guard(BuildContext context, GoRouterState state) async {
    final bool signedIn = await authPrefs.isLoggedIn();
    final bool signingIn = state.matchedLocation == auth;

    if (!signingIn && !signedIn) {
      return auth;
    } else if (signingIn && signedIn) {
      return home;
    }

    return null;
  }

  void _init() async {
    isLoggedIn = await authPrefs.isLoggedIn();
  }
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child) =>
              FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

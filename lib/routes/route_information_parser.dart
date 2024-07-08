import 'package:story_app/data/models/page_config/page_configuration.dart';
import 'package:flutter/widgets.dart';

class MyRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.uri.toString());

    if (uri.pathSegments.isEmpty) {
      return PageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      switch (first) {
        case 'home':
          return PageConfiguration.home();
        case 'login':
          return PageConfiguration.login();
        case 'add':
          return PageConfiguration.addStory();
        case 'upgrade_user':
          return PageConfiguration.buyPremium();
        case 'register':
          return PageConfiguration.register();
        case 'splash':
          return PageConfiguration.splash();
        default:
          return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      if (first == 'story') {
        return PageConfiguration.detailStory(second);
      } else if (first == 'add' && second == 'location') {
        return PageConfiguration.addLocation();
      } else {
        return PageConfiguration.unknown();
      }
    } else {
      return PageConfiguration.unknown();
    }
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    if (configuration.isUnknownPage) {
      return RouteInformation(uri: Uri.parse('/unknown'));
    } else if (configuration.isSplashPage) {
      return RouteInformation(uri: Uri.parse('/splash'));
    } else if (configuration.isRegisterPage) {
      return RouteInformation(uri: Uri.parse('/register'));
    } else if (configuration.isLoginPage) {
      return RouteInformation(uri: Uri.parse('/login'));
    } else if (configuration.isAddStoryPage) {
      return RouteInformation(uri: Uri.parse('/add'));
    } else if (configuration.isAddLocationPage) {
      return RouteInformation(uri: Uri.parse('/add/location'));
    } else if (configuration.isBuyPremiumPage) {
      return RouteInformation(uri: Uri.parse('/upgrade_user'));
    } else if (configuration.isHomePage) {
      return RouteInformation(uri: Uri.parse('/'));
    } else if (configuration.isDetailPage) {
      return RouteInformation(
        uri: Uri.parse('/story/${configuration.storyId}'),
      );
    } else {
      return null;
    }
  }
}

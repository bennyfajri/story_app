class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;
  final bool? addStory;
  final bool? addLocation;
  final bool? buyPremium;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        addStory = null,
        addLocation = null,
        buyPremium = null,
        storyId = null;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        addStory = null,
        addLocation = null,
        buyPremium = null,
        storyId = null;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        addStory = null,
        addLocation = null,
        buyPremium = null,
        storyId = null;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = false,
        addLocation = false,
        buyPremium = false,
        storyId = null;

  PageConfiguration.addStory()
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = true,
        addLocation = false,
        buyPremium = false,
        storyId = null;

  PageConfiguration.addLocation()
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = true,
        addLocation = true,
        buyPremium = false,
        storyId = null;

  PageConfiguration.buyPremium()
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = false,
        addLocation = false,
        buyPremium = true,
        storyId = null;

  PageConfiguration.detailStory(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = false,
        addLocation = false,
        buyPremium = false,
        storyId = id;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        addStory = null,
        addLocation = null,
        buyPremium = null,
        storyId = null;

  bool get isSplashPage => unknown == false && loggedIn == null;

  bool get isLoginPage => unknown == false && loggedIn == false;

  bool get isHomePage =>
      unknown == false &&
      loggedIn == true &&
      addStory == false &&
      storyId == null;

  bool get isAddStoryPage =>
      unknown == false &&
      loggedIn == true &&
      addStory == true &&
      buyPremium == false &&
      storyId == null;

  bool get isAddLocationPage =>
      unknown == false &&
      loggedIn == true &&
      addStory == true &&
      addLocation == true &&
      buyPremium == false &&
      storyId == null;

  bool get isBuyPremiumPage =>
      unknown == false &&
      loggedIn == true &&
      buyPremium == true &&
      storyId == null;

  bool get isDetailPage =>
      unknown == false &&
      loggedIn == true &&
      addStory == false &&
      storyId != null;

  bool get isRegisterPage => register == true;

  bool get isUnknownPage => unknown == true;
}

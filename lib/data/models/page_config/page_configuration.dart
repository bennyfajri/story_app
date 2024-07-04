class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;
  final bool? addStory;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        addStory = null,
        storyId = null;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        addStory = null,
        storyId = null;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        addStory = null,
        storyId = null;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = false,
        storyId = null;

  PageConfiguration.addStory()
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = true,
        storyId = null;

  PageConfiguration.detailStory(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        addStory = false,
        storyId = id;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        addStory = null,
        storyId = null;

  bool get isSplashPage => unknown == false && loggedIn == null;

  bool get isLoginPage => unknown == false && loggedIn == false;

  bool get isHomePage =>
      unknown == false && loggedIn == true && addStory == false && storyId == null;

  bool get isAddStoryPage =>
      unknown == false && loggedIn == true && addStory == true && storyId == null;

  bool get isDetailPage =>
      unknown == false && loggedIn == true && addStory == false && storyId != null;

  bool get isRegisterPage => register == true;

  bool get isUnknownPage => unknown == true;
}

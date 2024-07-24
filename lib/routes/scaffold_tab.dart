import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/my_app.dart';

enum ScaffoldTab {
  home,
  settings,
}

class StoryScaffold extends StatelessWidget {
  const StoryScaffold({
    super.key,
    required this.child,
    required this.selectedTab,
  });

  final Widget child;
  final ScaffoldTab selectedTab;

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      body: child,
      selectedIndex: selectedTab.index,
      onDestinationSelected: (value) {
        switch (ScaffoldTab.values[value]) {
          case ScaffoldTab.home:
            context.go('/home');
            break;
          case ScaffoldTab.settings:
            context.go('/settings');
            break;
        }
      },
      destinations: [
        AdaptiveScaffoldDestination(title: appLocale.home_title, icon: Icons.home_rounded),
        AdaptiveScaffoldDestination(title: appLocale.settings_title, icon: Icons.settings),
      ],
    );
  }
}

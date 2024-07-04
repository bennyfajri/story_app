import 'package:flutter/material.dart';
import 'package:story_app/main.dart';
import 'package:story_app/screen/account_screen.dart';
import 'package:story_app/screen/story_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.onAddStory,
    required this.onLogout,
    required this.onStoryClicked,
  });

  final VoidCallback onAddStory;
  final VoidCallback onLogout;
  final Function(String) onStoryClicked;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  var _screens = <Widget>[];

  final _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.home_filled),
      label: appLocale.home_title,
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.settings),
      label: appLocale.settings_title,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      StoryListScreen(
        onAddStory: widget.onAddStory,
        onStoryClicked: widget.onStoryClicked,
      ),
      AccountScreen(
        onLogout: widget.onLogout,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).textTheme.headlineMedium?.color,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:story_app/util/setup_init.dart';


import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  usePathUrlStrategy();
  runApp(const MyApp());
}


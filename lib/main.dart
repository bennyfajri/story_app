import 'package:flutter/material.dart';
import 'package:story_app/util/setup_init.dart';

import 'common/url_strategy_other.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  usePathUrlStrategy();
  runApp(const MyApp());
}


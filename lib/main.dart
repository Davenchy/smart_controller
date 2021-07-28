import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:smart_controller/desktop/screens/home_screen.dart' as Desktop;
import 'package:smart_controller/mobile/screens/home_screen.dart' as Mobile;
import 'package:smart_controller/desktop/utils/desktop.dart';
import 'package:smart_controller/core/utils/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux) {
    await setupDesktopWindow();
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Controller',
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: Platform.isLinux ? Desktop.HomeScreen() : Mobile.HomeScreen(),
    );
  }
}

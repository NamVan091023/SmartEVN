import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:pollution_environment/src/screen/splash/splash_screen.dart';
import 'package:pollution_environment/src/commons/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // bool isOpened = PreferenceUtils.getBool("isOpened", true);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return GetMaterialApp(
      theme: theme(),
      home: SplashScreen(),
    );
  }
}

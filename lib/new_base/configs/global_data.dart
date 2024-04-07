import 'package:flutter/material.dart';

class GlobalData{
  GlobalData._privateConstructor();
  static final GlobalData instance = GlobalData._privateConstructor();

  final navigatorKey = GlobalKey<NavigatorState>();
}
import 'package:flutter/material.dart';

import '../main.dart';

class AppUtil {
  static void dismissKeyboard() {
    FocusScope.of(navigatorKey.currentContext!).requestFocus(FocusNode());
  }
}

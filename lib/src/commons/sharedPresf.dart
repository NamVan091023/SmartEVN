import 'dart:async' show Future, FutureOr;

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static bool getBool(String key, [bool? defaultValue]) {
    return _prefsInstance!.get(key) as bool? ?? defaultValue ?? true;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static int getInt(String key, [int? defaultValues]) {
    return _prefsInstance!.getInt(key) ?? defaultValues ?? 0;
  }

  static Future<int> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value) as FutureOr<int>? ?? Future.value(0);
  }
}

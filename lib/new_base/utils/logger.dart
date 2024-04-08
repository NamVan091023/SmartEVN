import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

var logger = MyLogger();

class MyLogger {
  /// Log a message at level verbose.
  void v(dynamic message) {
    _log("🤍 VERBOSE: $message");
  }

  /// Log a message at level debug.
  void d(dynamic message) {
    _log("💙 DEBUG: $message");
  }

  /// Log a message at level info.
  void i(dynamic message) {
    _log("💚 INFO: $message");
  }

  /// Log a message at level warning.
  void w(dynamic message) {
    _log("💛 WARNING: $message");
  }

  /// Log a message at level error.
  void e(dynamic message, {StackTrace? stackTrace}) {
    _print("❤️ ERROR: $message", stackTrace: stackTrace);
  }

  void _print(dynamic message, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      print("$message \n ${stackTrace ?? ''}");
    }
  }

  void _log(dynamic message) {
    if (kDebugMode) {
      developer.log("$message");
    }
  }

  void log(dynamic message,
      {bool printFullText = false, StackTrace? stackTrace}) {
    if (printFullText) {
      _log(message);
    } else {
      _print(message);
    }
    if (stackTrace != null) {
      _print(stackTrace);
    }
  }
}

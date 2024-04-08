import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;

  void onSavePassword(String value) {
    password.value = value;
  }

  String? onValidatorPassword(String value) {
    if (value.isEmpty) {
      return "Password cannot be empty";
    }
    return null;
  }

  void onSaveEmail(String value) {
    email.value = value;
  }

  void onChangeEmail(String value) {
    return;
  }

  String? onValidatorEmail(String value) {
    if (value.isEmpty) {
      return "Email cannot be empty";
    } else if (!GetUtils.isEmail(value)) {
      return "Invalid email format";
    }
    return null;
  }
}

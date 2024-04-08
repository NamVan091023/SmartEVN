import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
=======
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/new_base/models/entities/user_response.dart';

import '../services/commons/constants.dart';
import '../services/commons/helper.dart';
import '../services/network/apis/users/auth_api.dart';
>>>>>>> origin/feature/hiep-create-base

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

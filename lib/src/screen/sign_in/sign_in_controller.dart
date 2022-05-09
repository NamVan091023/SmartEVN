import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';

class SignInController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool remember = false.obs;
  final Box box = Hive.box(HIVEBOX);

  @override
  void onInit() {
    remember.value = box.get(KEY_REMEMBER_LOGIN, defaultValue: false);
    super.onInit();
  }

  void setRemember(bool value) {
    remember.value = value;
  }

  void onSavePassword(String value) {
    password.value = value;
  }

  String? onValidatorPassword(String value) {
    if (value.isEmpty) {
      return kPassNullError;
    }
    return null;
  }

  void onSaveEmail(String value) {
    email.value = value;
  }

  void onChangeEmail(String value) {
    return null;
  }

  String? onValidatorEmail(String value) {
    if (value.isEmpty) {
      return kEmailNullError;
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      return kInvalidEmailError;
    }
    return null;
  }

  Future<void> loginUser(Function onSuccess, Function(String) onError) async {
    showLoading(text: "Đang đăng nhập");
    AuthApi().login(email.value, password.value).then((response) async {
      hideLoading();
      debugPrint("Login success $response");
      UserModel? user = response.user;
      if (user != null) {
        box.put(KEY_REMEMBER_LOGIN, remember.value);

        if (remember.value == true) {
          box.put(KEY_EMAIL, email.value);
          box.put(KEY_PASSWORD, password.value);
        } else {
          box.delete(KEY_EMAIL);
          box.delete(KEY_PASSWORD);
        }

        await UserStore().saveAuth(response);
        onSuccess();
      } else {
        onError("Không lấy được thông tin người dùng");
      }
    });
  }
}

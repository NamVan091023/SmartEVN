import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';

class SignInController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool remember = PreferenceUtils.getBool(KEY_REMEMBER_LOGIN).obs;
  RxList<String?> errors = RxList<String?>();

  void setRemember(bool value) {
    remember.value = value;
  }

  void addError({String? error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  void onSavePassword(String value) {
    password.value = value;
  }

  void onChangePassword(String value) {
    if (value.isNotEmpty) {
      removeError(error: kPassNullError);
    } else if (value.length >= 8) {
      removeError(error: kShortPassError);
    }
    return null;
  }

  String? onValidatorPassword(String value) {
    if (value.isEmpty) {
      addError(error: kPassNullError);
      return "";
    }
    return null;
  }

  void onSaveEmail(String value) {
    email.value = value;
  }

  void onChangeEmail(String value) {
    if (value.isNotEmpty) {
      removeError(error: kEmailNullError);
    }
    if (emailValidatorRegExp.hasMatch(value)) {
      removeError(error: kInvalidEmailError);
    }
    return null;
  }

  String? onValidatorEmail(String value) {
    if (value.isEmpty) {
      addError(error: kEmailNullError);
      return "";
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      addError(error: kInvalidEmailError);
      return "";
    }
    return null;
  }

  Future<void> loginUser(Function onSuccess, Function(String) onError) async {
    showLoading(text: "Đang đăng nhập");
    UserApi().login(email.value, password.value).then((response) {
      hideLoading();
      debugPrint("Login success $response");
      UserModel? user = response.user;
      if (user != null) {
        String? refreshToken = response.tokens?.refresh?.token;
        String? accessToken = response.tokens?.access?.token;
        if (refreshToken != null) {
          PreferenceUtils.setString(KEY_REFRESH_TOKEN, refreshToken);
        }
        if (accessToken != null) {
          PreferenceUtils.setString(KEY_ACCESS_TOKEN, accessToken);
        }

        PreferenceUtils.setBool(KEY_REMEMBER_LOGIN, remember.value);

        if (remember.value == true) {
          PreferenceUtils.setString(KEY_EMAIL, email.value);
          PreferenceUtils.setString(KEY_PASSWORD, password.value);
        } else {
          PreferenceUtils.remove(KEY_EMAIL);
          PreferenceUtils.remove(KEY_PASSWORD);
        }
        onSuccess();
      } else {
        onError("Không lấy được thông tin người dùng");
      }
    }, onError: (exception) {
      hideLoading();
      debugPrint(exception.message);
      onError(exception.message ?? "Đăng nhập không thành công");
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';

class SignUpController extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString conformPassword = "".obs;
  RxBool remember = false.obs;

  void saveConformPass(String value) {
    conformPassword.value = value;
  }

  void changeConformPass(String value) {
    conformPassword.value = value;
  }

  String? validatorConformPass(String value) {
    if (value.isEmpty) {
      return kPassNullError;
    } else if ((password.value != value)) {
      return kMatchPassError;
    }
    return null;
  }

  void savePassword(String value) {
    password.value = value;
  }

  void changePassword(String value) {
    password.value = value;
  }

  String? validatorPassword(String value) {
    if (value.isEmpty) {
      return kPassNullError;
    } else if (value.length < 6) {
      return kShortPassError;
    }
    return null;
  }

  void saveEmail(String value) {
    email.value = value;
  }

  void changeEmail(String value) {
    email.value = value;
  }

  String? validatorEmail(String value) {
    if (value.isEmpty) {
      return kEmailNullError;
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      return kInvalidEmailError;
    }
    return null;
  }

  void saveName(String value) {
    name.value = value;
  }

  void changeName(String value) {
    name.value = value;
  }

  String? validatorName(String value) {
    if (value.isEmpty) {
      return kNamelNullError;
    }
    return null;
  }

  Future<void> registerUser(
      Function onSuccess, Function(String) onError) async {
    showLoading(text: "Đang đăng ký...");
    AuthApi().register(name.value, email.value, password.value).then(
        (response) {
      hideLoading();
      debugPrint("Register success $response");
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

        PreferenceUtils.setBool(KEY_REMEMBER_LOGIN, true);
        PreferenceUtils.setString(KEY_USER_ID, user.id!);

        PreferenceUtils.setString(KEY_EMAIL, email.value);
        PreferenceUtils.setString(KEY_PASSWORD, password.value);

        if (user.role == 'admin') {
          PreferenceUtils.setBool(KEY_IS_ADMIN, true);
        } else {
          PreferenceUtils.setBool(KEY_IS_ADMIN, false);
        }

        onSuccess();
      } else {
        onError("Không lấy được thông tin người dùng");
      }
    }, onError: (exception) {
      hideLoading();
      debugPrint(exception.message);
      onError(exception.message ?? "Đăng ký không thành công");
    });
  }
}

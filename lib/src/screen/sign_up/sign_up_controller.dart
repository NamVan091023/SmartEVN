import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';

class SignUpController extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  RxString conformPassword = "".obs;
  RxBool remember = false.obs;
  final RxList<String?> errors = RxList<String?>();

  void addError({String? error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
  }

  void saveConformPass(String value) {
    conformPassword.value = value;
  }

  void changeConformPass(String value) {
    if (value.isNotEmpty) {
      removeError(error: kPassNullError);
    }
    if (value.isNotEmpty && password == conformPassword) {
      removeError(error: kMatchPassError);
    }
    conformPassword.value = value;
  }

  String? validatorConformPass(String value) {
    if (value.isEmpty) {
      addError(error: kPassNullError);
      return "";
    } else if ((password.value != value)) {
      addError(error: kMatchPassError);
      return "";
    }
    return null;
  }

  void savePassword(String value) {
    password.value = value;
  }

  void changePassword(String value) {
    if (value.isNotEmpty) {
      removeError(error: kPassNullError);
    }
    if (value.length >= 8) {
      removeError(error: kShortPassError);
    }
    password.value = value;
  }

  String? validatorPassword(String value) {
    if (value.isEmpty) {
      addError(error: kPassNullError);
      return "";
    } else if (value.length < 6) {
      addError(error: kShortPassError);
      return "";
    }
    return null;
  }

  void saveEmail(String value) {
    email.value = value;
  }

  void changeEmail(String value) {
    if (value.isNotEmpty) {
      removeError(error: kEmailNullError);
    }
    if (emailValidatorRegExp.hasMatch(value)) {
      removeError(error: kInvalidEmailError);
    }
    return null;
  }

  String? validatorEmail(String value) {
    if (value.isEmpty) {
      addError(error: kEmailNullError);
      return "";
    } else if (!emailValidatorRegExp.hasMatch(value)) {
      addError(error: kInvalidEmailError);
      return "";
    }
    return null;
  }

  void saveName(String value) {
    name.value = value;
  }

  void changeName(String value) {
    if (value.isNotEmpty) {
      removeError(error: kNamelNullError);
    }
    return null;
  }

  String? validatorName(String value) {
    if (value.isEmpty) {
      addError(error: kNamelNullError);
      return "";
    }
    return null;
  }

  Future<void> registerUser(
      Function onSuccess, Function(String) onError) async {
    showLoading(text: "Đang đăng ký...");
    UserApi().register(name.value, email.value, password.value).then(
        (response) {
      hideLoading();
      debugPrint("Register success $response");
      UserModel? user = response.user;
      if (user != null) {
        // PreferenceUtils.setBool(
        //     KEY_IS_ADMIN, user.role == 'admin' ? true : false);
        // PreferenceUtils.setString(KEY_EMAIL, user.email!);
        // PreferenceUtils.setBool(KEY_IS_LOGIN, true);
        // PreferenceUtils.setString("user", user);
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

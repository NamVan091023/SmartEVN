import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:pollution_environment/src/commons/constants.dart';

class SignInController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;
  RxBool remember = false.obs;
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
}

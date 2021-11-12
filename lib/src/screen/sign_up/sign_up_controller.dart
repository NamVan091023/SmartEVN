import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:pollution_environment/src/commons/constants.dart';

class SignUpController extends GetxController {
  RxString email = "".obs;
  RxString password = "".obs;
  RxString conformPassword = "".obs;
  RxBool remember = false.obs;
  final RxList<String> errors = RxList<String>();
  void addError({String error}) {
    if (!errors.contains(error)) errors.add(error);
  }

  void removeError({String error}) {
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

  String validatorConformPass(String value) {
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

  String validatorPassword(String value) {
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

  String validatorEmail(String value) {
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

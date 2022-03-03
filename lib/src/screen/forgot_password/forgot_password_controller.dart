import 'package:get/state_manager.dart';
import 'package:pollution_environment/src/commons/constants.dart';

class ForgotPasswordController extends GetxController {
  RxList<String> errors = RxList<String>();
  late RxString email;

  void onSave(String value) {
    email.value = value;
  }

  void onChange(String value) {
    if (value.isNotEmpty && errors.contains(kEmailNullError)) {
      errors.remove(kEmailNullError);
    } else if (emailValidatorRegExp.hasMatch(value) &&
        errors.contains(kInvalidEmailError)) {
      errors.remove(kInvalidEmailError);
    }
    return null;
  }

  String? onValidator(String value) {
    if (value.isEmpty && !errors.contains(kEmailNullError)) {
      errors.add(kEmailNullError);
    } else if (!emailValidatorRegExp.hasMatch(value) &&
        !errors.contains(kInvalidEmailError)) {
      errors.add(kInvalidEmailError);
    }
    return null;
  }
}

import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';

class EditProfileController extends GetxController {
  Rx<UserModel> userModel = (Get.arguments as UserModel).obs;
  Rxn<File> image = Rxn<File>();
  Rxn<String> password = Rxn<String>();
  Rxn<String> rePassword = Rxn<String>();
  Rxn<String> email = Rxn<String>();
  Rxn<String> name = Rxn<String>();
  @override
  void onInit() {
    email.value = userModel.value.email;
    name.value = userModel.value.name;
    super.onInit();
  }

  Future<void> updateUser() async {
    if (userModel.value.id != null) {
      showLoading();
      UserAPI()
          .updateUser(
              id: userModel.value.id!,
              email: email.value,
              name: name.value,
              password: password.value,
              avatar: image.value)
          .then((value) {
        hideLoading();
        Get.back();
        Fluttertoast.showToast(msg: "Cập nhật hồ sơ thành công");
      }, onError: (e) {
        hideLoading();
        showAlertError(desc: e.message);
      });
    }
  }
}

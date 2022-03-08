import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';

class OtherProfileController extends GetxController {
  String userId = Get.arguments;
  Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() async {
    user.value = await UserAPI().getUserById(userId);
  }

  void deleteUser() async {
    showLoading();
    UserAPI().deleteUser(id: userId).then((value) {
      hideLoading();
      Fluttertoast.showToast(msg: value.message ?? "Xóa người dùng thành công");

      Get.back();
    }).onError((error, stackTrace) {
      hideLoading();
    });
  }
}

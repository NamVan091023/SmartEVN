import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/commons/theme.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';

class ProfileController extends GetxController {
  late String userId = Get.arguments ?? PreferenceUtils.getString(KEY_USER_ID);
  Rxn<UserModel> user = Rxn<UserModel>();
  Rx<String?> themeMode =
      (PreferenceUtils.getString(KEY_THEME_MODE) ?? "system").obs;
  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  void getUser() async {
    user.value = await UserAPI().getUserById(userId);
  }

  void updateNotificationReceived(bool isReceived) async {
    user.value = await UserAPI()
        .updateNotificationReceived(id: userId, isReceived: isReceived);
  }

  void changeThemeMode(value) {
    themeMode.value = value;
    Get.changeThemeMode(getThemeMode(value));

    PreferenceUtils.setString(KEY_THEME_MODE, value ?? "system");
  }
}

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/theme.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';

class ProfileController extends GetxController {
  late String userId;
  Box box = Hive.box(HIVEBOX);
  Rxn<UserModel> user = Rxn<UserModel>();
  Rx<String?> themeMode = "system".obs;
  @override
  void onInit() {
    themeMode.value = box.get(KEY_THEME_MODE, defaultValue: "system");
    super.onInit();
    getCurrentUser();
  }

  void getCurrentUser() async {
    AuthResponse? auth = await UserStore().getAuth();
    userId = auth?.user?.id ?? "";
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
    box.put(KEY_THEME_MODE, value ?? "system");
  }
}

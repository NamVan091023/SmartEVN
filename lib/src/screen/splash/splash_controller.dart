import 'dart:async';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/location_service.dart';
import 'package:pollution_environment/src/model/token_response.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';

class SplashController extends GetxController {
  late Timer _timer;
  int _start = 3;
  var currentPage = 0.obs;
  final Box box = Hive.box(HIVEBOX);
  @override
  void onInit() {
    super.onInit();
    LocationService().determinePosition();
    startTimer();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setPage(int page) {
    currentPage.value = page;
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 2);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          _timer.cancel();
          checkAccessPermission();
        } else {
          setPage(3 - _start);
          _start--;
        }
      },
    );
  }

  void checkAccessPermission() async {
    bool isRememberLogin = box.get(KEY_REMEMBER_LOGIN, defaultValue: false);
    if (isRememberLogin) {
      AuthResponse? currentUser = await UserStore().getAuth();
      String? refreshToken = currentUser?.tokens?.refresh?.token;
      if (refreshToken == null) {
        Get.offAllNamed(Routes.LOGIN_SCREEN);
      } else {
        showLoading();
        try {
          TokensResponse tokenResponse =
              await AuthApi().refreshToken(refreshToken);
          String? newAccessToken = tokenResponse.access?.token;
          String? newRefreshToken = tokenResponse.refresh?.token;

          hideLoading();
          if (newAccessToken != null && newRefreshToken != null) {
            currentUser?.tokens = tokenResponse;
            if (currentUser != null) {
              UserStore().saveAuth(currentUser);
            }
            Get.offAllNamed(Routes.HOME_SCREEN);
          } else {
            Get.offAllNamed(Routes.LOGIN_SCREEN);
          }
        } catch (e) {
          hideLoading();
          Get.offAllNamed(Routes.LOGIN_SCREEN);
        }
      }
    } else {
      Get.offAllNamed(Routes.LOGIN_SCREEN);
    }
  }

  void stopTimer() {
    _timer.cancel();
  }
}

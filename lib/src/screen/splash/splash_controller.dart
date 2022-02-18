import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/model/token_response.dart';
import 'package:pollution_environment/src/network/apis/users/user_api.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';

class SplashController extends GetxController {
  late Timer _timer;
  int _start = 3;
  var currentPage = 0.obs;
  @override
  void onInit() {
    _determinePosition();
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setPage(int page) {
    currentPage.value = page;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
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
    bool isRememberLogin = PreferenceUtils.getBool(KEY_REMEMBER_LOGIN);
    if (isRememberLogin) {
      String? refreshToken = PreferenceUtils.getString(KEY_REFRESH_TOKEN);
      if (refreshToken == null) {
        Get.offAllNamed(Routes.LOGIN_SCREEN);
      } else {
        showLoading();
        try {
          TokensResponse tokenResponse =
              await UserApi().refreshToken(refreshToken);
          String? newAccessToken = tokenResponse.access?.token;
          String? newRefreshToken = tokenResponse.refresh?.token;

          hideLoading();
          if (newAccessToken != null && newRefreshToken != null) {
            PreferenceUtils.setString(KEY_ACCESS_TOKEN, newAccessToken);
            PreferenceUtils.setString(KEY_REFRESH_TOKEN, newRefreshToken);
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

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'location_callback_handler.dart';

class LocationBackground {
  static Future<void> initPlatformState() async {
    WidgetsFlutterBinding.ensureInitialized();
    print('Initializing...');
    await BackgroundLocator.initialize();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    print('Running ${_isRunning.toString()}');
    onStart();
  }

  static void onStart() async {
    if (await checkLocationPermission()) {
      await startLocator();
    } else {
      // show error
    }
  }

  static Future<bool> checkLocationPermission() async {
    final access = await Permission.location.status;
    switch (access) {
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await Permission.location.request();
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      case PermissionStatus.granted:
        return true;
      default:
        return false;
    }
  }

  static Future<void> startLocator() async {
    await BackgroundLocator.unRegisterLocationUpdate();

    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 20),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            // interval: 15 * 60,
            // distanceFilter: 20,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle:
                    'Sử dụng GPS để nhận thông tin ô nhiễm gần bạn',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Vị trí nền được bật để giữ cho ứng dụng cập nhật chính xác thông tin ô nhiễm gần vị trí của bạn.',
                notificationIconColor: Colors.green,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }
}

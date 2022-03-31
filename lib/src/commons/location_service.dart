import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();

  factory LocationService() {
    return _singleton;
  }

  LocationService._internal();

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Get.defaultDialog(
          title: "Thông báo",
          content: Text(
              "Dịch vụ truy cập vị trí đang tắt, các chức năng hoạt động sẽ bị giới hạn"),
          textConfirm: "Mở cài đặt",
          onConfirm: () {
            Geolocator.openLocationSettings();
            Get.back();
          });

      // showAlertError(
      //     desc:
      //         "Dịch vụ truy cập vị trí đang tắt, các chức năng hoạt động sẽ bị giới hạn");
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
        showAlertError(
            desc:
                "Quyền truy cập vị trí đã bị từ chối, các chức năng hoạt động sẽ bị giới hạn");
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showAlertError(
          desc:
              "Quyền truy cập vị trí đã bị từ chối, các chức năng hoạt động sẽ bị giới hạn");

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/generated/assets.dart';
import 'dart:convert';

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- Parse json from: $assetsPath');
  return rootBundle
      .loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}

Future<ui.Image> getImageFromPath(String imagePath) async {
  ByteData bytes = await rootBundle.load(imagePath);

  Uint8List imageBytes = bytes.buffer.asUint8List();

  final Completer<ui.Image> completer = new Completer();

  ui.decodeImageFromList(imageBytes, (ui.Image img) {
    return completer.complete(img);
  });

  return completer.future;
}

Color getQualityColor(int quality) {
  switch (quality) {
    case 6:
      return Colors.green;
    case 5:
      return Colors.lime;
    case 4:
      return Colors.orange;
    case 3:
      return Colors.red;
    case 2:
      return Colors.pink;
    case 1:
      return Colors.purple;
    default:
      return Colors.green;
  }
}

String? getAssetPollution(String pollution) {
  switch (pollution) {
    case "air":
      return Assets.iconPinAir;
    case "land":
      return Assets.iconPinLand;
    case "sound":
      return Assets.iconPinSound;
    case "water":
      return Assets.iconPinWater;
    default:
      return null;
  }
}

void showAlertError(
    {String title = "Thông báo", required String desc, Function? onConfirm}) {
  Get.defaultDialog(
    title: title,
    content: Text(
      desc,
      textAlign: TextAlign.center,
    ),
    titlePadding: EdgeInsets.all(10),
    contentPadding: EdgeInsets.all(10),
    radius: 10,
    onConfirm: () => onConfirm ?? Get.back(),
    textConfirm: "Đồng ý",
  );
}

void showLoading({String? text, double? progress}) {
  if (progress != null) {
    EasyLoading.showProgress(progress, status: text);
  } else {
    EasyLoading.show(status: text);
  }
}

void hideLoading() {
  EasyLoading.dismiss();
}

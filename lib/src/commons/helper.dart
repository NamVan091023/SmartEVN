import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/generated/assets.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

Color getQualityColor(int? quality) {
  switch (quality) {
    case 6:
      return Colors.green;
    case 5:
      return Colors.yellow;
    case 4:
      return Colors.orange;
    case 3:
      return Colors.red;
    case 2:
      return Colors.purple;
    case 1:
      return Colors.brown.shade900;
    default:
      return Colors.green;
  }
}

String getQualityText(int? quality) {
  switch (quality) {
    case 6:
      return "Tốt";
    case 5:
      return "Trung bình";
    case 4:
      return "Kém";
    case 3:
      return "Xấu";
    case 2:
      return "Rất xấu";
    case 1:
      return "Nguy hại";
    default:
      return "";
  }
}

String getAssetPollution(String? pollution) {
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
      return Assets.iconLogo;
  }
}

String getAssetAQI(int quality) {
  switch (quality) {
    case 1:
      return Assets.iconAQI1;
    case 2:
      return Assets.iconAQI2;
    case 3:
      return Assets.iconAQI3;
    case 4:
      return Assets.iconAQI4;
    case 5:
      return Assets.iconAQI5;
    case 6:
      return Assets.iconAQI6;
    default:
      return Assets.iconAQI6;
  }
}

String getNamePollution(String? pollution) {
  switch (pollution) {
    case "air":
      return "Ô nhiễm không khí";
    case "land":
      return "Ô nhiễm đất";
    case "sound":
      return "Ô nhiễm tiếng ồn";
    case "water":
      return "Ô nhiễm nước";
    default:
      return "";
  }
}

String getShortNamePollution(String? pollution) {
  switch (pollution) {
    case "air":
      return "Không khí";
    case "land":
      return "Đất";
    case "sound":
      return "Tiếng ồn";
    case "water":
      return "Nước";
    default:
      return "";
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

String? convertDate(String date) {
  try {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  } catch (e) {
    return "";
  }
}

String timeAgoSinceDate({bool numericDates = true, required String dateStr}) {
  DateTime date = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateStr);
  final date2 = DateTime.now().toLocal();
  final difference = date2.difference(date);

  if (difference.inSeconds < 5) {
    return 'Vừa xong';
  } else if (difference.inSeconds <= 60) {
    return '${difference.inSeconds} giây trước';
  } else if (difference.inMinutes <= 1) {
    return (numericDates) ? '1 phút trước' : 'Một phút trước';
  } else if (difference.inMinutes <= 60) {
    return '${difference.inMinutes} phút trước';
  } else if (difference.inHours <= 1) {
    return (numericDates) ? '1 giờ trước' : 'Một giờ trước';
  } else if (difference.inHours <= 60) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inDays <= 1) {
    return (numericDates) ? '1 ngày trước' : 'Hôm qua';
  } else if (difference.inDays <= 6) {
    return '${difference.inDays} ngày trước';
  } else if ((difference.inDays / 7).ceil() <= 1) {
    return (numericDates) ? '1 tuần trước' : 'Tuần trước';
  } else if ((difference.inDays / 7).ceil() <= 4) {
    return '${(difference.inDays / 7).ceil()} tuần trước';
  } else if ((difference.inDays / 30).ceil() <= 1) {
    return (numericDates) ? '1 tháng trước' : 'Tháng trước';
  } else if ((difference.inDays / 30).ceil() <= 30) {
    return '${(difference.inDays / 30).ceil()} tháng trước';
  } else if ((difference.inDays / 365).ceil() <= 1) {
    return (numericDates) ? '1 năm trước' : 'Năm trước';
  }
  return '${(difference.inDays / 365).floor()} năm trước';
}

Future<String> getDeviceIdentifier() async {
  String deviceIdentifier = "unknown";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (kIsWeb) {
    WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
    deviceIdentifier =
        "${webInfo.vendor}${webInfo.userAgent}${webInfo.hardwareConcurrency.toString()}";
  } else {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.androidId ?? "";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor ?? "";
    } else if (Platform.isLinux) {
      LinuxDeviceInfo linuxInfo = await deviceInfo.linuxInfo;
      deviceIdentifier = linuxInfo.machineId ?? "";
    }
  }
  return deviceIdentifier;
}

Color getColorRank(int rank) {
  if (rank <= 10)
    return Colors.green;
  else if (rank <= 20)
    return Colors.cyan;
  else if (rank <= 50)
    return Colors.yellow;
  else if (rank <= 100)
    return Colors.orange;
  else
    return Colors.red;
}

int getAQIRank(double aqi) {
  if (aqi >= 0 && aqi <= 50) return 6;
  if (aqi >= 51 && aqi <= 100) return 5;
  if (aqi >= 101 && aqi <= 150) return 4;
  if (aqi >= 151 && aqi <= 200) return 3;
  if (aqi >= 201 && aqi <= 300) return 2;
  if (aqi >= 301) return 1;
  return 1;
}

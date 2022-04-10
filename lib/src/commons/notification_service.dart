import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  Future<void> showNotifications(RemoteMessage message) async {
    final jsonData = json.decode(message.data["data"]);
    PollutionModel pollution = PollutionModel.fromJson(jsonData);
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl('$host/ic_pin_${pollution.type ?? ""}.png'));
    // final String largeIconPath = await _downloadAndSaveFile(
    //     '$host/ic_pin_${message.data["type"]}.png', 'largeIcon');
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        (pollution.images ?? []).isNotEmpty
            ? await _getByteArrayFromUrl('$host/${pollution.images?.first}')
            : await _getByteArrayFromUrl(
                '$host/ic_pin_${pollution.type ?? ""}.png'));
    final Int64List vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    final BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicture,
            largeIcon: largeIcon,
            contentTitle:
                "Tại ${pollution.specialAddress}, ${pollution.wardName}, ${pollution.districtName}, ${pollution.provinceName}",
            htmlFormatContentTitle: true,
            summaryText: pollution.desc,
            htmlFormatSummaryText: true);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('12', 'Thông báo ô nhiễm',
            channelDescription: 'Thông báo thông tin ô nhiễm môi trường',
            vibrationPattern: vibrationPattern,
            priority: Priority.high,
            importance: Importance.high,
            enableLights: true,
            color: const Color.fromARGB(255, 255, 0, 0),
            ledColor: const Color.fromARGB(255, 255, 0, 0),
            ledOnMs: 1000,
            ledOffMs: 500,
            styleInformation: bigPictureStyleInformation);

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, message.notification?.title,
        message.notification?.body, platformChannelSpecifics,
        payload: pollution.id);
  }

  // Future<void> scheduleNotifications() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       "Notification Title",
  //       "This is the Notification Body!",
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       NotificationDetails(android: androidPlatformChannelSpecifics),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String? payload) async {
  //handle your logic here
  print(payload);
  Get.to(() => DetailPollutionScreen(), arguments: payload);
}

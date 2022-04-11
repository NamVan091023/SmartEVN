import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/notification_service.dart';
import 'package:pollution_environment/src/model/pollution_response.dart';
import 'package:pollution_environment/src/network/apis/notification/notification_api.dart';
import 'package:pollution_environment/src/screen/detail_pollution/detail_pollution_screen.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.data.containsKey('data')) {
    // Handle data message
    // final data = message.data['data'];
  }

  if (message.data.containsKey('notification')) {
    // Handle notification message
    // final notification = message.data['notification'];
  }
  // Or do other work.
}

Future<AudioPlayer> playSoundAlert() async {
  AudioCache cache = new AudioCache();
  return await cache.play("sound_alert.mp3");
}

class FCM {
  final _firebaseMessaging = FirebaseMessaging.instance;

  NotificationService _notificationService = NotificationService();

  setNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(
      (message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          _notificationService.showNotifications(message);
        }
        final jsonData = json.decode(message.data["data"]);
        PollutionModel pollution = PollutionModel.fromJson(jsonData);
        playSoundAlert();

        showOverlayNotification(
          (ctx) {
            return SafeArea(
              child: Card(
                color: getQualityColor(pollution.qualityScore),
                elevation: 15,
                child: ListTile(
                  leading: SizedBox.fromSize(
                      size: const Size(40, 40),
                      child: ClipOval(
                          child:
                              Image.asset(getAssetPollution(pollution.type)))),
                  title: Text(
                    notification?.title ?? "Thông báo",
                    style: TextStyle(
                        color: (pollution.qualityScore ?? 0) <= 3
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    notification?.body ?? "",
                    style: TextStyle(
                        color: (pollution.qualityScore ?? 0) <= 3
                            ? Colors.white
                            : Colors.black),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      OverlaySupportEntry.of(ctx)?.dismiss();
                    },
                    icon: Icon(
                      Icons.cancel_rounded,
                      color: Colors.red,
                    ),
                  ),
                  onTap: () {
                    OverlaySupportEntry.of(ctx)?.dismiss();
                    Get.to(() => DetailPollutionScreen(),
                        arguments: pollution.id);
                  },
                ),
              ),
            );
          },
          duration: Duration(seconds: 20),
          position: NotificationPosition.top,
        );
      },
    );
    //Message for Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        _notificationService.showNotifications(message);
      }
    });

    // With this token you can test it easily on your phone
    _firebaseMessaging.getToken().then((value) {
      if (value != null) NotificationApi().updateFCMToken(value);
    });
  }
}

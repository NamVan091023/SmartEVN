import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/background_location/location_callback_handler.dart';
import 'package:pollution_environment/src/commons/background_location/location_service_repository.dart';
import 'package:pollution_environment/src/commons/notification.dart';
import 'package:pollution_environment/src/components/keep_alive_wrapper.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/screen/manage//manage_screen.dart';
import 'package:pollution_environment/src/screen/map/map_screen.dart';
import 'package:pollution_environment/src/screen/news/news_screen.dart';
import 'package:pollution_environment/src/screen/notification/notification_screen.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_screen.dart';
import 'package:pollution_environment/src/screen/report_user/report_user_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class MainBoard extends StatefulWidget {
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  int indexPage = 1;
  bool isAdmin = false;
  ReceivePort port = ReceivePort();
  final Widget map = KeepAliveWrapper(child: MapScreen());
  final Widget news = KeepAliveWrapper(child: NewsScreen());
  final Widget noti = KeepAliveWrapper(child: NotificationScreen());
  final Widget profile = KeepAliveWrapper(child: ProfileScreen());
  final Widget report = ReportUser();
  final Widget manage = KeepAliveWrapper(child: ManageScreen());

  List<Widget> nonAdminWidgets() {
    return <Widget>[
      news,
      map,
      noti,
      report,
      profile,
    ];
  }

  List<Widget> adminWidgets() {
    return <Widget>[
      news,
      map,
      noti,
      report,
      manage,
      profile,
    ];
  }

  List<BottomNavigationBarItem> _tabItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.newspaper_rounded),
      label: "Tin tức",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map_rounded),
      label: "Bản đồ",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_active_rounded),
      label: "Thông báo",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.report_problem_rounded),
      label: "Báo cáo",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: "Tài khoản",
    ),
  ];
  List<BottomNavigationBarItem> _tabItemAdmin = [
    BottomNavigationBarItem(
      icon: Icon(Icons.newspaper_rounded),
      label: "Tin tức",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map_rounded),
      label: "Bản đồ",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_active_rounded),
      label: "Thông báo",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.report_problem_rounded),
      label: "Báo cáo",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_rounded),
      label: 'Quản lý',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded),
      label: "Tài khoản",
    ),
  ];
  @override
  void initState() {
    super.initState();
    UserStore().getAuth().then((value) => setState(() {
          isAdmin = value?.user?.role == "admin";
        }));
    FCM().setNotifications();
    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    // port.listen(
    //   (dynamic data) async {
    //     await BackgroundLocator.updateNotificationText(
    //         title: "new location received",
    //         msg: "${DateTime.now()}",
    //         bigMsg: "${data.latitude}, ${data.longitude}");
    //   },
    // );
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    print('Running ${_isRunning.toString()}');
    _onStart();
  }

  void _onStart() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
    } else {
      // show error
    }
  }

  Future<bool> _checkLocationPermission() async {
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

  Future<void> _startLocator() async {
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.POWERSAVE, distanceFilter: 100),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.POWERSAVE,
            interval: 600,
            distanceFilter: 100,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle:
                    'Sử dụng GPS để nhận thông tin ô nhiễm gần bạn',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Vị trí nền được bật để giữ cho ứng dụng cập nhật chính xác thông tin ô nhiễm gần vị trí của bạn.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                    LocationCallbackHandler.notificationCallback)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: isAdmin ? adminWidgets() : nonAdminWidgets(),
        index: indexPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 20,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: isAdmin ? _tabItemAdmin : _tabItem,
      ),
    );
  }
}

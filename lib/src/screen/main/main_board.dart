import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pollution_environment/main.dart';
import 'package:pollution_environment/src/commons/background_location/location_background.dart';
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
import 'package:workmanager/workmanager.dart';

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

    port.listen(
      (dynamic data) async {
        // await BackgroundLocator.updateNotificationText(
        //     title: "new location received",
        //     msg: "${DateTime.now()}",
        //     bigMsg: "${data.latitude}, ${data.longitude}");
      },
    );
    LocationBackground.initPlatformState();
    Workmanager().cancelAll();
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
    if (Platform.isAndroid) {
      Workmanager().registerPeriodicTask(
        fetchAQIBackground,
        fetchAQIBackground,
        existingWorkPolicy: ExistingWorkPolicy.keep,
        frequency: Duration(minutes: 120),
      );
      Workmanager().registerPeriodicTask(
        fetchLocationBackground,
        fetchLocationBackground,
        existingWorkPolicy: ExistingWorkPolicy.keep,
        // frequency: Duration(minutes: 15),
      );
    }

    if (Platform.isIOS) {
      Workmanager().registerOneOffTask(
        fetchAQIBackground,
        fetchAQIBackground,
        // frequency: Duration(minutes: 15),
      );
      Workmanager().registerOneOffTask(
        fetchLocationBackground,
        fetchLocationBackground,
        // frequency: Duration(minutes: 15),
      );
    }
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

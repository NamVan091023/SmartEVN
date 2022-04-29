// import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/notification.dart';
import 'package:pollution_environment/src/components/keep_alive_wrapper.dart';
import 'package:pollution_environment/src/screen/home/home_screen.dart';
import 'package:pollution_environment/src/screen/map/map_screen.dart';
import 'package:pollution_environment/src/screen/news/news_screen.dart';
import 'package:pollution_environment/src/screen/report_user/report_user_screen.dart';

class MainBoard extends StatefulWidget {
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  int indexPage = 0;
  // ReceivePort port = ReceivePort();
  final Widget map = KeepAliveWrapper(child: MapScreen());
  final Widget news = KeepAliveWrapper(child: NewsScreen());
  final Widget home = KeepAliveWrapper(child: HomeScreen());
  final Widget report = ReportUser();

  List<Widget> listWidgets() {
    return <Widget>[
      home,
      map,
      news,
      report,
    ];
  }

  List<BottomNavigationBarItem> _tabItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded),
      label: "Trang chủ",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map_rounded),
      label: "Bản đồ",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.newspaper_rounded),
      label: "Tin tức",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.report_problem_rounded),
      label: "Báo cáo",
    ),
  ];

  @override
  void initState() {
    super.initState();
    FCM().setNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: listWidgets(),
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
        items: _tabItem,
      ),
    );
  }
}

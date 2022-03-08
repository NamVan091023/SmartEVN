import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/notification.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/components/keep_alive_wrapper.dart';
import 'package:pollution_environment/src/screen/manage//manage_screen.dart';
import 'package:pollution_environment/src/screen/map/map_screen.dart';
import 'package:pollution_environment/src/screen/notification/notification_screen.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_screen.dart';
import 'package:pollution_environment/src/screen/report_user/report_user_screen.dart';

class MainBoard extends StatefulWidget {
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  int indexPage = 0;
  bool isAdmin = PreferenceUtils.getBool(KEY_IS_ADMIN);

  List<Widget> _tabList = <Widget>[
    KeepAliveWrapper(child: MapScreen()),
  ];

  @override
  void initState() {
    super.initState();

    FCM().setNotifications();

    _tabList.add(KeepAliveWrapper(child: NotificationScreen()));
    if (isAdmin) {
      _tabList.add(KeepAliveWrapper(child: ManageScreen()));
    } else {
      _tabList.add(ReportUser());
    }

    _tabList.add(KeepAliveWrapper(child: ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _tabList,
        index: indexPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "Bản đồ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_active_rounded),
            label: "Thông báo",
          ),
          BottomNavigationBarItem(
            icon: isAdmin
                ? Icon(Icons.menu_rounded)
                : Icon(Icons.report_problem_rounded),
            label: isAdmin ? 'Quản lý' : 'Báo cáo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Tài khoản",
          ),
        ],
      ),
    );
  }
}

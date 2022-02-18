import 'package:flutter/material.dart';
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
  bool isAdmin = false; //PreferenceUtils.getBool(KEY_IS_ADMIN, true);
  bool isLogin = true; //PreferenceUtils.getBool(KEY_IS_LOGIN, true);

  List<Widget> _tabList = <Widget>[
    MapScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      _tabList.add(NotificationScreen());
      if (isAdmin) {
        _tabList.add(ManageScreen());
      } else {
        _tabList.add(ReportUser());
      }
    }

    _tabList.add(ProfileScreen());

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
          if (isLogin)
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_rounded),
              label: "Thông báo",
            ),
          if (isLogin)
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

import 'package:flutter/material.dart';
import 'package:pollution_environment/src/screen/manage//manage_screen.dart';
import 'package:pollution_environment/src/screen/map/map_screen.dart';
import 'package:pollution_environment/src/screen/notification/notification_screen.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_screen.dart';
import 'package:pollution_environment/src/screen/report_user/report_user_screen.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_screen.dart';

import '../../commons/constants.dart';
import '../../commons/sharedPresf.dart';

class MainBoard extends StatefulWidget {
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  int indexPage = 0;
  bool isAdmin = PreferenceUtils.getBool(KEY_IS_ADMIN, true);
  bool isLogin = PreferenceUtils.getBool(KEY_IS_LOGIN, true);

  List<Widget> _list = <Widget>[
    MapScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      _list.add(NotificationScreen());
      if (isAdmin) {
        _list.add(ManageScreen());
      } else {
        _list.add(ReportUser());
      }
    }

    _list.add(ProfileScreen());

    return Scaffold(
      body: IndexedStack(
        children: _list,
        index: indexPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: form,
        selectedItemColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined), label: "Bản đồ"),
          if (isLogin)
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active_rounded),
                label: "Thông báo"),
          if (isLogin)
            BottomNavigationBarItem(
                icon: isAdmin
                    ? Icon(Icons.menu_rounded)
                    : Icon(Icons.report_problem_rounded),
                label: isAdmin ? 'Quản lý' : 'Báo cáo'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Tài khoản"),
        ],
      ),
    );
  }

  pageChooser() {
    switch (this.indexPage) {
      case 0:
        return new MapScreen();
        break;

      case 1:
        return new NotificationScreen();
        break;

      case 2:
        return isAdmin ? new ManageScreen() : new ReportUser();
        break;
      case 3:
        return isLogin ? new ProfileScreen() : new SignInScreen();
        break;
      default:
        return new Container(
          child: new Center(
              child: new Text('No page found by page chooser.',
                  style: new TextStyle(fontSize: 30.0))),
        );
    }
  }
}

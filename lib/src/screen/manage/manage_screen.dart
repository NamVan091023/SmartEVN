import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/screen/manage/dashboard/dashboard_screen.dart';
import 'package:pollution_environment/src/screen/manage/pollution_manage/pollution_manage_controller.dart';
import 'package:pollution_environment/src/screen/manage/pollution_manage/pollution_manage_screen.dart';
import 'package:pollution_environment/src/screen/manage/user_manage/user_manage_screen.dart';

import 'special_alert/special_alert_screen.dart';

class ManageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageScreenState();
  }
}

class ManageScreenState extends State<ManageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  UserModel? currentUser;
  List<Widget> _listScreen = [
    DashboardScreen(),
    // PollutionManageScreen(),
    // UserManageScreen()
  ];

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    currentUser = await UserStore().getAuth()?.user;
    if (currentUser?.role == ROLE_ADMIN) {
      _listScreen = [
        DashboardScreen(),
        SpecialAlertScreen(),
        PollutionManageScreen(),
        UserManageScreen(),
      ];
    } else if (currentUser?.role == ROLE_MOD) {
      _listScreen = [
        DashboardScreen(),
        SpecialAlertScreen(),
        PollutionManageScreen(),
      ];
    }
    setState(() {});
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Tổng quan";
      case 1:
        return "Thông báo khẩn cấp";
      case 2:
        return "Quản lý ô nhiễm";
      case 3:
        return "Quản lý người dùng";
      default:
        return "Tổng quan";
    }
  }

  Icon getIconLeading(int index) {
    switch (index) {
      case 0:
        return LineIcon(LineIcons.barChart);
      case 1:
        return LineIcon(LineIcons.bullhorn);
      case 2:
        return LineIcon(LineIcons.alternateList);
      case 3:
        return LineIcon(LineIcons.users);
      default:
        return LineIcon(LineIcons.barChart);
    }
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(getTitle(_selectedIndex)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          iconSize: 25.0,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          if (_selectedIndex == 2)
            IconButton(
              onPressed: () {
                PollutionManageController _pollutionManager = Get.find();
                _pollutionManager.isShowFilter.toggle();
              },
              icon: Icon(Icons.filter_alt_rounded),
            ),
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: Icon(Icons.menu))
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.8),
        child: ListView(
          // padding: EdgeInsets.zero,
          children: _listScreen.asMap().entries.map((e) {
            return ListTile(
              selected: e.key == _selectedIndex,
              title: Text(getTitle(e.key)),
              leading: getIconLeading(e.key),
              minLeadingWidth: 20,
              onTap: () {
                setState(() {
                  _selectedIndex = e.key;
                });
                Get.back();
              },
            );
          }).toList(),
        ),
      ),
      body: _listScreen[_selectedIndex],
    );
  }
}

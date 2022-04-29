import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/manage/dashboard/dashboard_screen.dart';
import 'package:pollution_environment/src/screen/manage/pollution_manage/pollution_manage_controller.dart';
import 'package:pollution_environment/src/screen/manage/pollution_manage/pollution_manage_screen.dart';
import 'package:pollution_environment/src/screen/manage/user_manage/user_manage_screen.dart';

class ManageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageScreenState();
  }
}

class ManageScreenState extends State<ManageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> _listScreen = [
    DashboardScreen(),
    PollutionManageScreen(),
    UserManageScreen()
  ];
  String getTitle(int index) {
    switch (index) {
      case 0:
        return "Tổng quan";
      case 1:
        return "Quản lý ô nhiễm";
      case 2:
        return "Quản lý người dùng";
      default:
        return "Tổng quan";
    }
  }

  Icon getIconLeading(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.bar_chart_rounded);
      case 1:
        return Icon(Icons.list_alt_rounded);
      case 2:
        return Icon(Icons.people_alt_rounded);
      default:
        return Icon(Icons.dashboard_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          if (_selectedIndex == 1)
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

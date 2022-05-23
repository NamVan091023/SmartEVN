import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pollution_environment/src/screen/notification/pollution_notification_screen.dart';

import 'alert_notification_screen.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thông báo"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.report_problem_outlined),
                text: "Môi trường",
              ),
              Tab(icon: LineIcon(LineIcons.bullhorn), text: "Khẩn cấp"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NotificationPollutionScreen(),
            NotificationAlertScreen(),
          ],
        ),
      ),
    );
  }
}

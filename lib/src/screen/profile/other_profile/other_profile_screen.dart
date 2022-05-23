import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/profile/components/history_pollution.dart';
import 'package:pollution_environment/src/screen/profile/components/profile_pic.dart';
import 'package:pollution_environment/src/screen/profile/components/ui_two_text_line.dart';
import 'package:pollution_environment/src/screen/profile/other_profile/other_profile_controller.dart';

class OtherProfileScreen extends StatelessWidget {
  late final OtherProfileController _controller =
      Get.put(OtherProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hồ sơ thành viên"), actions: <Widget>[
        Obx(() => _controller.currentUser.value?.role == "admin"
            ? PopupMenuButton<String>(
                onSelected: handleClickMenu,
                itemBuilder: (BuildContext context) {
                  return {'Xóa', 'Chỉnh sửa'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              )
            : Container())
      ]),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        child: Column(
          children: [
            Obx(() => ProfilePic(
                  user: _controller.user.value,
                )),
            SizedBox(height: 20),
            Obx(
              () => Text(
                _controller.user.value?.name ?? "",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 20),
            Obx(() => Text(_controller.user.value?.email ?? "")),
            SizedBox(height: 20),
            Obx(
              () => Row(
                children: [
                  Spacer(),
                  TwoTextLine(
                      textOne:
                          "${_controller.pollution.value?.totalResults ?? 0}",
                      textTwo: "Số báo cáo"),
                  Spacer(),
                  TwoTextLine(
                      textOne: _controller.currentUser.value?.role == ROLE_ADMIN
                          ? "Quản trị viên"
                          : _controller.currentUser.value?.role == ROLE_MOD
                              ? "Kiểm duyệt"
                              : "Thành viên",
                      textTwo: "Chức vụ"),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(
              height: 1,
            ),
            SizedBox(height: 20),
            Text(
              "Lịch sử báo cáo gần nhất",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Obx(() =>
                HistoryPollution(_controller.pollution.value?.results ?? []))
          ],
        ),
      ),
    );
  }

  void handleClickMenu(String value) {
    switch (value) {
      case 'Xóa':
        _controller.deleteUser();
        break;
      case 'Chỉnh sửa':
        Get.toNamed(Routes.EDIT_PROFILE_SCREEN,
                arguments: _controller.user.value)
            ?.then((value) {
          _controller.getUser();
        });
        break;
    }
  }
}

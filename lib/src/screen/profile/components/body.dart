import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/profile/components/card_menu.dart';
import 'package:pollution_environment/src/screen/profile/components/ui_two_text_line.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_controller.dart';

import 'profile_pic.dart';

class Body extends StatelessWidget {
  final UserModel? user;

  Body({Key? key, this.user}) : super(key: key);
  final ProfileController _profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 50),
          ProfilePic(
            user: user,
          ),
          SizedBox(height: 20),
          Text(
            user?.name ?? "",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(),
              TwoTextLine(textOne: "0", textTwo: "Số bài viết"),
              Spacer(),
              TwoTextLine(textOne: "32", textTwo: "Số điểm post"),
              Spacer(),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              child: Text(
                "CÀI ĐẶT",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              width: double.infinity,
            ),
          ),
          Obx(
            () => CardMenu(
              text: "Giao diện",
              leftIcon: Icon(Icons.dark_mode_rounded),
              right: DropdownButton<String>(
                  // isExpanded: true,
                  underline: SizedBox(),
                  alignment: AlignmentDirectional.centerEnd,
                  value: _profileController.themeMode.value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Sáng"),
                      value: "light",
                    ),
                    DropdownMenuItem(
                      child: Text("Tối"),
                      value: "dark",
                    ),
                    DropdownMenuItem(
                      child: Text("Hệ thống"),
                      value: "system",
                    ),
                  ],
                  onChanged: (value) {
                    _profileController.changeThemeMode(value);
                  }),
            ),
          ),
          CardMenu(
            text: "Thông báo",
            leftIcon: Icon(Icons.notifications_rounded),
            right: Switch(
                value: user?.isNotificationReceived ?? false,
                onChanged: (value) {
                  _profileController.updateNotificationReceived(value);
                  user?.isNotificationReceived = value;
                }),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Container(
              child: Text(
                "TÀI KHOẢN",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              width: double.infinity,
            ),
          ),
          CardMenu(
            text: "Chỉnh sửa",
            leftIcon: Icon(Icons.edit_rounded),
            right: Icon(Icons.chevron_right_sharp),
            onTap: () {
              Get.toNamed(Routes.EDIT_PROFILE_SCREEN, arguments: user)
                  ?.then((value) {
                _profileController.getUser();
              });
            },
          ),
          CardMenu(
            text: "Đăng xuất",
            leftIcon: Icon(Icons.logout_rounded),
            right: Icon(Icons.chevron_right_sharp),
            onTap: () {
              AuthApi().logout();
              AuthApi().clearUserData();
              Get.offAllNamed(Routes.LOGIN_SCREEN);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_controller.dart';

import 'card_menu.dart';

class ProfileMenu extends StatelessWidget {
  ProfileMenu({Key? key, this.user}) : super(key: key);

  final UserModel? user;

  late final ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
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
        SizedBox(
          height: 8,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
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
    );
  }
}

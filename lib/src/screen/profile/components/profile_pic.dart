import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/api_service.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_controller.dart';

class ProfilePic extends StatelessWidget {
  late final UserModel? user;

  ProfilePic({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: (user?.avatar == null
                ? AssetImage("assets/images/profile_image.png")
                : NetworkImage(
                    "$host/${user?.avatar}",
                  )) as ImageProvider<Object>?,
          ),
        ],
      ),
    );
  }
}

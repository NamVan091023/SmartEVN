import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/screen/profile/components/ui_two_text_line.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_screen.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final UserData? user;

  Body({Key? key, required this.user}) : super(key: key);

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
            user!.name!,
            style: TextStyle(
              color: Colors.green,
              fontSize: size20,
              fontFamily: "Academy Engraved LET",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Spacer(),
              TwoTextLine(
                  textOne: user!.post.toString(), textTwo: "Số bài viết"),
              Spacer(),
              TwoTextLine(textOne: "32", textTwo: "Số điểm post"),
              Spacer(),
            ],
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Hỗ trợ",
            icon: "assets/icons/question_mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "assets/icons/log_out.svg",
            press: () {
              PreferenceUtils.setBool(KEY_IS_LOGIN, false);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignInScreen()));
            },
          ),
        ],
      ),
    );
  }
}

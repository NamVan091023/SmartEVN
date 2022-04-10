import 'package:flutter/material.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/screen/profile/components/profile_menu.dart';

import 'profile_pic.dart';

class Body extends StatelessWidget {
  final UserModel? user;

  Body({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
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
          // Row(
          //   children: [
          //     Spacer(),
          //     TwoTextLine(textOne: "0", textTwo: "Số bài viết"),
          //     Spacer(),
          //     TwoTextLine(textOne: "32", textTwo: "Số điểm post"),
          //     Spacer(),
          //   ],
          // ),
          Text(user?.email ?? ""),
          SizedBox(height: 20),
          Divider(
            height: 1,
          ),
          ProfileMenu(
            user: user,
          ),
        ],
      ),
    );
  }
}

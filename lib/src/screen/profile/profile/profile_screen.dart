import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/screen/profile/components/body.dart';
import 'package:pollution_environment/src/screen/profile/components/profile_not_login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin<ProfileScreen> {
  var isLogin = PreferenceUtils.getBool(KEY_IS_LOGIN, false);
  var user;

  @override
  Widget build(BuildContext context) {
    if (PreferenceUtils.getString("user") != "") {
      Map userMap = jsonDecode(PreferenceUtils.getString("user"));
      user = Data.fromJson(userMap);
    }

    return Scaffold(
      body: isLogin ? Body(user: user) : ProfileNotLogin(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

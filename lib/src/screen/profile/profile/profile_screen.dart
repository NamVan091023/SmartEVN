import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/profile/components/body.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  late final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Body(user: _controller.user.value)),
    );
  }
}

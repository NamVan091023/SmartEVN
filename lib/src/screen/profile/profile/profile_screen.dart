import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/profile/components/body.dart';
import 'package:pollution_environment/src/screen/profile/profile/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  late final ProfileController _controller = Get.put(ProfileController());

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hồ sơ")),
      body: Obx(() => Body(user: _controller.user.value)),
    );
  }
}

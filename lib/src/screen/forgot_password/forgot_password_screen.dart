import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/forgot_password/forgot_password_controller.dart';

import 'components/body.dart';

class ForgotPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quên mật khẩu"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Get.back();
              },
            );
          },
        ),
      ),
      body: Body(),
    );
  }
}

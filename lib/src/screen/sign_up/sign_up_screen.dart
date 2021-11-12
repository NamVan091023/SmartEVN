import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/screen/sign_up/sign_up_controller.dart';

import 'components/body.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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

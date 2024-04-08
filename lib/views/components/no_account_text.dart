import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
// ignore: depend_on_referenced_packages
import 'package:pollution_environment/routes/app_pages.dart';
=======
import 'package:pollution_environment/new_base/routes/router_paths.dart';
>>>>>>> origin/feature/hiep-create-base

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn chưa có tài khoản? ",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        GestureDetector(
          onTap: () => Get.toNamed(RouterPaths.SIGNUP_SCREEN),
          child: Text(
            "Đăng ký ngay",
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}

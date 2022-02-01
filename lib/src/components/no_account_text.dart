import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/screen/sign_up/sign_up_screen.dart';

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
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Get.to(() => SignUpScreen(), binding: SignUpBindings()),
          child: Text(
            "Đăng ký ngay",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16), color: Colors.green),
          ),
        ),
      ],
    );
  }
}

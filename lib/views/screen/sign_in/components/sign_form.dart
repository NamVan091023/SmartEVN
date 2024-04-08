import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/new_base/routes/app_pages.dart';
import 'package:pollution_environment/new_base/routes/router_paths.dart';

import '../../../../services/commons/constants.dart';
import '../../../../services/commons/helper.dart';
import '../../../../services/commons/size_config.dart';
import '../../../components/default_button.dart';
import '../../../components/keyboard.dart';

class SignForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Box box = Hive.box(kHiveBox);
  bool _passwordVisible = false;

  SignForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Đăng nhập",
            key: ValueKey("btn.login"),
            press: () async {
              // Bỏ qua việc kiểm tra đăng nhập và chuyển đến màn hình chính
              Get.offAllNamed(Routes.HOME_SCREEN);
            },
          ),
        ],
      child: AutofillGroup(
        child: Column(
          children: [
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: controller.remember.value,
                    onChanged: (value) {
                      controller.setRemember(value!);
                    },
                  ),
                ),
                const Text("Nhớ mật khẩu"),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.toNamed(RouterPaths.FORGOT_PASSWORD_SCREEN),
                  child: const Text(
                    "Quên mật khấu",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            DefaultButton(
              text: "Đăng nhập",
              key: ValueKey("btn.login"),
              press: () async {
                if (_formKey.currentState!.validate()) {
                  // đăng nhập thành công
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  await controller.loginUser(() {
                    {
                      Fluttertoast.showToast(
                        msg: "Đăng nhập thành công",
                      );
                      Get.offAllNamed(RouterPaths.HOME_SCREEN);
                    }
                  }, (err) {
                    showAlert(desc: err);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      key: ValueKey("password"),
      obscureText: !_passwordVisible,
      validator: (value) {
        return value!.isEmpty ? "Password cannot be empty" : null;
      },
      onSaved: (value) {},
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            _togglePasswordVisibility();
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      key: ValueKey("email"),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return value!.isEmpty ? "Email cannot be empty" : null;
      },
      onSaved: (value) {},
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }

  void _togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
  }
}

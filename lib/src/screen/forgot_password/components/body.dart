import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';
import 'package:pollution_environment/src/screen/forgot_password/forgot_password_controller.dart';

import 'forgot_token_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Nhập địa chỉ email của bạn, chúng tôi sẽ gửi\n mã xác nhận đến email của bạn",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => controller.onSave(newValue!),
            onChanged: (value) {
              controller.onChange(value);
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return controller.onValidator(value!);
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Nhập email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.mail),
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState!.validate()) {
                KeyboardUtil.hideKeyboard(context);
                showLoading();
                AuthApi().forgotPassword(controller.email.value).then((value) {
                  hideLoading();
                  Get.to(() => ResetPassword());
                }, onError: (e) {
                  hideLoading();
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/custom_surfix_icon.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/form_error.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';
import 'package:pollution_environment/src/screen/forgot_password/forgot_password_controller.dart';

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
                "Nhập email của bạn, chúng tôi sẽ gửi\n mail xác nhận đến email của bạn",
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
            validator: (value) {
              return controller.onValidator(value!);
            },
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Nhập email",
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Obx(() => FormError(errors: controller.errors.toList())),
          SizedBox(height: SizeConfig.screenHeight * 0.02),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState!.validate()) {
                KeyboardUtil.hideKeyboard(context);
                // Do what you want to do
                AuthApi().forgotPassword(controller.email.value).then((value) {
                  showAlertError(desc: value.message ?? "");
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

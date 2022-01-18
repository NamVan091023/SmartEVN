import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/custom_surfix_icon.dart';
import 'package:pollution_environment/src/components/form_error.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/model/user_response.dart';
import 'package:pollution_environment/src/network/pollutionApi.dart';
import 'package:pollution_environment/src/screen/forgot_password/forgot_password_screen.dart';
import 'package:pollution_environment/src/screen/main/main_board.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_controller.dart';

import '../../../components/default_button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final SignInController controller = Get.find();

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
          Row(
            children: [
              Obx(
                () => Checkbox(
                  value: controller.remember.value,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    controller.setRemember(value!);
                  },
                ),
              ),
              Text("Nhớ mật khẩu"),
              Spacer(),
              GestureDetector(
                onTap: () => Get.to(() => ForgotPasswordScreen(),
                    binding: ForgotPasswordBindings()),
                child: Text(
                  "Quên mật khấu",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          Obx(() => FormError(errors: controller.errors.toList())),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Tiếp tục",
            press: () async {
              if (_formKey.currentState!.validate()) {
                // đăng nhập thành công
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                showLoading();
                await loginUser();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> loginUser() async {
    UserModel data =
        await (PollutionNetwork().loginUser() as FutureOr<UserModel>);
    hideLoading();

    if (data.errorCode == 0) {
      Get.to(() => MainBoard());
      PreferenceUtils.setBool(
          KEY_IS_ADMIN, data.data!.role == 1 ? false : true);
      PreferenceUtils.setString(KEY_EMAIL, data.data!.email!);
      PreferenceUtils.setBool(KEY_IS_LOGIN, true);
      String user = jsonEncode(data.data!.toJson());
      PreferenceUtils.setString("user", user);
      Fluttertoast.showToast(
          msg: "Đăng nhập thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.green,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: data.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => controller.onSavePassword(newValue!),
      onChanged: (value) {
        controller.onChangePassword(value);
      },
      validator: (value) {
        return controller.onValidatorPassword(value!);
      },
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => controller.onSaveEmail(newValue!),
      onChanged: (value) {
        controller.onChangeEmail(value);
      },
      validator: (value) {
        return controller.onValidatorEmail(value!);
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}

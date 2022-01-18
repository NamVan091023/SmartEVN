import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/custom_surfix_icon.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/form_error.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/model/simple_respone.dart';
import 'package:pollution_environment/src/network/pollutionApi.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_screen.dart';
import 'package:pollution_environment/src/screen/sign_up/sign_up_controller.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final SignUpController controller = Get.put(SignUpController());

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
          buildConformPassFormField(),
          Obx(() => FormError(errors: controller.errors.toList())),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Tiếp tục",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                showLoading();
                await registerUser();
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => controller.saveConformPass(newValue!),
      onChanged: (value) {
        controller.changeConformPass(value);
      },
      validator: (value) {
        return controller.validatorConformPass(value!);
      },
      decoration: InputDecoration(
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => controller.savePassword(newValue!),
      onChanged: (value) {
        controller.changePassword(value);
      },
      validator: (value) {
        return controller.validatorPassword(value!);
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
      onSaved: (newValue) => controller.saveEmail(newValue!),
      onChanged: (value) {
        controller.changeEmail(value);
      },
      validator: (value) {
        return controller.validatorEmail(value!);
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

  Future<void> registerUser() async {
    SimpleResult? data = await PollutionNetwork().registerUser();
    hideLoading();
    if (data?.errorCode == 0) {
      Get.to(() => SignInScreen());
      Fluttertoast.showToast(
          msg: "Đăng kí thành công",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.green,
          fontSize: 16.0);
      // MaterialPageRoute(builder: (context) => MainBoard());
    } else {
      Fluttertoast.showToast(
          msg: data?.message ?? "",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.transparent,
          textColor: Colors.red,
          fontSize: 16.0);
    }
  }
}

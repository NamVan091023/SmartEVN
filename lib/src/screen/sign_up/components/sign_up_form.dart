import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/sign_up/sign_up_controller.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  late final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Đăng ký",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);
                await controller.registerUser(() {
                  Fluttertoast.showToast(
                      msg: "Đăng ký thành công",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  Get.offAllNamed(Routes.HOME_SCREEN);
                }, (err) {
                  showAlertError(desc: err);
                });
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.text,
        onSaved: (newValue) => controller.saveName(newValue!),
        onChanged: (value) {
          controller.changeName(value);
        },
        validator: (value) {
          return controller.validatorName(value!);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: "Họ và tên",
          hintText: "Nhập họ tên của bạn",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/sharedPresf.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/commons/theme.dart';
import 'package:pollution_environment/src/components/form_error.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../components/default_button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final SignInController controller = Get.find();
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                    activeColor: Colors.green,
                    onChanged: (value) {
                      controller.setRemember(value!);
                    },
                  ),
                ),
                Text("Nhớ mật khẩu"),
                Spacer(),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.FORGOT_PASSWORD_SCREEN),
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
              text: "Đăng nhập",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  // đăng nhập thành công
                  _formKey.currentState!.save();
                  KeyboardUtil.hideKeyboard(context);
                  await controller.loginUser(() {
                    {
                      Fluttertoast.showToast(
                          msg: "Đăng nhập thành công",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Get.offAllNamed(Routes.HOME_SCREEN);
                    }
                  }, (err) {
                    Alert(
                        context: context,
                        title: "Thất bại",
                        desc: err,
                        image: Image.asset("assets/icons/error.png"),
                        style: alertStyle(),
                        buttons: []).show();
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
      obscureText: !_passwordVisible,
      onSaved: (newValue) => controller.onSavePassword(newValue!),
      onChanged: (value) {
        controller.onChangePassword(value);
      },
      initialValue: PreferenceUtils.getString(KEY_PASSWORD),
      validator: (value) {
        return controller.onValidatorPassword(value!);
      },
      autofillHints: [AutofillHints.password],
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => controller.onSaveEmail(newValue!),
      initialValue: PreferenceUtils.getString(KEY_EMAIL),
      onChanged: (value) {
        controller.onChangeEmail(value);
      },
      validator: (value) {
        return controller.onValidatorEmail(value!);
      },
      onEditingComplete: () => TextInput.finishAutofillContext(),
      autofillHints: [AutofillHints.email],
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Nhập email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }
}

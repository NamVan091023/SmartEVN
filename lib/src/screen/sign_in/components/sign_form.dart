import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';
import 'package:pollution_environment/src/screen/sign_in/sign_in_controller.dart';

import '../../../components/default_button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final SignInController controller = Get.find();
  final Box box = Hive.box(HIVEBOX);
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
                      );
                      Get.offAllNamed(Routes.HOME_SCREEN);
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: !_passwordVisible,
      onSaved: (newValue) => controller.onSavePassword(newValue!),
      initialValue: box.get(KEY_PASSWORD),
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
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => controller.onSaveEmail(newValue!),
      initialValue: box.get(KEY_EMAIL),
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

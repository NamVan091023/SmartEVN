import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/helper.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/default_button.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/network/apis/users/auth_api.dart';
import 'package:pollution_environment/src/routes/app_pages.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Khôi phục mật khẩu"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Vui lòng nhập mã bí mật nhận được từ email",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                ForgotTokenForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotTokenForm extends StatefulWidget {
  @override
  State<ForgotTokenForm> createState() {
    return ForgotTokenFormState();
  }
}

class ForgotTokenFormState extends State<ForgotTokenForm> {
  final _formKey = GlobalKey<FormState>();

  String? _token;
  String? _password;
  String? _rePassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildTokenInput(),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          buildPasswordFormField(),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          buildConformPassFormField(),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              if (_formKey.currentState!.validate()) {
                KeyboardUtil.hideKeyboard(context);
                showLoading();
                AuthApi().resetPassword(_password!, _token!).then((value) {
                  hideLoading();
                  Fluttertoast.showToast(
                      msg: value.message ?? "Cập nhật mật khẩu thành công");
                  Get.offAllNamed(Routes.LOGIN_SCREEN);
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

  TextFormField buildTokenInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => setState(() {
        this._token = newValue;
      }),
      onChanged: (value) {
        setState(() {
          _token = value;
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty)
          return "Trường này không được để trống";
        else
          return null;
      },
      decoration: InputDecoration(
        labelText: "Mã bí mật",
        hintText: "Nhập mã bí mật",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.code),
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => setState(() {
        this._rePassword = newValue;
      }),
      onChanged: (value) {
        setState(() {
          this._rePassword = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPassNullError;
        } else if ((_password != value)) {
          return kMatchPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Xác nhận mật khẩu",
        hintText: "Nhập lại mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => setState(() {
        this._password = newValue;
      }),
      onChanged: (value) {
        setState(() {
          this._password = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return kPassNullError;
        } else if (value.length < 6) {
          return kShortPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.lock),
      ),
    );
  }
}

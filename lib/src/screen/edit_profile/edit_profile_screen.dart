import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pollution_environment/src/commons/constants.dart';
import 'package:pollution_environment/src/commons/size_config.dart';
import 'package:pollution_environment/src/components/keyboard.dart';
import 'package:pollution_environment/src/network/api_service.dart';
import 'package:pollution_environment/src/screen/edit_profile/edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  late final EditProfileController _controller =
      Get.put(EditProfileController());

  final nameController = new TextEditingController();
  final mailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thay đổi thông tin"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  SizedBox(
                    height: 115,
                    width: 115,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        Obx(() => CircleAvatar(
                              backgroundImage: (_controller.image.value == null
                                  ? (_controller.userModel.value.avatar == null
                                      ? AssetImage(
                                          "assets/images/profile_image.png")
                                      : NetworkImage(
                                          "$host/${_controller.userModel.value.avatar!}",
                                        ))
                                  : FileImage(_controller
                                      .image.value!)) as ImageProvider<Object>?,
                            )),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: new BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  loadAssets();
                                },
                                icon: Icon(
                                  Icons.edit_outlined,
                                  size: 16,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  buildNameFormField(),
                  SizedBox(height: 20),
                  buildEmailFormField(),
                  SizedBox(height: 20),
                  buildPasswordFormField(),
                  SizedBox(height: 20),
                  buildRePasswordFormField(),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Huỷ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              KeyboardUtil.hideKeyboard(context);
                              _formKey.currentState!.save();
                              _controller.updateUser();
                            }
                          },
                          child: Text(
                            "Cập nhật",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildNameFormField() {
    return Obx(() => TextFormField(
          controller: nameController,
          keyboardType: TextInputType.text,
          onSaved: (newValue) {
            if (newValue != null && newValue.isNotEmpty) {
              _controller.name.value = newValue;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
            labelText: "Họ tên",
            hintText: _controller.userModel.value.name,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }

  Widget buildEmailFormField() {
    return Obx(() => TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (newValue) {
            if (newValue != null && newValue.isNotEmpty) {
              _controller.email.value = newValue;
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isEmpty) {
              return null;
            } else if (!emailValidatorRegExp.hasMatch(value)) {
              return kInvalidEmailError;
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: "Email",
            hintText: _controller.userModel.value.email,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ));
  }

  Widget buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) {
        if (newValue != null && newValue.isNotEmpty) {
          _controller.password.value = newValue;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return null;
        } else if (value.length < 6) {
          return kShortPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập mật khẩu mới",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Widget buildRePasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.visiblePassword,
      onSaved: (newValue) {
        if (newValue != null && newValue.isNotEmpty) {
          _controller.rePassword.value = newValue;
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isEmpty) {
          return null;
        } else if (value != _controller.password.value) {
          return kMatchPassError;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mật khẩu",
        hintText: "Nhập lại mật khẩu mới",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Future<void> loadAssets() async {
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) _controller.image.value = File(image.path);
    } on Exception catch (e) {
      print(e);
    }
  }
}

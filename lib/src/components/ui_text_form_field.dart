import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pollution_environment/src/commons/constants.dart';

class PrimaryTextField extends StatelessWidget {
  PrimaryTextField(
      {Key key,
      @required this.controller,
      this.hint,
      this.type,
      this.color,
      @required this.isPassword,
      @required this.iconData})
      : super(key: key);

  final String hint;
  final TextEditingController controller;
  final TextInputType type;
  final color;
  final bool isPassword;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: (isPassword),
        controller: controller,
        keyboardType: type == null ? TextInputType.text : type,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: size20, right: size10),
              child: Icon(
                iconData,
                color: Colors.black,
              ), // icon is 48px widget.
            ),
            labelStyle: TextStyle(fontSize: hintTextSize, color: mainText),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: borderWidth, color: outLine),
                borderRadius: BorderRadius.circular(borderRadius)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: color == null ? primaryColor : color,
                    width: borderWidth),
                borderRadius: BorderRadius.circular(borderRadius))));
  }
}

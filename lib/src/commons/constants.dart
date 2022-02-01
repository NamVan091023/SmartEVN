import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pollution_environment/src/commons/size_config.dart';

const air = 1;
const water = 2;
const noise = 3;

const mainText = Color(0xFF2E3E5C);
const secondaryText = Color(0xFF9FA5C0);
const primaryColor = Color(0xFF1FCC79);
const secondaryColor = Color(0xFFFF5842);
const outLine = Color(0xFFD0DBEA);
const form = Color(0xFFF4F5F7);
const white = Color(0xFFFFFFFF);

const double mainTextSize = 22.0;
const double titleTextSize = 20.0;
const double secondaryTextSize = 17.0;
const double hintTextSize = 17.0;
const double borderWidth = 1.5;
const double borderRadius = 32.0;
const double size20 = 20.0;
const double size15 = 15.0;
const double size10 = 10.0;
const double size5 = 5.0;
const double size12 = 12.0;

const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

bool isLogin = false;
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Vui lòng nhập email";
const String kInvalidEmailError = "Email không đúng định dạng";
const String kPassNullError = "Vui lòng nhập mật khẩu";
const String kShortPassError = "Mật khẩu quá ngắn";
const String kMatchPassError = "Mật khẩu không trùng nhau";
const String kNamelNullError = "Vui lòng nhập tên của bạn";
const String kPhoneNumberNullError = "Vui lòng nhập số điện thoại";

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const String KEY_IS_LOGIN = "KEY_IS_LOGIN";
const String KEY_IS_ADMIN = "KEY_IS_ADMIN";
const String KEY_REMEMBER_LOGIN = "KEY_REMEMBER_LOGIN";
const String KEY_EMAIL = "KEY_EMAIL";
const String KEY_PASSWORD = "KEY_PASSWORD";
const String KEY_REFRESH_TOKEN = "KEY_REFRESH_TOKEN";
const String KEY_ACCESS_TOKEN = "KEY_ACCESS_TOKEN";
const String IS_FIRST_TIME = "IS_FIRST_TIME";

void showLoading({String? text = null, double? progress = null}) {
  if (progress != null) {
    EasyLoading.showProgress(progress, status: text);
  } else {
    EasyLoading.show(status: text);
  }
}

void hideLoading() {
  EasyLoading.dismiss();
}

String getIconTypePollution(int? type) {
  String urlAsses = "";
  switch (type) {
    case air:
      urlAsses = "assets/icons/ic_air.png";
      break;
    case noise:
      urlAsses = "assets/icons/ic_noise.png";
      break;
    case water:
      urlAsses = "assets/icons/ic_water.png";
      break;
  }
  return urlAsses;
}

const List listItemNameDistrict = [
  "Ba Đình",
  "Bắc Từ Liêm",
  "Cầu giấy",
  "Đống Đa",
  "Hà đông",
  "Hai bà trưng",
  "Hoàn Kiếm",
  "Hoàng Mai",
  "Long Biên",
  "Nam Từ Liêm",
  "Tây Hồ",
  "Thanh Xuân",
];
String getNameDistrict(int index) {
  return listItemNameDistrict[index];
}

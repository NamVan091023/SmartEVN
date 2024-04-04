import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyle {
  static const textBlueS12Bold = TextStyle(
    color: Colors.blue,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );
  static const textGrayS12 = TextStyle(
    color: AppColors.titleGray,
    fontSize: 12,
  );

  static const textBackS14W500 = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const textWhiteS14W500 = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const textWhiteS12W500 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static const textWhiteS80Bold = TextStyle(
    color: Colors.white,
    fontSize: 80,
    fontWeight: FontWeight.bold,
  );

  static const textPrimaryS14W500 = TextStyle(
    color: AppColors.primaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const textSecondaryS16Bold = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
  static const textSecondaryS14W500 = TextStyle(
    color: AppColors.secondaryColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const textSecondaryS12 =
      TextStyle(color: AppColors.secondaryColor, fontSize: 12);
}

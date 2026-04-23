import 'package:modares/core/resources/app_color.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle primaryStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColor.primaryTextColor,
  );

  static const TextStyle secondaryStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColor.mainGray,
  );
  static const TextStyle primaryButtonStyle = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColor.mainWhite,
  );

  //Forget password and remember me
  static TextStyle primaryStyleLoginScreen = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryTextColor,
  );
  static TextStyle primaryStyleSignUpScreen = TextStyle(
    fontFamily: 'Cairo',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColor.primaryTextColor,
  );

  static final TextStyle bannerStyle = TextStyle(
    color: AppColor.mainWhite,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Cairo',
  );

  static final TextStyle subjectCardStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: "Cairo",
  );

  // static const TextStyle itemTitleStyle = TextStyle(
  //   fontFamily: 'Cairo',
  //   fontSize: 18,
  //   fontWeight: FontWeight.w700,
  //   color: AppColor.primeryColor,
  // );
  // static const TextStyle itemPriceStyle = TextStyle(
  //   fontFamily: 'Cairo',
  //   fontSize: 16,
  //   fontWeight: FontWeight.w700,
  //   color: AppColor.mainWhite,
  // );
  // static final TextStyle itemDescriptionStyle = TextStyle(
  //   fontFamily: 'Poppins',
  //   fontSize: 14,
  //   fontWeight: FontWeight.w600,
  //   // color: AppColor.primeryGray,
  // );
  // static const TextStyle advertiseText = TextStyle(
  //   fontFamily: 'Poppins',
  //   fontSize: 20,
  //   fontWeight: FontWeight.w600,
  //   color: Colors.white,
  // );
}

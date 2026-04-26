import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_text_style.dart' show AppTextStyle;
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Widget widget;
  final Widget widget2;
  final double? width;
  final void Function()? onTap;
  const AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.widget = const SizedBox.shrink(),
    this.widget2 = const SizedBox.shrink(),
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primeryColorDark,
              AppColor.primeryColor,
              AppColor.primeryColor,
              AppColor.primeryColor,
              AppColor.primeryColor,
              AppColor.primeryColorDark,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget,
              Text(text, style: AppTextStyle.primaryButtonStyle),
              widget2,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.hint,
    required this.onChange,
    this.icon = const SizedBox.shrink(),
    this.controller,
    this.keyboard,
    this.preIcon = const SizedBox.shrink(),
  });
  final String hint;
 final Function(String)? onChange;
  final Widget icon;
  final Widget preIcon;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard ?? TextInputType.name,
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColor.primaryTextColor,
      ),
      decoration: InputDecoration(
        suffixIcon: icon,
        suffixIconColor: AppColor.mainGray,
        suffixIconConstraints: BoxConstraints(maxHeight: 40, maxWidth: 40),
        focusColor: AppColor.primaryTextColor,
        hint: Text(
          hint,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColor.primaryTextColor,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.mainGray, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onChanged: onChange,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({
    super.key,
    required this.title,
    required this.hint,
    required this.isEnabled,
    this.controller,
    this.keyboard,
  });
  final String title;
  final String hint;
  // final Function(String)? onChange;
  final TextEditingController? controller;
  final TextInputType? keyboard;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColor.primaryTextColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          enabled: isEnabled,
          controller: controller,
          
          keyboardType: keyboard ?? TextInputType.name,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColor.primaryTextColor,
          ),
          decoration: InputDecoration(
            focusColor: AppColor.primaryTextColor,
            hint: Text(
              hint,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: AppColor.mainGray,
              ),
            ),
            filled: true,
            fillColor: AppColor.mainWhite,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primaryTextColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.mainGray.withValues(alpha: 0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.mainGray.withValues(alpha: 0.05),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}

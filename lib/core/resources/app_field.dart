import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';

class AppField extends StatefulWidget {
  const AppField({
    super.key,
    required this.title,
    required this.hint,
    this.icon = const SizedBox.shrink(),
    this.isObsecure = false,
    this.controller,
    this.validation,
    this.borderColor,
    this.textColor,
    this.keyboard,
    this.errorText,
  });
  final String title;
  final String hint;
  final bool isObsecure;
  final Widget icon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final Color? borderColor;
  final Color? textColor;
  final TextInputType? keyboard;
  final String? errorText;
  @override
  State<AppField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.primaryTextColor,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isObsecure,
          keyboardType: widget.keyboard ?? TextInputType.name,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColor.primaryTextColor,
          ),
          decoration: InputDecoration(
            errorText: widget.errorText,
            suffixIcon: widget.icon,
            suffixIconColor: AppColor.mainGray,
            focusColor: AppColor.primaryTextColor,
            hint: Text(
              widget.hint,
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
              borderSide:  BorderSide(
                color: AppColor.primaryTextColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                color: Colors.transparent,
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
          ),
          validator: widget.validation,
        ),
      ],
    );
  }
}

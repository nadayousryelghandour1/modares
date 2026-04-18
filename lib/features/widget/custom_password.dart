import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_field.dart';
import 'package:modares/core/resources/app_validation.dart';
import 'package:flutter/material.dart';

class CustomPassword extends StatefulWidget {
  const CustomPassword({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.borderColor,
    this.textColor,
    this.errorText,
    this.validation,
  });
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Color? borderColor;
  final Color? textColor;
  final String? errorText;
  final String? Function(String?)? validation;

  @override
  State<CustomPassword> createState() => _CustomPasswordState();
}

class _CustomPasswordState extends State<CustomPassword> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return AppField(
      title: widget.title,
      hint: widget.hint,
      icon: GestureDetector(
        onTap: () {
          setState(() {
            isObscure = !isObscure;
          });
        },
        child: isObscure
            ? Icon(Icons.remove_red_eye, color: AppColor.mainGray)
            : Icon(Icons.visibility_off, color: AppColor.mainGray),
      ),
      isObsecure: isObscure,
      controller: widget.controller,
      validation: widget.validation?? (value) => AppValidation.password(context, value),
      borderColor: widget.borderColor,
      textColor: widget.textColor,
      keyboard: TextInputType.visiblePassword,
      errorText: widget.errorText,
    );
  }
}

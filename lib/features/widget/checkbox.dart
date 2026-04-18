import 'package:modares/core/resources/app_color.dart';
import 'package:flutter/material.dart';

class CheckboxCustom extends StatefulWidget {
  const CheckboxCustom({super.key});

  @override
  State<CheckboxCustom> createState() => _CheckboxCustomState();
}

class _CheckboxCustomState extends State<CheckboxCustom> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      side: const BorderSide(
        color: AppColor.primeryColor,
        width: 2
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: AppColor.primeryColor,
      checkColor: AppColor.mainWhite,
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_text_style.dart';

class CustomDropDown extends StatelessWidget {
  final ValueNotifier<String?> selectedValue;
  final List<String> items;
final Function(String?) onChanged;
  final Widget hint;

  const CustomDropDown({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: hint,
        valueListenable: selectedValue,
        items: items.toSet().map((item) {
          return DropdownItem<String>(value: item, child: Text(item));
        }).toList(),

        onChanged: onChanged,

        buttonStyleData: ButtonStyleData(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey, width: 1.5),
            color: Colors.white,
          ),
        ),

        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        ),

        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 28,
        ),
        style: AppTextStyle.primaryStyle.copyWith(fontSize: 16),
      ),
    );
  }
}

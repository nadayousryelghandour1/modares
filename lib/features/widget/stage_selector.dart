import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/l10n/app_localizations.dart';

enum StudentStage {
  primary1,
  primary2,
  primary3,
  primary4,
  primary5,
  primary6,
  preparatory1,
  preparatory2,
  preparatory3,
  secondary1,
  secondary2,
  secondary3,
}

class StageSelector extends StatefulWidget {
  final ValueChanged<int?> onChanged;
  final bool? isEnabled;
  final int? val;

  const StageSelector({
    super.key,
    required this.onChanged,
    this.isEnabled,
    this.val,
  });

  @override
  State<StageSelector> createState() => _StageSelectorState();
}

class _StageSelectorState extends State<StageSelector> {
  Map<String, dynamic>? selected;
  String _getLocalizedStage(String key, AppLocalizations loc) {
    switch (key) {
      case "stage_primary_1":
        return loc.stage_primary_1;
      case "stage_primary_2":
        return loc.stage_primary_2;
      case "stage_primary_3":
        return loc.stage_primary_3;
      case "stage_primary_4":
        return loc.stage_primary_4;
      case "stage_primary_5":
        return loc.stage_primary_5;
      case "stage_primary_6":
        return loc.stage_primary_6;

      case "stage_preparatory_1":
        return loc.stage_preparatory_1;
      case "stage_preparatory_2":
        return loc.stage_preparatory_2;
      case "stage_preparatory_3":
        return loc.stage_preparatory_3;

      case "stage_secondary_1":
        return loc.stage_secondary_1;
      case "stage_secondary_2":
        return loc.stage_secondary_2;
      case "stage_secondary_3":
        return loc.stage_secondary_3;

      default:
        return "";
    }
  }

  final List<Map<String, dynamic>> stages = [
    {"id": 0, "key": "stage_primary_1"},
    {"id": 1, "key": "stage_primary_2"},
    {"id": 2, "key": "stage_primary_3"},
    {"id": 3, "key": "stage_primary_4"},
    {"id": 4, "key": "stage_primary_5"},
    {"id": 5, "key": "stage_primary_6"},

    {"id": 6, "key": "stage_preparatory_1"},
    {"id": 7, "key": "stage_preparatory_2"},
    {"id": 8, "key": "stage_preparatory_3"},

    {"id": 9, "key": "stage_secondary_1"},
    {"id": 10, "key": "stage_secondary_2"},
    {"id": 11, "key": "stage_secondary_3"},
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final selectedValue = widget.val != null
        ? stages.firstWhere((stage) => stage["id"] == widget.val)
        : selected;
    return DropdownButtonFormField<Map<String, dynamic>>(
      value: selectedValue ?? selected,
      focusColor: AppColor.mainWhite,
      decoration: InputDecoration(
        fillColor: AppColor.mainWhite,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintText: loc.choose_stage,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryTextColor, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        enabled: widget.isEnabled ?? true
      ),
      items: stages.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(_getLocalizedStage(e['key'], loc)),
        );
      }).toList(),
      onChanged: widget.isEnabled == false
          ? null
          : (value) {
              setState(() {
                selected = value;
              });
              widget.onChanged(value?['id']);
            },
      style: TextStyle(
        fontFamily: 'Cairo',
        fontSize: 18,
        color: AppColor.primaryTextColor,
        fontWeight: FontWeight.w500,
        height: 1.4,
      ),
      validator: (value) {
        if (value == null) {
          return loc.stage_error;
        }
        return null;
      },
    );
  }
}

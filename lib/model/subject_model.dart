import 'package:flutter/widgets.dart';

class SubjectModel {
  final int id;
  final String labelKey;
  final IconData icon;
  final Color color;

  SubjectModel({
    required this.id,
    required this.labelKey,
    required this.icon,
    required this.color,
  });
}
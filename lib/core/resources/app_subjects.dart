import 'package:flutter/material.dart';
import 'package:modares/model/stage_model.dart';
import 'package:modares/model/subject_model.dart';

final Map<String, Map<String, dynamic>> subjectVisuals = {
  "arabic": {"color": Color(0xFFFF8C42), "icon": Icons.menu_book_rounded},
  "mathematics": {"color": Color(0xFF4F46E5), "icon": Icons.calculate_rounded},
  "science": {"color": Color(0xFF10B981), "icon": Icons.science_rounded},
  "socialStudies": {"color": Color(0xFFF59E0B), "icon": Icons.public_rounded},
  "english": {"color": Color(0xFF3B82F6), "icon": Icons.translate_rounded},
  "pureMathematics": {
    "color": Color(0xFF8B5CF6),
    "icon": Icons.functions_rounded,
  },
  "appliedMathematics": {
    "color": Color(0xFF06B6D4),
    "icon": Icons.analytics_rounded,
  },
  "physics": {"color": Color(0xFFEF4444), "icon": Icons.bolt_rounded},
  "chemistry": {
    "color": Color(0xFFEC4899),
    "icon": Icons.science, // مفيش rounded بنفس الشكل
  },
  "biology": {"color": Color(0xFF22C55E), "icon": Icons.biotech_rounded},
  "philosophy": {"color": Color(0xFFA855F7), "icon": Icons.psychology_rounded},
  "psychology": {"color": Color(0xFF6366F1), "icon": Icons.psychology_rounded},
  "geography": {"color": Color(0xFF14B8A6), "icon": Icons.public_rounded},
  "history": {"color": Color(0xFFF97316), "icon": Icons.menu_book_rounded},
};
final rawStagesData = [
  {
    "stage": "1", // ابتدائي
    "subjects": [
      {"id": 1, "labelKey": "arabic"},
      {"id": 3, "labelKey": "mathematics"},
      {"id": 4, "labelKey": "science"},
      {"id": 5, "labelKey": "socialStudies"},
      {"id": 2, "labelKey": "english"},
    ],
  },
  {
    "stage": "2", // إعدادي
    "subjects": [
      {"id": 1, "labelKey": "arabic"},
      {"id": 3, "labelKey": "mathematics"},
      {"id": 4, "labelKey": "science"},
      {"id": 5, "labelKey": "socialStudies"},
      {"id": 2, "labelKey": "english"},
    ],
  },
  {
    "stage": "3", // ثانوي علمي
    "subjects": [
      {"id": 1, "labelKey": "arabic"},
      {"id": 2, "labelKey": "english"},
      {"id": 8, "labelKey": "physics"},
      {"id": 9, "labelKey": "chemistry"},
      {"id": 10, "labelKey": "biology"},

      // نفس ID الرياضيات
      {"id": 3, "labelKey": "pureMathematics"},
      {"id": 3, "labelKey": "appliedMathematics"},
    ],
  },
  {
    "stage": "4", // ثانوي أدبي
    "subjects": [
      {"id": 1, "labelKey": "arabic"},
      {"id": 2, "labelKey": "english"},
      {"id": 12, "labelKey": "philosophy"},
      {"id": 13, "labelKey": "psychology"},
      {"id": 14, "labelKey": "geography"},
      {"id": 15, "labelKey": "history"},
    ],
  },
];

List<StageModel> stagesData = rawStagesData.map((stage) {
  return StageModel(
    stage: stage["stage"] as String,
    subjects: (stage["subjects"] as List).map((sub) {
      final visual = subjectVisuals[sub["labelKey"]];

      return SubjectModel(
        id: sub["id"],
        labelKey: sub["labelKey"],
        icon: visual!["icon"],
        color: visual["color"],
      );
    }).toList(),
  );
}).toList();

final filteredStages = stagesData.where((stage) => stage.stage == "3").first;
List<String> getSubjectKeys(List<int> subjectIds) {
  final List<String> subjectKeys = [];

  for (var stage in rawStagesData) {
    final subjects = stage["subjects"] as List;

    for (var subject in subjects) {
      if (subjectIds.contains(subject["id"])) {
        subjectKeys.add(subject["labelKey"] as String);
      }
    }
  }

  return subjectKeys.toSet().toList();
}
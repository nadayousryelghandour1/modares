import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_subjects.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/l10n/app_localizations.dart';

class SubjectsSection extends StatelessWidget {
  final List<int> subjectIds;

  const SubjectsSection({super.key, required this.subjectIds});

  @override
  Widget build(BuildContext context) {
    final subjectKeys = getSubjectKeys(subjectIds);
    final loc = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "المواد التي أدرسها",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.primaryTextColor,
          ),
        ),
        const SizedBox(height: 24),

        Wrap(
          alignment: WrapAlignment.start,
          // spacing: 16,
          // runSpacing: 16,
          children: subjectKeys.map((key) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.mainWhite,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColor.mainGray.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: Text(
                _localizedSubjectName(key, loc),
                style: AppTextStyle.primaryStyle.copyWith(fontSize: 16),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _localizedSubjectName(String labelKey, AppLocalizations loc) {
    switch (labelKey) {
      case 'arabic':
        return loc.arabic;
      case 'mathematics':
        return loc.mathematics;
      case 'science':
        return loc.science;
      case 'socialStudies':
        return loc.socialStudies;
      case 'english':
        return loc.english;
      case 'physics':
        return loc.physics;
      case 'chemistry':
        return loc.chemistry;
      case 'biology':
        return loc.biology;
      case 'pureMathematics':
        return loc.pureMathematics;
      case 'appliedMathematics':
        return loc.appliedMathematics;
      case 'philosophy':
        return loc.philosophy;
      case 'psychology':
        return loc.psychology;
      case 'geography':
        return loc.geography;
      case 'history':
        return loc.history;
      default:
        return labelKey;
    }
  }
}

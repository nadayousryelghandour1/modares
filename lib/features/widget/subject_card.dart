import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/widget/no_courses.dart';
import 'package:modares/l10n/app_localizations.dart';
import 'package:modares/model/subject_model.dart';

class SubjectCard extends StatelessWidget {
  final SubjectModel subject;
  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>NoCourses()));
      },
      child: SizedBox(
        width: 130,
        height: 130,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 88,
                height: 88,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Color.lerp(subject.color, Colors.white, 0.85)!,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: Icon(subject.icon, color: subject.color, size: 50)),
              ),
            ),
            SizedBox(height: 5),
            Text(
              _localizedSubjectName(subject.labelKey, loc),
              style: AppTextStyle.subjectCardStyle,
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
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

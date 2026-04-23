import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/l10n/app_localizations.dart';

class OweNone extends StatelessWidget {
  const OweNone({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      child: Column(
        children: [
          Image.asset(AppImage.container),
          Text(
            loc.noCoursesTitle,
            textAlign: TextAlign.center,
          ),
          Text(
            loc.noCoursesDescription,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.secondaryColor.withAlpha(30),
              ),
              child: Text(loc.noCoursesBrowseButton),
            ),
          ),
        ],
      ),
    );
  }
}

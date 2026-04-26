import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_button.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/features/bottom_nav_bar/view.dart';
import 'package:modares/l10n/app_localizations.dart';

class NoCourses extends StatelessWidget {
  const NoCourses({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImage.container),
                Text(
                  loc.noCoursesTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.primaryStyle.copyWith(fontSize: 24),
                ),
                Text(
                  loc.noCoursesDescription,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.secondaryStyle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24),
                AppButton(
                  text: loc.noCoursesBrowseButton,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => Home(initialIndex: 1)),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

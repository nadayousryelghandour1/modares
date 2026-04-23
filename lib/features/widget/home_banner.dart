import 'package:flutter/material.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/l10n/app_localizations.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Text(AppLocalizations.of(context)!.welcome,
              style: AppTextStyle.primaryStyle
              ),
              Text(AppLocalizations.of(context)!.desc,
              style: AppTextStyle.secondaryStyle
              ),
            ],
          ),
          // Image.asset(AppImage.background),
        ],
      ),
    );
  }
}

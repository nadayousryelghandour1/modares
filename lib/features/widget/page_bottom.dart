

// import 'package:final_app/core/resources/app_text_style.dart';
import 'package:flutter/material.dart';

class PageBottom extends StatelessWidget {
  final String question;
  final String answer;
  final GestureTapCallback navigator;
  const PageBottom({
    super.key,
    required this.question,
    required this.answer,
    required this.navigator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          Text(
            question,
            // style: AppTextStyle.secondaryStyle,
          ),
          GestureDetector(
            onTap: navigator,
            child: Text(
            answer,
            // style: AppTextStyle.primaryStyle.copyWith(fontSize: 16),
          ),
          ),
        ],
      ),
    );
  }
}

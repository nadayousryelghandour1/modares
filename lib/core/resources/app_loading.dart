import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modares/core/resources/app_image.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Lottie.asset(AppImage.loading, fit: BoxFit.fill)),
    );
  }
}
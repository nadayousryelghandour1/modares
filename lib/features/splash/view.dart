// ignore_for_file: use_build_context_synchronously

import 'package:modares/core/resources/app_image.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/features/bottom_nav_bar/view.dart';
// import 'package:final_app/features/bottom_nav_bar/view.dart';
import 'package:modares/features/login/view.dart';
import 'package:flutter/material.dart';
import 'package:modares/features/widget/shimmer_logo.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 6), () async {
      CacheHelper.getToken().then((val) {
        if (val.isNotEmpty) {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        } else {
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.splashScreenBackground),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: ShimmerLogo(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 81, 90, 110).withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Text(
                    "مُ",
                    style: TextStyle(fontSize: 54, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

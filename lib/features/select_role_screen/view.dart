import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_field.dart';
import 'package:modares/l10n/app_localizations.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 20),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.65,
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ClipPath(
                            clipper: WaveClipperTwo(reverse: true),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.88,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColor.primeryColorDark,
                                    AppColor.primeryColor,
                                    AppColor.primeryColorDark,
                                    AppColor.primeryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 100,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.signup_title,
                                      style: TextStyle(
                                        color: AppColor.primeryColor,
                                        fontSize: 48,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                    SizedBox(height: 36),
                                    Form(
                                      child: Column(
                                        children: [
                                          AppField(
                                            title: AppLocalizations.of(
                                              context,
                                            )!.signup_email,
                                            hint: "example@gmail.com",
                                            // validation: AppValidation.email,
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

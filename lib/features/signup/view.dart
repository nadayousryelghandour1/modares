import 'dart:ui';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modares/bloc/auth/auth_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_button.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_field.dart';
import 'package:modares/core/resources/app_loading.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/app_validation.dart';
import 'package:modares/core/resources/background.dart';
import 'package:modares/core/resources/snack_bar.dart';
import 'package:modares/features/widget/custom_password.dart';
import 'package:modares/features/widget/stage_selector.dart';
import 'package:modares/l10n/app_localizations.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = getIt<AuthBloc>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is SignUpFailure) {
            showMySnackBar(
              msg: state.message ?? "Sorry...Create Account Failed",
              type: AnimatedSnackBarType.error,
              context: context,
            );
          } else if (state is SignUpSuccess) {
            showMySnackBar(
              msg: "Account Created Successfuly",
              type: AnimatedSnackBarType.success,
              context: context,
            );
            // Navigator.of(
            //   context,
            // ).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
          }
        },
        builder: (context, state) {
          Map? errors;
          String? message;
          if (state is SignUpFailure) {
            errors = state.errors;
            message = state.message ?? "";
          } else if (state is SignUpLoading) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  Positioned.fill(child: MudarrisBackground()),
                  Center(child: AppLoading()),
                ],
              ),
            );
          }
          return SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                  Positioned.fill(child: MudarrisBackground()),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.02),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 48,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.signup_title,
                                    style:
                                        AppTextStyle.primaryStyleSignUpScreen,
                                  ),
                                  SizedBox(height: 40),
                                  Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        AppField(
                                          title: AppLocalizations.of(
                                            context,
                                          )!.signup_name,
                                          hint: AppLocalizations.of(
                                            context,
                                          )!.signup_name,
                                          controller: bloc.signupNameController,
                                          keyboard: TextInputType.name,
                                          validation: (value) =>
                                              AppValidation.name(
                                                context,
                                                value,
                                              ),
                                        ),
                                        SizedBox(height: 20),
                                        AppField(
                                          title: AppLocalizations.of(
                                            context,
                                          )!.signup_email,
                                          hint: "example@gmail.com",
                                          controller:
                                              bloc.signupEmailController,
                                          keyboard: TextInputType.emailAddress,
                                          validation: (value) =>
                                              AppValidation.email(
                                                context,
                                                value,
                                              ),
                                          errorText: errors?['email'] != null
                                              ? AppLocalizations.of(
                                                  context,
                                                )!.emailNotCorrect
                                              : message != null
                                              ? AppLocalizations.of(
                                                  context,
                                                )!.email_already_exists
                                              : null,
                                        ),
                                        SizedBox(height: 20),
                                        AppField(
                                          title: AppLocalizations.of(
                                            context,
                                          )!.signup_phone,
                                          hint: "01 xx xxx xxxx",
                                          controller:
                                              bloc.signupPhoneController,
                                          keyboard: TextInputType.phone,
                                          validation: (value) =>
                                              AppValidation.phone(
                                                context,
                                                value,
                                              ),
                                        ),
                                        SizedBox(height: 20),
                                        CustomPassword(
                                          title: AppLocalizations.of(
                                            context,
                                          )!.signup_password,
                                          hint: "********",
                                          controller:
                                              bloc.signupPasswordController,
                                        ),
                                        SizedBox(height: 20),
                                        CustomPassword(
                                          title: AppLocalizations.of(
                                            context,
                                          )!.signup_confirmPassword,
                                          hint: "********",
                                          controller: bloc
                                              .signupConfirmPasswordController,
                                          validation: (value) =>
                                              AppValidation.confirmPassword(
                                                context,
                                                value,
                                                bloc
                                                    .signupPasswordController
                                                    .text,
                                              ),
                                        ),
                                        SizedBox(height: 20),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.choose_stage,
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color:
                                                    AppColor.primaryTextColor,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            StageSelector(
                                              onChanged: (stage) {
                                                bloc
                                                    .signupGradeIdController
                                                    .text = stage
                                                    .toString();
                                              },
                                            ),
                                          ],
                                        ),

                                        // SizedBox(height: 20),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         CheckboxCustom(),
                                        //         Text(
                                        //           AppLocalizations.of(
                                        //             context,
                                        //           )!.login_remember,
                                        //           style: AppTextStyle
                                        //               .primaryStyleLoginScreen
                                        //               .copyWith(
                                        //                 fontSize: 16,
                                        //                 fontWeight: FontWeight.w400,
                                        //               ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     Text(
                                        //       AppLocalizations.of(
                                        //         context,
                                        //       )!.login_forgotPassword,
                                        //       style: AppTextStyle
                                        //           .primaryStyleLoginScreen
                                        //           .copyWith(
                                        //             fontSize: 16,
                                        //             fontWeight: FontWeight.w400,
                                        //           ),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(height: 40),
                                        AppButton(
                                          text: AppLocalizations.of(
                                            context,
                                          )!.signup_create,
                                          onTap: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              // if(sta)
                                              bloc.add(SignUpEvent());
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.signup_haveAccount,
                                        style: AppTextStyle
                                            .primaryStyleLoginScreen
                                            .copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                      SizedBox(width: 8),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.signup_login,
                                          style: AppTextStyle
                                              .primaryStyleLoginScreen
                                              .copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: AppColor.secondaryColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

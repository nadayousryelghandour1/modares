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
import 'package:modares/features/bottom_nav_bar/view.dart';
import 'package:modares/features/signup/view.dart';
import 'package:modares/features/widget/checkbox.dart';
import 'package:modares/features/widget/custom_password.dart';
import 'package:modares/features/widget/forget_password.dart';
import 'package:modares/l10n/app_localizations.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  void showSignupSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (context) {
        return const SignUp();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc bloc = getIt<AuthBloc>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColor.mainWhite,
          body: BlocConsumer<AuthBloc, AuthState>(
            bloc: bloc,
            listener: (context, state) {
              if (state is LoginFailure) {
                showMySnackBar(
                  msg: "sorry...Login Failed",
                  type: AnimatedSnackBarType.error,
                  context: context,
                );
              } else if (state is LoginSuccess) {
                showMySnackBar(
                  msg: "Loged In Successfuly",
                  type: AnimatedSnackBarType.success,
                  context: context,
                );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }
            },
            builder: (context, state) {
              Map? errors;
              String? message;
              if (state is LoginFailure) {
                errors = state.errors;
                message = state.message ?? "";
              } else if (state is LoginLoading) {
                return AppLoading();
              }
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned.fill(child: MudarrisBackground()),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: MediaQuery.of(context).size.height * 0.85,
                            alignment: Alignment.center,
                            color: Colors.black.withOpacity(0.02),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 32,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center, // رأسي
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.login_title,
                                      style:
                                          AppTextStyle.primaryStyleLoginScreen,
                                    ),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.login_loginDesc,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle
                                          .primaryStyleLoginScreen
                                          .copyWith(
                                            color: AppColor.mainGray,
                                            fontSize: 16,
                                          ),
                                    ),
                                    SizedBox(height: 40),
                                    Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          AppField(
                                            title: AppLocalizations.of(
                                              context,
                                            )!.login_email,
                                            hint: "example@gmail.com",
                                            controller:
                                                bloc.loginEmailController,
                                            validation: (value) =>
                                                AppValidation.email(
                                                  context,
                                                  value,
                                                ),
                                            keyboard:
                                                TextInputType.emailAddress,
                                            errorText: errors?['email'] != null
                                                ? AppLocalizations.of(
                                                    context,
                                                  )!.emailNotCorrect
                                                : null,
                                          ),
                                          SizedBox(height: 20),
                                          CustomPassword(
                                            title: AppLocalizations.of(
                                              context,
                                            )!.login_password,
                                            hint: "********",
                                            controller:
                                                bloc.loginPasswordController,
                                            errorText: message != null
                                                ? AppLocalizations.of(
                                                    context,
                                                  )!.passwordNotCorrect
                                                : null,
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  CheckboxCustom(),
                                                  Text(
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.login_remember,
                                                    style: AppTextStyle
                                                        .primaryStyleLoginScreen
                                                        .copyWith(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  showResetPasswordBottomSheet(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.login_forgotPassword,
                                                  style: AppTextStyle
                                                      .primaryStyleLoginScreen
                                                      .copyWith(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 40),
                                          AppButton(
                                            text: AppLocalizations.of(
                                              context,
                                            )!.login,
                                            onTap: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                bloc.add(LoginEvent());
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.login_noAccount,
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
                                            showSignupSheet(context);
                                          },
                                          child: Text(
                                            AppLocalizations.of(
                                              context,
                                            )!.login_createAccount,
                                            style: AppTextStyle
                                                .primaryStyleLoginScreen
                                                .copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color:
                                                      AppColor.secondaryColor,
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
              );
            },
          ),
        ),
      ],
    );
  }
}

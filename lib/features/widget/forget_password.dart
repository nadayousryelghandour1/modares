import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modares/bloc/auth/auth_bloc.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/app_button.dart';
import 'package:modares/core/resources/app_color.dart';
import 'package:modares/core/resources/app_field.dart';
import 'package:modares/core/resources/app_text_style.dart';
import 'package:modares/core/resources/app_validation.dart';
import 'package:modares/core/resources/snack_bar.dart';
import 'package:modares/features/widget/custom_password.dart';
import 'package:modares/l10n/app_localizations.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

void showResetPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const ResetPasswordBottomSheet(),
  );
}

class ResetPasswordBottomSheet extends StatefulWidget {
  const ResetPasswordBottomSheet({super.key});

  @override
  State<ResetPasswordBottomSheet> createState() =>
      _ResetPasswordBottomSheetState();
}

class _ResetPasswordBottomSheetState extends State<ResetPasswordBottomSheet> {
  int currentStep = 0;
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final AuthBloc bloc = getIt<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is RequestOTPFailure) {
          showMySnackBar(
            msg: state.message ?? "Unexpected Error Occur",
            type: AnimatedSnackBarType.error,
            context: context,
          );
        } else if (state is OTPFailure) {
          showMySnackBar(
            msg: state.message ?? "Unexpected Error Occur",
            type: AnimatedSnackBarType.error,
            context: context,
          );
        } else if (state is ResetPasswordFailure) {
          showMySnackBar(
            msg: state.message ?? "Unexpected Error Occur",
            type: AnimatedSnackBarType.error,
            context: context,
          );
        } else if (state is RequestOTPSuccess) {
          currentStep = 1;
        } else if (state is OTPSuccess) {
          currentStep = 2;
        } else if (state is ResetPasswordSuccess) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.mainBackground,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: bottomInset,
              left: 20,
              right: 20,
              top: 20,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: AppColor.mainBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    const SizedBox(height: 32),

                    if (currentStep == 0) ...[
                      Text(
                        "البريد الإلكتروني",
                        style: AppTextStyle.primaryStyle,
                      ),
                      const SizedBox(height: 32),

                      AppField(
                        title: AppLocalizations.of(context)!.login_email,
                        hint: "example@gmail.com",
                        controller: emailController,
                        keyboard: TextInputType.emailAddress,
                        validation: (value) =>
                            AppValidation.email(context, value),
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          onTap: () {
                            if (!formKey.currentState!.validate()) {
                              print(
                                "================================${formKey.currentState!.validate()}",
                              );
                              showMySnackBar(
                                msg: "Please Enter a Vaild Email",
                                type: AnimatedSnackBarType.error,
                                context: context,
                              );
                            } else {
                              currentStep = 1;
                              bloc.add(
                                ForgetPasswordEvent(
                                  email: emailController.text,
                                ),
                              );
                            }
                          },
                          text: "التالي",
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],

                    if (currentStep == 1) ...[
                      Text(
                        "إدخال رمز التحقق",
                        style: AppTextStyle.primaryStyle,
                      ),
                      const SizedBox(height: 32),
                      PinCodeTextField(
                        controller: otpController,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        pinBoxWidth: 45,
                        pinBoxHeight: 55,
                        pinBoxRadius: 12,
                        pinBoxBorderWidth: 1.5,
                        hasUnderline: false,

                        defaultBorderColor: Colors.grey,
                        hasTextBorderColor: Theme.of(context).primaryColor,
                        highlight: true,
                        highlightColor: Theme.of(context).primaryColor,

                        pinBoxColor: Colors.white,

                        pinTextStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),

                        onTextChanged: (value) {},

                        onDone: (value) {
                          bloc.add(
                            VerifyOTP(otp: value, email: emailController.text),
                          );
                        },
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          onTap: () {
                            if (otpController.text.length != 6) {
                              showMySnackBar(
                                msg: "Please Enter a Vaild OTP",
                                type: AnimatedSnackBarType.error,
                                context: context,
                              );
                            }
                          },
                          text: "التالي",
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],

                    if (currentStep == 2) ...[
                      Text(
                        "تعيين كلمة مرور جديدة",
                        style: AppTextStyle.primaryStyle,
                      ),
                      CustomPassword(
                        title: AppLocalizations.of(context)!.signup_password,
                        hint: "********",
                        controller: passwordController,
                      ),

                      const SizedBox(height: 16),

                      CustomPassword(
                        title: AppLocalizations.of(
                          context,
                        )!.signup_confirmPassword,
                        hint: "********",
                        controller: confirmPasswordController,
                      ),
                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: AppButton(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              if (confirmPasswordController.text ==
                                  passwordController.text) {
                                bloc.add(
                                  ChangePassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    conformPassword:
                                        confirmPasswordController.text,
                                  ),
                                );
                              } else {
                                showMySnackBar(
                                  msg: "Please Confirm Your Password",
                                  type: AnimatedSnackBarType.error,
                                  context: context,
                                );
                              }
                            } else {
                              showMySnackBar(
                                msg: "Please Enter Requested Data",
                                type: AnimatedSnackBarType.error,
                                context: context,
                              );
                            }
                          },
                          text: "تأكيد",
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

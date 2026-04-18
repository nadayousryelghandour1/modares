import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/model/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiConsumer api;

  GlobalKey<FormState> loginFormKey = GlobalKey();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  TextEditingController signupGradeIdController = TextEditingController();

  AuthBloc() : api = getIt<ApiConsumer>(), super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await api.post(
          EndPoints.login,
          data: {
            ApiKey.email: loginEmailController.text,
            ApiKey.password: loginPasswordController.text,
            ApiKey.role: 0,
          },
        );
        final user = AuthModel.fromJson(response);
        CacheHelper.saveToken(user.token);
        emit(LoginSuccess());
      } on ServerException catch (e) {
        emit(
          LoginFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });

    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      try {
        final response = await api.post(
          EndPoints.register,
          data: {
            ApiKey.name: signupNameController.text,
            ApiKey.email: signupEmailController.text,
            ApiKey.phoneNumber: signupPhoneController.text,
            ApiKey.password: signupPasswordController.text,
            ApiKey.confirmPassword: signupConfirmPasswordController.text,
            ApiKey.role: 0,
            ApiKey.gridId: int.tryParse(signupGradeIdController.text) ?? 0,
          },
        );
        final user = AuthModel.fromJson(response);
        CacheHelper.saveToken(user.token);
        emit(SignUpSuccess());
      } on ServerException catch (e) {
        emit(
          SignUpFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });

    // on<EditAccountDetails>((event, emit) async {
    //   try {
    //     // ignore: unused_local_variable
    //     final response = await api.put(
    //       EndPoints.account,
    //       data: {
    //         ApiKey.firstName: firstName.text,
    //         ApiKey.lastName: lastName.text,
    //         ApiKey.userName: userName.text,
    //         ApiKey.phoneNumber: phoneNumber.text.isEmpty
    //             ? null
    //             : phoneNumber.text,
    //       },
    //     );
    //     emit(EditAccountDetailsSuccess());
    //   } on ServerException catch (e) {
    //     emit(
    //       EditAccountDetailsFailure(
    //         errMessage: e.errorModel.message,
    //         errors: e.errorModel.error,
    //       ),
    //     );
    //   }
    // });

    // on<ChangedPassword>((event, emit) async {
    //   try {
    //     // ignore: unused_local_variable
    //     final response = await api.put(
    //       EndPoints.changePassword,
    //       data: {
    //         ApiKey.newPassword: newPassword.text,
    //         ApiKey.currentPassword: currentPassword.text,
    //       },
    //     );
    //     emit(ChangePasswordSuccess());
    //   } on ServerException catch (e) {
    //     emit(
    //       ChangePasswordFailure(
    //         errMessage: e.errorModel.message,
    //         errors: e.errorModel.error,
    //       ),
    //     );
    //   }
    // });

    // on<VerifyOtp>((event, emit) async {
    //   try {
    //     // ignore: unused_local_variable
    //     final response = await api.post(
    //       EndPoints.otp,
    //       data: {ApiKey.otp: forgetPasswordOtp.text, ApiKey.email: email.text},
    //     );
    //     emit(VerifySuccess());
    //   } on ServerException catch (e) {
    //     emit(
    //       VerifyFailure(
    //         errMessage: e.errorModel.message,
    //         errors: e.errorModel.error,
    //       ),
    //     );
    //   }
    // });
  }
}

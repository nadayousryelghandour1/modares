import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/network/services/device_id_service.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/model/auth_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

handelStage(grade) {
  if (grade >= 1 && grade <= 6) {
    return '1';
  } else if (grade >= 7 && grade <= 9) {
    return '2';
  } else {
    return '4';
  }
}

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
      final String deviceId = await getDeviceId();
      final String fingerprint = await getFingerprint();

      emit(LoginLoading());
      try {
        final response = await api.post(
          EndPoints.login,
          data: {
            ApiKey.email: loginEmailController.text,
            ApiKey.password: loginPasswordController.text,
            ApiKey.role: 0,
            ApiKey.deviceId: deviceId,
            ApiKey.fingerprint: fingerprint,
          },
        );
        final user = AuthModel.fromJson(response);
        CacheHelper.saveToken(user.token);
        CacheHelper.saveUser(user.user);
        emit(LoginSuccess());
        loginEmailController.clear();
        loginPasswordController.clear();
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
      final String deviceId = await getDeviceId();
      final String fingerprint = await getFingerprint();
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
            ApiKey.deviceId: deviceId,
            ApiKey.fingerprint: fingerprint,
          },
        );
        final user = AuthModel.fromJson(response);
        CacheHelper.saveToken(user.token);
        CacheHelper.saveUser(user.user);
        emit(SignUpSuccess());
        signupNameController.clear();
        signupEmailController.clear();
        signupPasswordController.clear();
        signupPhoneController.clear();
        signupConfirmPasswordController.clear();
        signupGradeIdController.clear();
      } on ServerException catch (e) {
        emit(
          SignUpFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });

    on<ForgetPasswordEvent>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.post(
          EndPoints.forgetPassword,
          queryParameters: {ApiKey.email: event.email},
        );
        emit(RequestOTPSuccess(email: event.email));
      } on ServerException catch (e) {
        emit(
          RequestOTPFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });

    on<VerifyOTP>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.post(
          EndPoints.verifyOtp,
          queryParameters: {
            ApiKey.code: event.otp,
            ApiKey.email: event.email,
          },
        );
        emit(OTPSuccess(email: event.email));
      } on ServerException catch (e) {
        emit(
          OTPFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });

    on<ChangePassword>((event, emit) async {
      try {
        // ignore: unused_local_variable
        final response = await api.post(
          EndPoints.changePassword,
          data: {
            ApiKey.email: event.email,
            ApiKey.password: event.password,
            ApiKey.confirmPassword: event.conformPassword,
          },
        );
        emit(ResetPasswordSuccess());
      } on ServerException catch (e) {
        emit(
          ResetPasswordFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });

    
  }
}

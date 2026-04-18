part of 'auth_bloc.dart';

class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final dynamic errors;
  final String? message;

  LoginFailure({required this.errors, this.message});
}

final class SignUpSuccess extends AuthState {}

final class SignUpLoading extends AuthState {}

final class SignUpFailure extends AuthState {
  final dynamic errors;
  final String? message;

  SignUpFailure({required this.errors, this.message});
}

final class ForgetPasswordSuccess extends AuthState {}

final class ForgetPasswordFailure extends AuthState {
  final String errMessage;
  final dynamic errors;

  ForgetPasswordFailure({required this.errMessage, required this.errors});
}

final class OTPSuccess extends AuthState {}

final class OTPFailure extends AuthState {
  final String errMessage;
  final dynamic errors;

  OTPFailure({required this.errMessage, required this.errors});
}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordFailure extends AuthState {
  final String errMessage;
  final dynamic errors;

  ResetPasswordFailure({required this.errMessage, required this.errors});
}

final class SignOut extends AuthState {}

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

final class RequestOTPSuccess extends AuthState {
  final String email;

  RequestOTPSuccess({required this.email});
}

final class RequestOTPFailure extends AuthState {
  final dynamic errors;
  final String? message;

  RequestOTPFailure({required this.errors, required this.message});
}

final class OTPSuccess extends AuthState {
  final String email;

  OTPSuccess({required this.email});
}

final class OTPFailure extends AuthState {
  final dynamic errors;
  final String? message;

  OTPFailure({required this.errors, required this.message});
}

final class ResetPasswordSuccess extends AuthState {}

final class ResetPasswordFailure extends AuthState {
  final dynamic errors;
  final String? message;

  ResetPasswordFailure({required this.errors, required this.message});
}

final class AccountDeleteSuccess extends AuthState {}

final class AccountDeleteFailure extends AuthState {
  final dynamic errors;
  final String? message;

  AccountDeleteFailure({required this.errors, required this.message});
}

final class LogoutSuccess extends AuthState {}

final class LogoutFailure extends AuthState {
  final dynamic errors;
  final String? message;

  LogoutFailure({required this.errors, required this.message});
}

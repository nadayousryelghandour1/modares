// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}

class ForgetPasswordEvent extends AuthEvent {
  final String email;

  ForgetPasswordEvent({required this.email});
}

class VerifyOTP extends AuthEvent {
  final String otp;
  final String email;

  VerifyOTP({required this.otp, required this.email});
}

class ChangePassword extends AuthEvent {
  final String email;
  final String password;
  final String conformPassword;

  ChangePassword({
    required this.email,
    required this.password,
    required this.conformPassword,
  });
}


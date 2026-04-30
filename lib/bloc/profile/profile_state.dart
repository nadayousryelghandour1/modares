part of 'profile_bloc.dart';

class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel profile;

  ProfileSuccess({required this.profile});
}

final class ProfileFailure extends ProfileState {
  final dynamic errors;
  final String? message;

  ProfileFailure({required this.errors, this.message});
}


class ProfileEditSuccess extends ProfileState {}

final class ProfileEditFailure extends ProfileState {
  final dynamic errors;
  final String? message;

  ProfileEditFailure({required this.errors, this.message});
}

final class ProfileImageEditFailure extends ProfileState {
  final dynamic errors;
  final String? message;

  ProfileImageEditFailure({required this.errors, this.message});
}
final class AccountDeleteSuccess extends ProfileState {}

final class AccountDeleteFailure extends ProfileState {
  final dynamic errors;
  final String? message;

  AccountDeleteFailure({required this.errors, required this.message});
}

final class LogoutSuccess extends ProfileState {}

final class LogoutFailure extends ProfileState {
  final dynamic errors;
  final String? message;

  LogoutFailure({required this.errors, required this.message});
}

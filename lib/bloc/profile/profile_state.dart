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

class ProfileEditLoading extends ProfileState {}

class ProfileEditSuccess extends ProfileState {}

final class ProfileEditFailure extends ProfileState {
  final dynamic errors;
  final String? message;

  ProfileEditFailure({required this.errors, this.message});
}

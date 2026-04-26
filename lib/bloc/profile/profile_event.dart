part of 'profile_bloc.dart';

class ProfileEvent {}

class GatProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {}

class EditProfileImageEvent extends ProfileEvent {
  final String image;

  EditProfileImageEvent({required this.image});
}

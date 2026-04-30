part of 'profile_bloc.dart';

class ProfileEvent {}

class GatProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {}

class EditProfileImageEvent extends ProfileEvent {
  final XFile? image;

  EditProfileImageEvent({ this.image});
}
class DeleteAccount extends ProfileEvent {}

class Logout extends ProfileEvent {}

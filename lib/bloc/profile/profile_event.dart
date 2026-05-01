part of 'profile_bloc.dart';

class ProfileEvent {}

class GatProfileEvent extends ProfileEvent {}

class EditProfileEvent extends ProfileEvent {}

class EditProfileImageEvent extends ProfileEvent {
  final XFile? image;

  EditProfileImageEvent({ this.image});
}

// class GetStudentGradesEvent extends ProfileEvent {
//   final int studentId;

//   GetStudentGradesEvent({required this.studentId});

// }

class DeleteAccount extends ProfileEvent {}

class Logout extends ProfileEvent {}

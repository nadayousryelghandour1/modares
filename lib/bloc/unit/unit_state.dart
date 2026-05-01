part of 'unit_bloc.dart';

class UnitState {}

class UnitInitial extends UnitState {}

class UnitLoading extends UnitState  {}

class GetUnitsSuccess extends UnitState {
  final Map<int, Map<int, List<UnitModel>>> units;

  GetUnitsSuccess({required this.units});

}

final class GetUnitsFailure extends UnitState {
  final dynamic errors;
  final String? message;

  GetUnitsFailure({required this.errors, this.message});
}

// class LecturesLoading extends UnitState  {}

// class GetLecturesSuccess extends UnitState {
//   final List<UnitModel> units;

//   GetUnitsSuccess({required this.units});

// }
// final class ProfileEditFailure extends ProfileState {
//   final dynamic errors;
//   final String? message;

//   ProfileEditFailure({required this.errors, this.message});
// }

// final class ProfileImageEditFailure extends ProfileState {
//   final dynamic errors;
//   final String? message;

//   ProfileImageEditFailure({required this.errors, this.message});
// }
// final class AccountDeleteSuccess extends ProfileState {}

// final class AccountDeleteFailure extends ProfileState {
//   final dynamic errors;
//   final String? message;

//   AccountDeleteFailure({required this.errors, required this.message});
// }

// final class LogoutSuccess extends ProfileState {}

// final class LogoutFailure extends ProfileState {
//   final dynamic errors;
//   final String? message;

//   LogoutFailure({required this.errors, required this.message});
// }


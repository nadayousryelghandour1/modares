part of 'teacher_bloc.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object> get props => [];
}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLoadSuccess extends TeacherState {
  final TeacherModel teacher;

  const TeacherLoadSuccess({required this.teacher});
}

class TeacherLoadFailure extends TeacherState {
  final dynamic errors;
  final String? message;

  const TeacherLoadFailure({required this.errors, required this.message});
}

class BeatTeachersLoading extends TeacherState {}

class BestTeachersLoadSuccess extends TeacherState {
  final List<TeacherModel> teachers;

  const BestTeachersLoadSuccess({required this.teachers});
}

class BestTeachersLoadFailure extends TeacherState {
  final dynamic errors;
  final String? message;

  const BestTeachersLoadFailure({required this.errors, required this.message});
}

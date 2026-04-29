part of 'teacher_bloc.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object> get props => [];
}
class GetTeacher extends TeacherEvent{
  final int id;

  const GetTeacher({required this.id});
}
class GetBestTeachers extends TeacherEvent{
  final int count;

  const GetBestTeachers({required this.count});
}
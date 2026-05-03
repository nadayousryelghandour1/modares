part of 'lecture_bloc.dart';

class LectureEvent {}

class GetUnitDetailsEvent extends LectureEvent {
  final int unitId;

  GetUnitDetailsEvent({required this.unitId});

}

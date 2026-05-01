part of 'unit_bloc.dart';

class UnitEvent {}
class GetTeacherUnitsEvent extends UnitEvent {
  final int teacherId;

  GetTeacherUnitsEvent({required this.teacherId});

}

class GetLecturesByUnitIdEvent extends UnitEvent {
  final int unitId;

  GetLecturesByUnitIdEvent({required this.unitId});
}

class GetLecture extends UnitEvent {}

part of 'unit_bloc.dart';

class UnitEvent {}
class GetTeacherUnitsEvent extends UnitEvent {
  final int teacherId;

  GetTeacherUnitsEvent({required this.teacherId});

}


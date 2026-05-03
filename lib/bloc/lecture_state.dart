part of 'lecture_bloc.dart';



class LectureState {}

class LectureInitial extends LectureState {}
class LecturesLoading extends LectureState  {}

class GetLecturesSuccess extends LectureState {
  final List<LectureModel> lectures;

  GetLecturesSuccess({required this.lectures});

}
final class GetLecturesFailure extends LectureState {
  final dynamic errors;
  final String? message;

  GetLecturesFailure({required this.errors, this.message});
}

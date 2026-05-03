import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/model/teacher_model.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final ApiConsumer api;

  TeacherBloc() : api = getIt<ApiConsumer>(), super(TeacherInitial()) {
    on<GetTeacher>((event, emit) async {
      emit(TeacherLoading());
      try {
        final response = await api.get('${EndPoints.getTeacher}/${event.id}');
        final teacher = TeacherModel.fromJson(response['data']);
        emit(TeacherLoadSuccess(teacher: teacher));
      } on ServerException catch (e) {
        emit(
          TeacherLoadFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });

    on<GetBestTeachers>((event, emit) async {
  emit(BeatTeachersLoading());
  try {
    final response = await api.get(EndPoints.getBestTeachers);
    
    final Map<String, dynamic> dataMap = response['data'] as Map<String, dynamic>;
    
    final List<TeacherModel> teachers = dataMap.values
        .expand((list) => (list as List))
        .map((e) => TeacherModel.fromJson(e as Map<String, dynamic>))
        .toList();
    
    emit(BestTeachersLoadSuccess(teachers: teachers));
  } on ServerException catch (e) {
    emit(
      BestTeachersLoadFailure(
        errors: e.errorModel.errors,
        message: e.errorModel.message,
      ),
    );
  }
});
  }
}

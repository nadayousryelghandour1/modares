import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/model/teacher_model.dart';

part 'teacher_search_event.dart';
part 'teacher_search_state.dart';

class TeacherSearchBloc extends Bloc<TeacherSearchEvent, TeacherSearchState> {
  final ApiConsumer api;
  TeacherSearchBloc()
    : api = getIt<ApiConsumer>(),
      super(TeacherSearchInitial()) {
    on<GetAllTeacher>((event, emit) async {
      emit(TeacherSearchLoading());
      try {
        final params = <String, dynamic>{};

        final response = await api.get(
          EndPoints.getTeacher,
          queryParameters: params,
        );

        final List<TeacherModel> teachers = (response['data'] as List)
    .map((e) => TeacherModel.fromJson(e as Map<String, dynamic>))
    .toList();// CacheHelper.saveToken(user.token);
        emit(TeacherLoadedSuccess(teachers: teachers));
      } on ServerException catch (e) {
        emit(
          TeacherLoadedFailure(
            errors: e.errorModel.errors,
            errMessage: e.errorModel.message,
          ),
        );
      }
    });
  }
}

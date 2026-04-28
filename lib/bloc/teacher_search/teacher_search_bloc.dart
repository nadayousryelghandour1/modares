import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/model/teacher_model.dart';

part 'teacher_search_event.dart';
part 'teacher_search_state.dart';

void addIfNotNull(Map map, String key, dynamic value) {
  if (value != null) {
    map[key] = value;
  }
}

class TeacherSearchBloc extends Bloc<TeacherSearchEvent, TeacherSearchState> {
  final ApiConsumer api;
  int? subjectId;
  int? sortBy;
  int? learningMethod;
  String? government;
  TextEditingController teacherName = TextEditingController();
  bool desc = false;

  TeacherSearchBloc()
    : api = getIt<ApiConsumer>(),
      super(TeacherSearchInitial()) {
    on<ApplyFilters>((event, emit) async {
      final user = await CacheHelper.getUser();

      emit(TeacherSearchLoading());

      try {
        // 1️⃣ API filters فقط
        final params = <String, dynamic>{ApiKey.stage: user.grade.stage};

        addIfNotNull(params, ApiKey.subjectId, subjectId);

        addIfNotNull(
          params,
          ApiKey.sortBy,
          sortBy != null ? (sortBy! > 2 ? 2 : sortBy) : null,
        );
        final response = await api.get(
          EndPoints.getTeacher,
          queryParameters: params,
        );

        final List<TeacherModel> teachers = (response['data'] as List)
            .map((e) => TeacherModel.fromJson(e))
            .toList();

        // 2️⃣ LOCAL filters
        List<TeacherModel> filtered = teachers;

        if (government != null) {
          filtered = filtered.where((t) => t.government == government).toList();
        }

        if (teacherName.text != '' && teacherName.text.isNotEmpty) {
          filtered = filtered
              .where(
                (t) => t.name.toLowerCase().contains(
                  teacherName.text.toLowerCase(),
                ),
              )
              .toList();
        }

        if (learningMethod != null) {
          filtered = filtered
              .where((t) => t.teachingMethod == learningMethod)
              .toList();
        }

        // // 3️⃣ sorting local
        // if (sortBy == 3) {
        //   filtered.sort((a, b) => a.price.compareTo(b.price));
        // } else if (sortBy == 4) {
        //   filtered.sort((a, b) => a.price.compareTo(b.price));
        // }

        emit(
          TeacherSearchLoaded(teachers: teachers, displayedTeachers: filtered),
        );
      } catch (e) {
        emit(TeacherSearchError(message: e.toString(), errors: null));
      }
    });

    on<ResetFilters>((event, emit) async {
      final user = await CacheHelper.getUser();

      emit(TeacherSearchLoading());
      sortBy = null;
      government = null;
      teacherName.clear();
      learningMethod = null;
      subjectId = null;
      try {
        final response = await api.get(
          EndPoints.getTeacher,
          queryParameters: {ApiKey.stage: user.grade.stage},
        );

        final List<TeacherModel> teachers = (response['data'] as List)
            .map((e) => TeacherModel.fromJson(e as Map<String, dynamic>))
            .toList();
        emit(
          TeacherSearchLoaded(displayedTeachers: teachers, teachers: teachers),
        );
      } on ServerException catch (e) {
        emit(
          TeacherSearchError(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });
  }
}

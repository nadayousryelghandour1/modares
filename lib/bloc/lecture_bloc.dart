import 'package:bloc/bloc.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/model/lecture.dart';

part 'lecture_event.dart';
part 'lecture_state.dart';

class LectureBloc extends Bloc<LectureEvent, LectureState> {
  ApiConsumer api;
  @override
  LectureBloc() : api = getIt<ApiConsumer>(), super(LectureInitial()) {
    on<GetUnitDetailsEvent>((event, emit) async {
      final user = await CacheHelper.getUser();
      emit(LecturesLoading());
      try {
        final response = await api.get(
          EndPoints.unitDetails,
          queryParameters: {
            ApiKey.unitId: event.unitId,
            ApiKey.studentId: user.id,
          },
        );
        final lectureList = ((response['lectures']) as List<dynamic>? ?? [])
            .map<LectureModel>((e) => LectureModel.fromJson(e))
            .toList();
        emit(GetLecturesSuccess(lectures: lectureList));
      } on ServerException catch (e) {
        emit(
          GetLecturesFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });
  }
}


import 'package:bloc/bloc.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/model/unit_model.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  ApiConsumer api;
  @override
  UnitBloc() : api = getIt<ApiConsumer>(), super(UnitInitial()) {
    on<GetTeacherUnitsEvent>((event, emit) async {
      emit(UnitLoading());
      try {
        final response = await api.get(
          EndPoints.getTeacherUnits,
          queryParameters: {ApiKey.teacherId: event.teacherId},
        );
        final data = UnitsResponseModel.fromJson(response);
        final units = data.units;
        emit(GetUnitsSuccess(units: units));
      } on ServerException catch (e) {
        emit(
          GetUnitsFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/errors/exception.dart';
import 'package:modares/core/network/service_locator.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/model/user_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ApiConsumer api;
  ProfileBloc() : api = getIt<ApiConsumer>(), super(ProfileInitial()) {
    on<GatProfileEvent>((event, emit) async {
      final user = await CacheHelper.getUser();

      emit(ProfileLoading());
      try {
        final response = await api.get('${EndPoints.getProfile}${user.id}');
        final profile = UserModel.fromJson(response['data']);
        emit(ProfileSuccess(profile: profile));
      } on ServerException catch (e) {
        emit(
          ProfileEditFailure(
            errors: e.errorModel.errors,
            message: e.errorModel.message,
          ),
        );
      }
    });
  }
}

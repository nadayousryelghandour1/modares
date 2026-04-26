import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController gradeId = TextEditingController();
  TextEditingController major = TextEditingController();
  bool isEditing = false;
  ProfileBloc() : api = getIt<ApiConsumer>(), super(ProfileInitial()) {
    on<GatProfileEvent>((event, emit) async {
      final user = await CacheHelper.getUser();

      emit(ProfileLoading());
      try {
        final response = await api.get('${EndPoints.getProfile}${user.id}');
        final profile = UserModel.fromJson(response['data']);
        if(isEditing){
          CacheHelper.saveUser(profile);
          isEditing = false;
        }
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
    on<EditProfileEvent>((event, emit) async {
      final user = await CacheHelper.getUser();

      emit(ProfileLoading());
      try {
        final response = await api.put(
          '${EndPoints.getProfile}${user.id}',
          data: {
            ApiKey.id: user.id,
            ApiKey.name: name.text.isEmpty ? user.name : name.text,
            ApiKey.email: email.text.isEmpty ? user.email : email.text,
            ApiKey.phoneNumber: phoneNumber.text.isEmpty
                ? user.phoneNumber
                : phoneNumber.text,
            ApiKey.gridId: gradeId.text.isEmpty
                ? user.gradeId
                : int.tryParse(gradeId.text),
            ApiKey.major: major.text.isEmpty ? user.major : major.text,
          },
        );
        if (response["success"] == true) {
          isEditing = true;
          add(GatProfileEvent());
        }
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

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:modares/bloc/auth/auth_bloc.dart';
import 'package:modares/bloc/chat/chat_bloc.dart';
import 'package:modares/bloc/profile/profile_bloc.dart';
import 'package:modares/bloc/teacher/teacher_bloc.dart';
import 'package:modares/bloc/teacher_search/teacher_search_bloc.dart';
import 'package:modares/bloc/unit/unit_bloc.dart';
import 'package:modares/core/network/api/api_consumer.dart';
import 'package:modares/core/network/api/api_intercepotrs.dart';
import 'package:modares/core/network/api/dio_consumer.dart';
import 'package:modares/core/network/api/end_points.dart';
import 'package:modares/core/network/services/chat.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(baseUrl: EndPoints.baseUrl, receiveDataWhenStatusError: true),
    );

    dio.interceptors.add(ApiIntercepotrs(dio: dio));

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );

    return dio;
  });

  /// ApiConsumer
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(),
  );

  getIt.registerLazySingleton<TeacherSearchBloc>(
    () => TeacherSearchBloc(),
  );

  getIt.registerLazySingleton<ProfileBloc>(
    () => ProfileBloc(),
  );

  getIt.registerLazySingleton<ChatService>(
    () => ChatService(),
  );

   getIt.registerLazySingleton<ChatBloc>(
    () => ChatBloc(),
  );

  getIt.registerLazySingleton<TeacherBloc>(
    () => TeacherBloc(),
  );

  getIt.registerLazySingleton<UnitBloc>(
    () => UnitBloc(),
  );
}

import 'package:modares/model/user_model.dart';

class AuthModel {
  final bool success;
  final String message;
  final String token;
  final UserModel user;

  AuthModel({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['user']),
    );
  }
}
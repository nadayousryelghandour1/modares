
import 'package:modares/core/network/api/end_points.dart';

class ErrorModel {
  final int? status;
  final String? message;
  final dynamic errors;

  ErrorModel({required this.status, required this.message, required this.errors});
  factory ErrorModel.fromJson(Map<String,dynamic> jsonData){
    return ErrorModel(
      status: jsonData[ApiKey.status], 
      message: jsonData[ApiKey.message],
      errors: jsonData['errors'],
      );
  }
} 



import 'package:modares/model/grade_model.dart';
import 'package:modares/model/quiz_result_model.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final int role;
  final String key;
  final int gradeId;
  final GradeModel grade;
  final String? image;
  final String? bgImg;
  final String? phoneNumber;
  final String? createdAt;
  final int? major;
  final int? subjectsLanguage;
  final int? government;
  final String? state;
  final List<QuizResultModel>? quizResults;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.key,
    required this.gradeId,
    required this.grade,
    this.image,
    this.bgImg,
    this.phoneNumber,
    this.createdAt,

    this.major,
    this.subjectsLanguage,
    this.government,
    this.state,
    this.quizResults
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final student = json['student'];

    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 0,

      key: student != null ? student['key'] : json['key'],
      gradeId: student != null ? student['gradeId'] : json['gradeId'],
      grade: GradeModel.fromJson(
        student != null ? student['grade'] : json['grade'],
      ),

      image: json['image'],
      bgImg: json['bgImg'],
      phoneNumber: json['phoneNumber'],
      createdAt: json['createdAt'],

      // ✅ الجديد
      major: json['major'] ?? 0,
      subjectsLanguage: json['subjectsLanguage'] ?? 0,
      government: json['government'] ?? 0,
      state: json['state'],
      quizResults: json['quizResults'] != null
    ? (json['quizResults'] as List)
        .map((e) => QuizResultModel.fromJson(e as Map<String, dynamic>))
        .toList()
    : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role": role,
      "image": image,
      "bgImg": bgImg,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,

      // ✅ الجديد
      "major": major,
      "subjectsLanguage": subjectsLanguage,
      "government": government,
      "state": state,

      "student": {"key": key, "gradeId": gradeId, "grade": grade.toJson()},
    };
  }
}

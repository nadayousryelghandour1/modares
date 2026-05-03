class TeacherModel {
  final int id;
  final String name;
  final String? image;
  final String? bgImg;
  final String? overview;
  final String? description;
  final double rating;
  final int teachingMethod;
  final int? government;
  final String? phoneNumber;
  final String? email;
  final String? introVideoUrl;
  final double? hoursOfTeaching;
  final int? studentsCount;
  final List<dynamic>? subjects;
  final List<int>? subjectsIds;
  final Map<String, List<String>>? availability;

  TeacherModel({
    required this.id,
    required this.name,
    this.image,
    this.bgImg,
    this.overview,
    this.description,
    required this.rating,
    required this.teachingMethod,
    this.government,
    this.phoneNumber,
    this.email,
    this.introVideoUrl,
    this.hoursOfTeaching,
    this.studentsCount,
    this.subjects,
    this.subjectsIds,
    this.availability,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'],
      bgImg: json['bgImg'],
      overview: json['overview'],
      description: json['description'],
      rating: (json['rating'] ?? 0).toDouble(),
      teachingMethod: json['teachingMethod'] is int
          ? json['teachingMethod']
          : _parseTeachingMethod(json['teachingMethod']),
      government: json['government'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      introVideoUrl: json['introVideoUrl'],
      hoursOfTeaching: json['hoursOfTeaching'] != null
          ? (json['hoursOfTeaching']).toDouble()
          : null,
      studentsCount: json['studentsCount'],
      subjectsIds: (json['subjectsIds'] as List?)
          ?.map((e) => int.tryParse(e.toString()) ?? 0)
          .toList(),
      subjects: json['subjects'],
      availability: (json['availability'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          List<String>.from(value),
        ),
      ),
    );
  }
}
int _parseTeachingMethod(dynamic method) {
  switch (method.toString().toLowerCase()) {
    case "online":
      return 1;
    case "offline":
      return 2;
    default:
      return 0;
  }
}
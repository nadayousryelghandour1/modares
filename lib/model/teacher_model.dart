class TeacherModel {
  final int id;
  final String name;
  final String? image;
  final double rating;
  final int teachingMethod;
  final String? government;
  final List<String> subjects;

  TeacherModel({
    required this.id,
    required this.name,
    this.image,
    required this.rating,
    required this.teachingMethod,
    this.government,
    required this.subjects,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      image: json['image'],
      rating: (json['rating'] ?? 0).toDouble(),
      teachingMethod: json['teachingMethod'] ?? 0,
      government: json['government'],
      subjects: (json['subjects'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
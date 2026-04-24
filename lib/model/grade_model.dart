class GradeModel {
  final int id;
  final String name;
  final String englishName;
  final int stage;

  GradeModel({
    required this.id,
    required this.name,
    required this.englishName,
    required this.stage,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      englishName: json['englishName'] ?? '',
      stage: json['stage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
  return {
    "id": id,
    "name": name,
    "englishName": englishName,
    "stage": stage,
  };
}
}
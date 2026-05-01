class UnitModel {
  final int id;
  final String name;
  final int gradeId;
  final int subjectId;
  final String description;
  final String? image;
  final int lecturesNumber;
  final int? term;

  UnitModel({
    required this.id,
    required this.name,
    required this.gradeId,
    required this.subjectId,
    required this.description,
    this.image,
    required this.lecturesNumber,
    this.term,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json["id"],
      name: json["name"],
      gradeId: json["gradeId"],
      subjectId: json["subjectId"],
      description: json["description"],
      image: json["image"],
      lecturesNumber: json["lecturesNumber"],
      term: json["term"],
    );
  }
}
class UnitsResponseModel {
  final Map<int, Map<int, List<UnitModel>>> units;

  UnitsResponseModel({
    required this.units,
  });

  factory UnitsResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<int, Map<int, List<UnitModel>>> parsedUnits = {};

    final unitsJson = json["units"] as Map<String, dynamic>;

    unitsJson.forEach((gradeId, subjects) {
      parsedUnits[int.parse(gradeId)] = {};

      (subjects as Map<String, dynamic>).forEach((subjectId, unitsList) {
        parsedUnits[int.parse(gradeId)]![int.parse(subjectId)] =
            (unitsList as List)
                .map((e) => UnitModel.fromJson(e))
                .toList();
      });
    });

    return UnitsResponseModel(
      units: parsedUnits,
    );
  }
}
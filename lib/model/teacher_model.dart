class TeacherModel {
  final int id;
  final String name;
  final String title;
  final String image;
  final double rate;
  final List<String> teachingMethods;
  final String location;
  final int price;
  final List<int> stage;
  final Map<String, String> grades;

  TeacherModel({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
    required this.rate,
    required this.teachingMethods,
    required this.location,
    required this.price,
    required this.stage,
    required this.grades,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      image: json['image'],
      rate: (json['rate'] as num).toDouble(),
      teachingMethods: List<String>.from(json['teachingMethods']),
      location: json['location'],
      price: json['price'],
      stage: List<int>.from(json['stage']),
      grades: Map<String, String>.from(json['grades']),
    );
  }


}
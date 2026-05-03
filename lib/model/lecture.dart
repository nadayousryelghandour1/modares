class LectureModel {
  final int id;
  final String name;
  final String description;
  final String videoUrl;
  final List<String> documentsUrls;
  final int hoursDuration;
  final int minutesDuration;
  final double price;
  final bool isPurchased;
  final int watchingStatus;

  LectureModel({
    required this.id,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.documentsUrls,
    required this.hoursDuration,
    required this.minutesDuration,
    required this.price,
    required this.isPurchased,
    required this.watchingStatus,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      documentsUrls: (json['documentsUrls'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      hoursDuration: json['hoursDuration'] ?? 0,
      minutesDuration: json['minutesDuration'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      isPurchased: json['isPurchased'] ?? false,
      watchingStatus: json['watchingStatus'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'videoUrl': videoUrl,
      'documentsUrls': documentsUrls,
      'hoursDuration': hoursDuration,
      'minutesDuration': minutesDuration,
      'price': price,
      'isPurchased': isPurchased,
      'watchingStatus': watchingStatus,
    };
  }
}
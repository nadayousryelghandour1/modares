class MessageModel {
  final String senderId;
  final String senderName;
  final String text;
  final int createdAtMs;

  MessageModel({
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.createdAtMs,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      text: json['text'] ?? '',
      createdAtMs: json['createdAtMs'] ?? 0,
    );
  }
}

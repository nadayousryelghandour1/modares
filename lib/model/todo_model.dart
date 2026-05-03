// todo_model.dart
class TodoModel {
  final String id;
  final String title;
  final bool isDone;
  final String deviceId;
  final DateTime createdAt;
  final DateTime? dueDate;    
  final Duration? timeout;     

  TodoModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.deviceId,
    required this.createdAt,
    this.dueDate,
    this.timeout,
  });

  bool get isOverdue =>
      dueDate != null && !isDone && DateTime.now().isAfter(dueDate!);

  bool get isNearDue =>
      dueDate != null &&
      timeout != null &&
      !isDone &&
      DateTime.now().isAfter(dueDate!.subtract(timeout!));

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'isDone': isDone,
    'deviceId': deviceId,
    'createdAt': createdAt.toIso8601String(),
    'dueDate': dueDate?.toIso8601String(),
    'timeoutMinutes': timeout?.inMinutes, 
  };

  factory TodoModel.fromMap(Map<String, dynamic> map) => TodoModel(
    id: map['id'],
    title: map['title'],
    isDone: map['isDone'] ?? false,
    deviceId: map['deviceId'] ?? '',
    createdAt: DateTime.parse(map['createdAt']),
    dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
    timeout: map['timeoutMinutes'] != null
        ? Duration(minutes: map['timeoutMinutes'])
        : null,
  );
}
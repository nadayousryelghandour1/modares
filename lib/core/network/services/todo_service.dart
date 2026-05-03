// todo_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modares/core/network/services/device_id_service.dart';
import 'package:modares/core/network/services/notification_service.dart';
import 'package:modares/core/resources/cache_helper.dart';
import 'package:modares/model/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoService {
  final _db = FirebaseFirestore.instance;
  final _collection = 'todos';
  String? _userId;

  TodoService() {
    _initUserId();
  }

  Future<void> _initUserId() async {
    final user = await CacheHelper.getUser();
    _userId = user.id.toString();
  }

  Future<String> _getuserId() async {
    if (_userId != null) return _userId!;
    final user = await CacheHelper.getUser();
    _userId = user.id.toString();
    return _userId!;
  }

  // ── Add ───────────────────────────────────────────────────────────────────
  Future<void> addTodo(
    String title, {
    DateTime? dueDate,
    Duration? timeout,
  }) async {
    final userId = await _getuserId();
    final deviceId = await getDeviceId();
    final id = const Uuid().v4();

    final todo = TodoModel(
      id: id,
      title: title,
      isDone: false,
      deviceId: deviceId,
      createdAt: DateTime.now(),
      dueDate: dueDate,
      timeout: timeout,
    );

    await _db
        .collection('users')
        .doc(userId)
        .collection(_collection)
        .doc(id)
        .set(todo.toMap());

    if (dueDate != null) {
      await NotificationService.scheduleTodoNotification(
        todoId: id,
        title: title,
        dueDate: dueDate,
        timeout: timeout,
      );
    }
  }

  // ── Get All ───────────────────────────────────────────────────────────────
  Stream<List<TodoModel>> getTodos() async* {
    final userId = await _getuserId();
    yield* _db
        .collection('users')
        .doc(userId)
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => TodoModel.fromMap(doc.data())).toList());
  }

  // ── Toggle Done ───────────────────────────────────────────────────────────
  Future<void> toggleTodo(String todoId, bool current) async {
    final userId = await _getuserId();
    await _db
        .collection('users')
        .doc(userId)
        .collection(_collection)
        .doc(todoId)
        .update({'isDone': !current});

    if (!current) {
      await NotificationService.cancelTodoNotification(todoId);
    }
  }

  // ── Delete ────────────────────────────────────────────────────────────────
  Future<void> deleteTodo(String todoId) async {
    final userId = await _getuserId();
    await _db
        .collection('users')
        .doc(userId)
        .collection(_collection)
        .doc(todoId)
        .delete();

    await NotificationService.cancelTodoNotification(todoId);
  }
}
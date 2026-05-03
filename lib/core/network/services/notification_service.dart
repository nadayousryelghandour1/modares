// notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  // ── Init ──────────────────────────────────────────────────────────────────
  static Future<void> init() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    final settings = InitializationSettings(android: android, iOS: ios);

    await _plugin.initialize(settings: settings);
  }

  // ── Android 13+ Permission ────────────────────────────────────────────────
  static Future<void> requestAndroidPermission() async {
    await Permission.notification.request();
  }

  // ── Schedule ──────────────────────────────────────────────────────────────
  static Future<void> scheduleTodoNotification({
    required String todoId,
    required String title,
    required DateTime dueDate,
    Duration? timeout,
  }) async {
    await _scheduleOne(
      id: todoId.hashCode,
      title: '⏰ Task Overdue!',
      body: '"$title" المهمة لسه مخلصتش!',
      scheduledDate: dueDate,
    );

    if (timeout != null) {
      final warningTime = dueDate.subtract(timeout);
      if (warningTime.isAfter(DateTime.now())) {
        await _scheduleOne(
          id: todoId.hashCode + 1,
          title: '⚠️ Task Due Soon',
          body: '"$title" هتتأخر خلال ${_formatDuration(timeout)}',
          scheduledDate: warningTime,
        );
      }
    }
  }

  static Future<void> _scheduleOne({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
  }) async {
    if (scheduledDate.isBefore(DateTime.now())) return;

    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'todo_channel',
        'Todo Reminders',
        channelDescription: 'تنبيهات المهام',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  // ── Cancel ────────────────────────────────────────────────────────────────
  static Future<void> cancelTodoNotification(String todoId) async {
    await _plugin.cancel(id: todoId.hashCode);
    await _plugin.cancel(id: todoId.hashCode + 1);
  }

  // ── Helper ────────────────────────────────────────────────────────────────
  static String _formatDuration(Duration d) {
    if (d.inDays > 0) return '${d.inDays} يوم';
    if (d.inHours > 0) return '${d.inHours} ساعة';
    return '${d.inMinutes} دقيقة';
  }
}

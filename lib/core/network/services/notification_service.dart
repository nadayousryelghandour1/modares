// // notification_service.dart
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   static final _plugin = FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     tz.initializeTimeZones();

//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const ios = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     await _plugin.initialize(
//       const InitializationSettings(android: android, iOS: ios),
//     );

//     // اطلب permission على Android 13+
//     await _plugin
//         .resolvePlatformSpecificImplementation
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//   }

//   // ── Schedule notification عند الـ due date بالظبط ──────────────
//   static Future<void> scheduleTodoNotification({
//     required String todoId,
//     required String title,
//     required DateTime dueDate,
//     Duration? timeout,         // لو موجود ينبه قبله كمان
//   }) async {
//     // نبيه لما يعدي الـ due date
//     await _scheduleOne(
//       id: todoId.hashCode,
//       title: '⏰ Task Overdue!',
//       body: '"$title" المهمة لسه مخلصتش!',
//       scheduledDate: dueDate,
//     );

//     // لو فيه timeout — ينبه قبل الـ due date بالـ timeout
//     if (timeout != null) {
//       final warningTime = dueDate.subtract(timeout);
//       if (warningTime.isAfter(DateTime.now())) {
//         await _scheduleOne(
//           id: todoId.hashCode + 1,
//           title: '⚠️ Task Due Soon',
//           body: '"$title" هتتأخر خلال ${_formatDuration(timeout)}',
//           scheduledDate: warningTime,
//         );
//       }
//     }
//   }

//   static Future<void> _scheduleOne({
//     required int id,
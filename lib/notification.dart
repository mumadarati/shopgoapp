// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Notifcation {
//   int notificationsCount = 0;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   AndroidNotificationChannel channel = const AndroidNotificationChannel(
//       'high_importance_channel', 'High Importance Notifications',
//       description: 'This channel is used for important notifications.',
//       importance: Importance.max,
//       enableVibration: true,
//       playSound: true);

//   Notifcation() {
//     getNotifcation();
//   }
//   getNotifcation() async {
//     FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {});
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       badge: true,
//       provisional: true,
//       criticalAlert: true,
//       sound: true,
//     );
//   }
// }

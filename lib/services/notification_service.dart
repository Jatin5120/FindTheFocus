import 'package:find_the_focus/constants/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  getInstance() => NotificationService._();

  NotificationService._();

  factory NotificationService() {
    return NotificationService._();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    final AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('notification_icon');

    final IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) async {
    print("Notification opened");
  }

  Future<void> showNotification() async {
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      kNotificationChannelID,
      kNotificationChannelName,
      kNotificationDescription,
      importance: Importance.max,
      priority: Priority.max,
    );

    final IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(
      presentAlert: false,
      presentBadge: false,
      presentSound: false,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      "Timer is running",
      "Return to the work in 15 seconds or you'll your progress",
      notificationDetails,
    );
  }
}

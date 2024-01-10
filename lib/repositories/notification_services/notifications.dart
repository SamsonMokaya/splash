import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      preferences.setString('fcmToken', fCMToken);
    }
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleForegroundMessage);
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    // Display a notification for background message
    await _showNotification(
        message.notification?.title ?? 'Background Notification',
        message.notification?.body ?? '');
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    // Display a notification for foreground message
    await _showNotification(
        message.notification?.title ?? 'Foreground Notification',
        message.notification?.body ?? '');
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your_channel_id', 'your_channel_name',
            importance: Importance.max, priority: Priority.high);
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics);
  }
}

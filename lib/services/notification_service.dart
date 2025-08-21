// lib/notification_service.dart
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Used for important notifications.',
    importance: Importance.high,
  );

  static bool _initialized = false;

  /// Call once at app startup (main) and also from the background handler.
  static Future<void> ensureInitialized() async {
    if (_initialized) return;

    // Android init (use a valid monochrome small icon from your project)
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS init
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: darwinInit),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final payload = response.payload;
        if (payload != null) {
          try {
            final data = jsonDecode(payload) as Map<String, dynamic>;
            _onNotificationTap(data);
          } catch (e) {
            log('onSelect parse error: $e');
          }
        }
      },
    );

    // Create Android channel
    await _plugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    _initialized = true;
  }

  /// Convert a RemoteMessage into a local notification that will *always* show,
  /// even when the app is in foreground (which FCM does not do automatically).
  static Future<void> showFromRemoteMessage(RemoteMessage m) async {
    final title = m.notification?.title ?? m.data['title'];
    final body = m.notification?.body ?? m.data['body'];

    // Pack all data so tapping the notification can route inside the app
    final payload = jsonEncode(m.data);

    final details = const NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );

    // Use a stable-ish id so duplicates are less likely; fallback to hashCode
    final id = m.messageId?.hashCode ?? m.data.hashCode;

    await _plugin.show(id, title, body, details, payload: payload);
  }

  static const String _channelId = 'high_importance_channel';
  static const String _channelName = 'High Importance Notifications';
  static const String _channelDescription = 'Used for important notifications.';

  /// Handle navigation/routing after the user taps a local notification.
  /// Adjust this to your app’s routing scheme.
  static void _onNotificationTap(Map<String, dynamic> data) {
    // For now we only log. You can route using a global navigatorKey
    // from main.dart if you want to push a screen here.
    log('Tapped notification with data: $data');
  }
}

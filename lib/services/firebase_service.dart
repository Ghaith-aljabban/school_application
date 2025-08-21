// lib/services/firebase_service.dart
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:school_application/services/notification_service.dart';

// ===== Background handler MUST be top-level and annotated =====
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.ensureInitialized();
  await NotificationService.showFromRemoteMessage(message);
  log('BG message: ${message.messageId}, data=${message.data}');
}

class FirebaseService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
    
    // Register background handler BEFORE using messaging
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // Local notifications / channel
    await NotificationService.ensureInitialized();

    // Ask runtime permissions (Android 13+, iOS)
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('Notification permission: ${settings.authorizationStatus}');

    // iOS: show alerts while app is in foreground
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Log token (send to backend if needed)
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log('FCM token: $fcmToken');

    // Also log on token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (t) => log('FCM REFRESH: $t'),
    );
  }

  static void setupMessageHandlers(Function(Map<String, dynamic>) onMessageOpenedApp) {
    // ===== Step 5: Add debug listeners RIGHT AFTER runApp() =====
    FirebaseMessaging.onMessage.listen((m) {
      log('onMessage: ${m.messageId}, data=${m.data}, notif=${m.notification?.title}');
      print(m);
      // Always show a local notification in foreground
      NotificationService.showFromRemoteMessage(m);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((m) {
      log('onMessageOpenedApp: ${m.messageId}, data=${m.data}');
      // If you want to route based on data, do it safely via navigatorKey:
      onMessageOpenedApp(m.data);
    });

    FirebaseMessaging.instance.getInitialMessage().then((m) {
      if (m != null) {
        log('getInitialMessage: ${m.messageId}, data=${m.data}');
        onMessageOpenedApp(m.data);
      }
    });
  }
}

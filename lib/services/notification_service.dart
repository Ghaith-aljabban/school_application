// notification_service.dart
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  // Initialize notification services
  Future<void> initialize() async {
    await _setupLocalNotifications();
    await _setupFCM();
  }

  // Set up local notifications
  Future<void> _setupLocalNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
  }

  // Set up Firebase Cloud Messaging
  Future<void> _setupFCM() async {
    // Request permissions
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      print("FCM Token: $fcmToken");
      await _registerFCMToken(fcmToken);
    }

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      print("New FCM Token: $newToken");
      await _registerFCMToken(newToken);
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleForegroundMessage(message);
    });

    // Handle background/terminated messages
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleBackgroundMessage(message);
      }
    });
  }

  // Register FCM token with backend
  Future<void> _registerFCMToken(String token) async {
    // Your implementation from _registerFCMToken
    // This should be moved to an API service class ideally
  }

  // Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    // Show local notification
    _showLocalNotification(message);

    // You can also add other logic like updating UI, etc.
  }

  // Handle background/terminated messages
  void _handleBackgroundMessage(RemoteMessage message) {
    // Handle notification tap when app is in background/terminated
    _onNotificationTap(NotificationResponse(
      notificationResponseType: NotificationResponseType.selectedNotification,
      payload: jsonEncode(message.data),
    ));
  }

  // Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // Unique ID
      message.notification?.title,
      message.notification?.body,
      details,
      payload: jsonEncode(message.data),
    );
  }

  // Handle notification tap
  void _onNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      // Navigate based on notification data
      _navigateBasedOnNotification(data);
    }
  }

  // Navigate based on notification data
  void _navigateBasedOnNotification(Map<String, dynamic> data) {
    // Implement your navigation logic here
    // This could use a Navigator key or event system to communicate with UI
    print('Notification data: $data');

    // Example:
    // if (data['type'] == 'message') {
    //   Navigator.of(navigatorKey.currentContext!).push(
    //     MaterialPageRoute(builder: (context) => MessageScreen(data['id'])),
    //   );
    // }
  }
}
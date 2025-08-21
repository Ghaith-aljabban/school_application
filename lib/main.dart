// lib/main.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


// ===== App-specific imports (keep as in your project) =====
import 'package:school_application/Pages/login/login_screen.dart';
import 'package:school_application/Pages/welcome/welcome_screen.dart';
import 'package:school_application/services/notification_service.dart';
import 'package:school_application/storage/secure_storage_service.dart';
import 'Models/subjects_model.dart';
import 'layout/main_menu.dart';

// ===== Global navigator key for safe navigation from anywhere (e.g., FCM) =====
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ===== Keep your globals if other files rely on them =====
late String token;
late int studentID;
List<SubjectsModel> studentSubjects = [];

// ===== Background handler MUST be top-level and annotated =====
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.ensureInitialized();
  await NotificationService.showFromRemoteMessage(message);
  log('BG message: ${message.messageId}, data=${message.data}');
}

Future<void> _initFirebaseAndMessaging() async {
   {
    await Firebase.initializeApp();
  }

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initFirebaseAndMessaging();
  runApp(const MyApp());

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
    _routeFromData(m.data);
  });

  FirebaseMessaging.instance.getInitialMessage().then((m) {
    if (m != null) {
      log('getInitialMessage: ${m.messageId}, data=${m.data}');
      _routeFromData(m.data);
    }
  });
}

// ===== Minimal app wrapper (keeps your existing screens) =====
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Application',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: const _BootstrapScreen(),
    );
  }
}

/// A tiny splash/bootstrap that defers navigation to avoid Navigator lock.
class _BootstrapScreen extends StatefulWidget {
  const _BootstrapScreen({super.key});
  @override
  State<_BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<_BootstrapScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    // Defer navigation until after first frame to avoid !_debugLocked
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _boot();
    });
  }

  Future<void> _boot() async {
    if (!mounted || _navigated) return;
    _navigated = true;

    // TODO: put your login/session bootstrap here if needed
    // Example:
    // final savedToken = await SecureStorageService.readToken();

    // Navigate to your start screen safely
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

// ===== Simple routing helper using the global navigatorKey =====
bool _routing = false;
void _routeFromData(Map<String, dynamic> data) {
  final nav = navigatorKey.currentState;
  if (nav == null || _routing || data.isEmpty) return;
  _routing = true;
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    try {
      // TODO: replace with your target screen & data mapping
      // Example:
      // await nav.push(MaterialPageRoute(builder: (_) => MessageScreen(id: data['id'])));
      log('Routing from data: $data');
    } finally {
      _routing = false;
    }
  });
}

// ===== Keep your helper if other files import it =====
String consUrl(String relativePath) {
  const baseUrl = 'http://10.128.216.103:3000/api/';
  return baseUrl + relativePath;
}

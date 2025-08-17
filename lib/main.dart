import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:school_application/Pages/login/login_screen.dart';
import 'package:school_application/Pages/welcome/welcome_screen.dart';
import 'package:school_application/storage/secure_storage_service.dart';
import 'Models/subjects_model.dart';
import 'layout/main_menu.dart';

late String token;
late int studentID;
List<SubjectsModel> studentSubjects = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      title: 'Flutter Demo',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _checkAppState();
    _setupFCM();
  }

  Future<void> _setupFCM() async {
    // Request permissions (iOS/macOS)
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Get FCM token
    String? fcmToken = await _firebaseMessaging.getToken();
    if (fcmToken != null) {
      print("FCM Token: $fcmToken");
      await _registerFCMToken(fcmToken); // Send to backend
    }

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      print("New FCM Token: $newToken");
      await _registerFCMToken(newToken);
    });
  }

  Future<void> _registerFCMToken(String token) async {
    final authToken = await SecureStorageService.getToken(); // Your existing method
    String url = consUrl('fcm/register');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken', // Add auth token
        },
        body: jsonEncode({
          'token': token,
          'device_type': 'mobile', // Adjust as needed
        }),
      );

      if (response.statusCode == 200) {
        print("FCM token registered successfully");
      } else {
        print("Failed to register FCM token: ${response.body}");
      }
    } catch (e) {
      print("Error registering FCM token: $e");
    }
  }

  Future<void> _checkAppState() async {
    bool isFirstTime = await SecureStorageService.isFirstTime();
    if (isFirstTime) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } else {
      bool isLoggedIn = await SecureStorageService.isLoggedIn();
      if (isLoggedIn) {
        final savedToken = await SecureStorageService.getToken();
        final savedStudentId = await SecureStorageService.getStudentId();
        if (savedToken != null && savedStudentId != null) {
          token = savedToken;
          studentID = savedStudentId;
          studentSubjects = await SecureStorageService.getSubjects();
        }
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainMenu()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

String consUrl(String relativePath) {
  const baseUrl = 'http://10.176.193.103:3000/api/';
  return baseUrl + relativePath;
}
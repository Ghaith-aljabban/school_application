import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:school_application/Pages/login/login_screen.dart';
import 'package:school_application/Pages/welcome/welcome_screen.dart';
import 'package:school_application/services/notification_service.dart';
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
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Initialize notification service
    // await _notificationService.initialize();

    // Check app state and navigate
    _checkAppState();
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
  const baseUrl = 'http://192.168.137.45:3000/api/';
  return baseUrl + relativePath;
}
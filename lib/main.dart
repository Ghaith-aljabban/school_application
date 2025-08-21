// lib/main.dart
import 'package:flutter/material.dart';
import 'package:school_application/services/firebase_service.dart';
import 'package:school_application/services/navigation_service.dart';
import 'package:school_application/Models/subjects_model.dart';

// ===== Global variables for easy access throughout the app =====
String token = '';
int studentID = 0;
List<SubjectsModel> studentSubjects = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  runApp(const MyApp());

  // Setup Firebase message handlers
  FirebaseService.setupMessageHandlers(NavigationService.routeFromData);
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
      home: const BootstrapScreen(),
    );
  }
}

 String consUrl(String relativePath) {
const baseUrl = 'http://10.65.11.39:3000/api/';
return baseUrl + relativePath;
}
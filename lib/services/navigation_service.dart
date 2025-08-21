// lib/services/navigation_service.dart
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:school_application/Pages/login/login_screen.dart';
import 'package:school_application/Pages/welcome/welcome_screen.dart';
import 'package:school_application/storage/secure_storage_service.dart';
import 'package:school_application/Models/subjects_model.dart';
import 'package:school_application/layout/main_menu.dart';

import '../main.dart';

// ===== Global navigator key for safe navigation from anywhere (e.g., FCM) =====
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationService {
  static bool _routing = false;

  // ===== Simple routing helper using the global navigatorKey =====
  static void routeFromData(Map<String, dynamic> data) {
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

}

/// A tiny splash/bootstrap that defers navigation to avoid Navigator lock.
class BootstrapScreen extends StatefulWidget {
  const BootstrapScreen({super.key});
  @override
  State<BootstrapScreen> createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
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

    // Check if it's the first time
    final isFirstTime = await SecureStorageService.isFirstTime();

    if (isFirstTime) {
      // Show welcome screen for first-time users
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
      return;
    }

    // Check if user has valid token, student ID, and subjects
    final savedToken = await SecureStorageService.getToken();
    final savedStudentId = await SecureStorageService.getStudentId();
    final savedSubjects = await SecureStorageService.getSubjects();

    if (savedToken != null && savedStudentId != null && savedSubjects.isNotEmpty) {
      // Set global variables
      token = savedToken;
      studentID = savedStudentId;
      studentSubjects = savedSubjects;

      // User is logged in and has subjects - go to main menu
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainMenu()),
      );
    } else {
      // User needs to log in - show login screen
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

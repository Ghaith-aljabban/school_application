import 'package:flutter/material.dart';
import 'package:school_application/Pages/login/login_screen.dart';
import 'package:school_application/Pages/welcome/welcome_screen.dart';
import 'package:school_application/storage/secure_storage_service.dart';
import 'Models/subjects_model.dart';
import 'layout/main_menu.dart';

late String token;
late int studentID;
List<SubjectsModel> studentSubjects=[];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      title: 'Flutter Demo',
      home: SplashScreen(), // Changed to SplashScreen for routing logic
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAppState();
  }

  Future<void> _checkAppState() async {
    // Check if this is the first time opening the app
    bool isFirstTime = await SecureStorageService.isFirstTime();

    if (isFirstTime) {
      // First time opening the app - go to welcome screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } else {
      // Not first time - check if user is logged in
      bool isLoggedIn = await SecureStorageService.isLoggedIn();

      if (isLoggedIn) {
        // User is logged in - load global variables and go to main menu
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
        // User is not logged in - go to login screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Loading indicator while checking app state
      ),
    );
  }
}

String consUrl(String relativePath) {
  const baseUrl = 'http://192.168.137.185:3000/api/';
  return baseUrl + relativePath;
}
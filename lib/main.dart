import 'package:flutter/material.dart';
import 'package:school_application/Pages/login/login_screen.dart';

import 'layout/main_menu.dart';
late String token;
late int studentID;
void main() {
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
          backgroundColor: Colors.white, // Optional: text/icon color
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white, // Set your desired color here
      ),
      title: 'Flutter Demo',
      home: LoginScreen(),
    );
  }
}
String consUrl(String relativePath) {
  const baseUrl = 'http://192.168.1.106:3000/api/';
  return baseUrl + relativePath;
}
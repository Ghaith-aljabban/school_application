import 'package:flutter/material.dart';

import 'layout/main_menu.dart';
import 'modules/welcome/welcome_screen.dart';

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
          backgroundColor: Colors.white     // Optional: text/icon color
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white, // Set your desired color here
      ),
      title: 'Flutter Demo',
      home: MainMenu(),
    );
  }
}

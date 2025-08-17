import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_application/Pages/main/account_screen.dart';
import 'package:school_application/Pages/main/home_Screen.dart';
import 'package:school_application/Pages/main/preeexam_screen.dart';
import 'package:school_application/Pages/main/preequiz_screen.dart';
import 'package:school_application/shared/network/styles/colors.dart';

int _selectedIndex = 0;
List<Widget> Screens = [
  HomeScreen(),
  PreeexamScreen(),
  PreequizScreen(),
  AccountScreen(),
];

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor:
            Colors.white, // Background color of navigation bar
        systemNavigationBarIconBrightness:
            Brightness.dark, // Icon color: dark icons on light background
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Screens[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, -3),
              ),
            ],
          ),
          child: Container(
            height: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: _selectedIndex == 0 ? myGreen : Colors.black,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.description,
                      color: _selectedIndex == 1 ? myGreen : Colors.black,
                    ),
                    label: 'Preexam',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.quiz,
                      color: _selectedIndex == 2 ? myGreen : Colors.black,
                    ),
                    label: 'Quiz',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle,
                      color: _selectedIndex == 3 ? myGreen : Colors.black,
                    ),
                    label: 'Account',
                  ),
                ],
                currentIndex: _selectedIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: myGreen,
                unselectedItemColor: Colors.black,
                onTap: _onItemTapped,
                elevation: 0, // This removes the default shadow
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

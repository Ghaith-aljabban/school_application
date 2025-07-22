import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_application/Pages/welcome/welcome_screen3.dart';

import '../../shared/components/components.dart';
import '../../shared/network/styles/styles.dart';

class WelcomeScreen2 extends StatelessWidget {
  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 144),
          Center(
            child: SvgPicture.asset(
              'assets/SVGs/welcome SVGs/welcome 2.svg',
              height: 255,
              width: 323,
            ),
          ),
          SizedBox(height: 70),
          Text(
            "Stay Organized\nand Informed",
            style: headerTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Access schedules, quizzes,\nand previous exam questions\nall in one place",
            style: paragraphTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60),
          defaultButton(
            width: 351,
            function: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const WelcomeScreen3()),
                (Route<dynamic> route) => false,
              );
            },
            text: 'Next',
          ),
        ],
      ),
    );
  }
}

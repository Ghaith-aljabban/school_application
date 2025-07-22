import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_application/Pages/login/login_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/network/styles/styles.dart';

class WelcomeScreen3 extends StatelessWidget {
  const WelcomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: SvgPicture.asset(
              'assets/SVGs/welcome SVGs/welcome 3.svg',
              height: 344,
              width: 266,
            ),
          ),
          SizedBox(height: 70),
          Text(
            "Ready to Dive In?",
            style: headerTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Let's login to your school account\nand customize your learning experience.",
            style: paragraphTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 65),
          defaultButton(
            width: 351,
            function: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
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

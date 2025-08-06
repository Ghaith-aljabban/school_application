import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_application/Pages/welcome/welcome_screen2.dart';

import '../../services/secure_storage_service.dart';
import '../../shared/components/components.dart';
import '../../shared/network/styles/styles.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Center(
            child: SvgPicture.asset(
              'assets/SVGs/welcome SVGs/welcome 1.svg',
              height: 344,
              width: 266,
            ),
          ),
          SizedBox(height: 50),
          Text(
            "Welcome to\nSchoolApp",
            style: headerTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            "Your gateway to seamless\nlearning and collaboration",
            style: paragraphTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60),
          defaultButton(
            width: 351,
            function: () async {
              // Mark that it's no longer the first time
              await SecureStorageService.setNotFirstTime();

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const WelcomeScreen2()),
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
import 'package:flutter/material.dart';
import 'package:school_application/layout/main_menu.dart';
import 'package:school_application/shared/components/constants.dart';
import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';
import '../welcome/welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _studentNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double topSpacing = 200.0;
    const double formSpacing = 70.0;
    const double bottomSpacing = 109.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: topSpacing),
                    Text('Login', style: headerTextStyle),
                    const SizedBox(height: 8),
                    Text('to your student account', style: paragraphTextStyle),
                  ],
                ),
              ),
              const SizedBox(height: formSpacing),

              // Student Name Field
              TextFormField(
                controller: _studentNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: myLime,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  hintText: 'Student name',
                  hintStyle: hintTextStyle,
                ),
              ),
              const SizedBox(height: 25.0),

              buildPasswordTFF(
                obscurePassword: _obscurePassword,
                onVisibilityPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                controller: _passwordController,
              ),

              TextButton(
                onPressed: () {},
                child: Text('Forgot password?', style: hintTextStyle),
              ),
              const SizedBox(height: bottomSpacing),

              // Submit Button
              Center(
                child: defaultButton(
                  width: double.infinity,
                  height: 50,
                  function: () {
                    // You can now access:
                    // _studentNameController.text
                    // _passwordController.text
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  text: 'SUBMIT',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:school_application/Models/user_model.dart';
import 'package:school_application/layout/main_menu.dart';
import 'package:school_application/main.dart';
import 'package:school_application/services/auth_service.dart';
import 'package:school_application/shared/components/constants.dart';
import '../../Models/auth_model.dart';
import '../../Models/subjects_model.dart';
import '../../services/subject_service.dart';
import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';
import '../../storage/secure_storage_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Validation methods
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
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
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      validator: _validateEmail,
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
                        hintText: 'Email address',
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
                      validator: _validatePassword,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              // TextButton(
              //   onPressed: () {},
              //   child: Text('Forgot password?', style: hintTextStyle),
              // ),
              const SizedBox(height: bottomSpacing),

              Center(
                child: isLoading
                    ? CircularProgressIndicator(color: myGreen)
                    : defaultButton(
                  width: double.infinity,
                  height: 50,
                  // Inside the login button's function:
                  function: () async {
                    setState(() => isLoading = true);
                    try {
                      // Validate form first
                      if (!_formKey.currentState!.validate()) {
                        setState(() => isLoading = false);
                        return;
                      }

                      final loginResult = await AuthService.login(
                        authModel: AuthModel(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        ),
                      );

                      if (loginResult['success'] == true) {
                        // Check if user type is student
                        if (loginResult['role'] != 'student') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Access denied. Only students can login.')),
                          );
                          setState(() => isLoading = false);
                          return;
                        }

                        // Fetch and store subjects
                        List<SubjectsModel> subjects = await SubjectService.getSubjects();
                        await SecureStorageService.saveSubjects(subjects);
                        studentSubjects = subjects;
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const MainMenu()),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(loginResult['message'] ?? 'Check your credentials and try again')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    } finally {
                      setState(() => isLoading = false);
                    }
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
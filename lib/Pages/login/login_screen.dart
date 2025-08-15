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
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                      bool? isLogged = await AuthService.login(
                          authModel: AuthModel(
                              email: _studentNameController.text,
                              password: _passwordController.text
                          )
                      );

                      if (isLogged == true) {
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
                          SnackBar(content: Text('Check your credentials and try again')),
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
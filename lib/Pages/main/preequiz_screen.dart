import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_application/Models/subjects_model.dart';
import 'package:school_application/Pages/preequizzes/subject_semesters_screen_quiz.dart';
import 'package:school_application/shared/components/components.dart';

import '../../main.dart';
import '../preeexam/subject_semesters_screen.dart';
import 'notification_screen.dart';

class PreequizScreen extends StatelessWidget {
  const PreequizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(child: SvgPicture.asset('assets/SVGs/Logo/Logo.svg')),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
          ),
          SizedBox(width: 27),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: studentSubjects.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubjectSemestersScreenQuiz(name: studentSubjects[index].name, subjectId: studentSubjects[index].id,),
                      ),
                    );
                  },
                  child: SubjectWidget(
                    name: studentSubjects[index].name,
                    icon: SubjectsModel.getIconForSubject(studentSubjects[index].name),
                  ),
                );
              },
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}

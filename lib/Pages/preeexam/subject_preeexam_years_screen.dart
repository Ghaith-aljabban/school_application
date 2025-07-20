// ======== subject_preeexam_years_screen.dart ========
import 'package:flutter/material.dart';
import 'package:school_application/Models/previous_exams_model.dart';
import 'package:school_application/Pages/preeexam/subject_preeexam_avalibe_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class SubjectPreeexamScreen extends StatelessWidget {
  final String name;
  const SubjectPreeexamScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Preeexam", style: greenHTextStyle),
            ],
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: subjectPreviousExams.length * 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(name, style: greenHTextStyle),
            );
          }

          final adjustedIndex = index - 1;
          if (adjustedIndex.isEven) {
            final dataIndex = adjustedIndex ~/ 2;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExamListScreen(
                      subject: name,
                      year: subjectPreviousExams[dataIndex].date,
                      exams: subjectPreviousExams[dataIndex].exams,
                    ),
                  ),
                );
              },
              child: itemOfList(data: subjectPreviousExams[dataIndex].date),
            );
          } else {
            return Container(
              width: double.infinity,
              height: 1.0,
              color: myLightGray,
            );
          }
        },
      ),
    );
  }
}

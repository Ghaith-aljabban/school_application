import 'package:flutter/material.dart';
import 'package:school_application/Pages/schedule/daily_Schedule.dart';
import 'package:school_application/Pages/schedule/exam_Schedule.dart';
import 'package:school_application/Pages/schedule/quiz_Schedule.dart';

import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Schedule", style: greenHTextStyle),
            ],
          ), // ← Your custom icon
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(
          children: [
            GestureDetector(
              child: itemOfList(data: 'Daily Schedule '),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DailySchedule()),
                );
              },
            ),
            Container(width: double.infinity, height: 1.0, color: myLightGray),
            GestureDetector(
              child: itemOfList(data: 'Exams Schedule '),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => ExamSchedule()));
              },
            ),
            Container(width: double.infinity, height: 1.0, color: myLightGray),
            GestureDetector(
              child: itemOfList(data: 'Quiz Schedule'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (context) => QuizSchedule()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

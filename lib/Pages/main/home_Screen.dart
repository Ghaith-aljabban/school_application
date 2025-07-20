import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_application/Pages/main/notification_screen.dart';
import 'package:school_application/Pages/schedule/schedule_Screen.dart';
import 'package:school_application/Pages/student%20behavior/student_behavior_screen.dart';

import '../../shared/components/components.dart';
import '../report card/report_card_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: Container(
        padding: const EdgeInsets.all(21.0),
        child: ListView(
          children: [
            GestureDetector(
              child: defaultcard(
                description:
                    "View your class timetable and stay\non top of your school day",
                header: "Schedule",
                icon: Icon(Icons.calendar_month, size: 40, color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScheduleScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ReportCardHistoryScreen(),
                  ),
                );
              },
              child: defaultcard(
                description:
                    "Check you upcoming exams and\ntests and preform it online",
                header: "Report Card",
                icon: Icon(
                  FontAwesomeIcons.graduationCap,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const StudentBehaviorScreen(),
                  ),
                );
              },
              child: defaultcard(
                description:
                    "Monitor student behavior and \ninform parents of problems.",
                header: "Student Behavior",
                icon: Icon(
                  FontAwesomeIcons.chair,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

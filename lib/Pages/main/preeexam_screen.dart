import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:school_application/Models/subjects_model.dart';
import 'package:school_application/shared/components/components.dart';

import '../preeexam/subject_preeexam_years_screen.dart';
import 'notification_screen.dart';

class PreeexamScreen extends StatelessWidget {
  const PreeexamScreen({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,
          ),
          itemCount: mySubjects.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SubjectPreeexamScreen(name: mySubjects[index].name),
                  ),
                );
              },
              child: SubjectWidget(
                name: mySubjects[index].name,
                icon: mySubjects[index].icon,
              ),
            );
          },
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

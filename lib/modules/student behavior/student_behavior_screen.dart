import 'package:flutter/material.dart';
import 'package:school_application/models/student_behavior.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

class StudentBehaviorScreen extends StatelessWidget {
  const StudentBehaviorScreen({super.key});

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
              Text("Student Behavior", style: greenHTextStyle),
            ],
          ), // ← Your custom icon
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Center(
        child: ListView.builder(
          itemCount: studentBehaviors.length,
          itemBuilder: (context, index) {
            return notificationCard(
              title: studentBehaviors[index].title,
              description: studentBehaviors[index].description,
              color: studentBehaviors[index].color,
              icon: studentBehaviors[index].icon,
            );
          },
        ),
      ),
    );
  }
}

Widget notificationCard({
  required String title,
  required String description,
  required IconData icon,
  required Color color,
}) => Container(
  height: 90,
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        Container(
          width: 64,
          height: 74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: color,
          ),
          child: Icon(icon, size: 40, color: Colors.white),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 236, // <-- Add this
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: flexableTextStyle(
                    size: 15,
                    color: color,
                    isBold: true,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  description,
                  style: flexableTextStyle(
                    size: 12,
                    color: Colors.black,
                    isBold: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

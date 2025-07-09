import 'package:flutter/material.dart';
import 'package:school_application/models/exam_date_model.dart';

import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class ExamSchedule extends StatelessWidget {
  const ExamSchedule({super.key});

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
              Text("Exams Schedule", style: greenHTextStyle),
            ],
          ), // ← Your custom icon
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView.builder(
          itemCount: myExams.length+1,
          itemBuilder: (context, index) {
            if (index == 0) {
              // First item: display the name
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text("Upcoming Exams", style: flexableTextStyle(size: 30, color: Colors.black, isBold: true)),
              );
            }
            return Column(
              children: [
                ExamDateCard(
                  title: myExams[index-1].subject.name,
                  description:
                      myExams[index-1].date+" "+
                      myExams[index-1].timeStart + " - " + myExams[index-1].timeEnd,
                  icon: myExams[index-1].subject.icon,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

Widget ExamDateCard({
  required String title,
  required String description,
  required IconData icon,
}) => Container(
  height: 90,
  child: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: [
        Container(
          width: 64,
          height: 74,
          decoration: defaultBoxDecorated,
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
                    size: 20,
                    color: myGreen,
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

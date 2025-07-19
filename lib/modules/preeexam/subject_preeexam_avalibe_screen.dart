// ======== exam_list_screen.dart (new file) ========
import 'package:flutter/material.dart';
import 'package:school_application/models/previous_exams_model.dart';
import 'package:school_application/modules/preeexam/preform_preeexam_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class ExamListScreen extends StatelessWidget {
  final String subject;
  final String year;
  final List<Exam> exams;
  const ExamListScreen({
    super.key,
    required this.subject,
    required this.year,
    required this.exams,
  });

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
              Text("$subject Exams", style: greenHTextStyle),
            ],
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView.builder(
        itemCount: exams.length * 2 + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("$subject - $year", style: greenHTextStyle),
            );
          }

          final adjustedIndex = index - 1;
          if (adjustedIndex.isEven) {
            final examIndex = adjustedIndex ~/ 2;
            return GestureDetector(
              onTap: () {
                _showExamOptions(context, exams[examIndex]);
              },
              child: itemOfList(data: exams[examIndex].name),
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

  void _showExamOptions(BuildContext context, Exam exam) {
    bool timedMode = false;
    double examDuration = 60; // Default to 1 hour

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: myLime,
              title: Text(
                "Exam Options",
                style: flexableTextStyle(
                  size: 20,
                  color: myGreen,
                  isBold: true,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Timed Mode",
                        style: flexableTextStyle(
                          size: 16,
                          color: myGreen,
                          isBold: false,
                        ),
                      ),
                      Switch(
                        value: timedMode,
                        onChanged: (value) {
                          setState(() {
                            timedMode = value;
                          });
                        },
                        activeColor: myGreen,
                      ),
                    ],
                  ),
                  if (timedMode)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "Total exam duration (minutes)",
                          style: flexableTextStyle(
                            size: 16,
                            color: myGreen,
                            isBold: false,
                          ),
                        ),
                        Slider(
                          value: examDuration,
                          min: 20,
                          max: 120,
                          divisions: 10,
                          label: "${examDuration.toInt()} minutes",
                          onChanged: (value) {
                            setState(() {
                              examDuration = value;
                            });
                          },
                          activeColor: myGreen,
                          inactiveColor: myLightGray,
                        ),
                        Text(
                          "${examDuration.toInt()} minutes",
                          style: flexableTextStyle(
                            size: 16,
                            color: myGreen,
                            isBold: true,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: flexableTextStyle(
                      size: 16,
                      color: myGreen,
                      isBold: false,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(
                          questions: exam.questions,
                          timedMode: timedMode,
                          totalExamTime:
                              examDuration.toInt() * 60, // Convert to seconds
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Start Exam",
                    style: flexableTextStyle(
                      size: 16,
                      color: myGreen,
                      isBold: true,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

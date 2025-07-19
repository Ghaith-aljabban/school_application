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
    int timePerQuestion = 30;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Exam Options"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Text("Timed Mode"),
                      Switch(
                        value: timedMode,
                        onChanged: (value) {
                          setState(() {
                            timedMode = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (timedMode)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        const Text("Time per question (seconds)"),
                        Slider(
                          value: timePerQuestion.toDouble(),
                          min: 10,
                          max: 120,
                          divisions: 11,
                          label: timePerQuestion.toString(),
                          onChanged: (value) {
                            setState(() {
                              timePerQuestion = value.toInt();
                            });
                          },
                        ),
                        Text("$timePerQuestion seconds"),
                      ],
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
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
                          timePerQuestion: timePerQuestion,
                        ),
                      ),
                    );
                  },
                  child: const Text("Start Exam"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:school_application/Pages/preeexam/preform_preeexam_screen.dart';

import '../../Models/preeexam_question_model.dart';
import '../../Models/previous_exams_model.dart';
import '../../services/preexam_service.dart'; // Add this import
import '../../services/prequiz_service.dart';
import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class QuizListScreen extends StatefulWidget {
  final String subject;
  final int subjectId; // Added subjectId
  final int semesterId;
  final String semesterName;

  const QuizListScreen({
    super.key,
    required this.subject,
    required this.subjectId,
    required this.semesterId,
    required this.semesterName,
  });

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  List<Preexam> exams = []; // Updated type
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  Future<void> _loadExams() async {
    try {
      final fetchedExams = await PrequizService.getStudentPreexams(
        subjectId: widget.subjectId,
        semesterId: widget.semesterId,
      );

      setState(() {
        exams = fetchedExams;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

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
              Text("${widget.subject} Exams", style: greenHTextStyle),
            ],
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ?  Center(child: CircularProgressIndicator(color:myGreen))
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : exams.isEmpty
          ? Center(child: Text("No exams available", style: greenHTextStyle))
          : _buildExamList(),
    );
  }

  Widget _buildExamList() {
    return ListView.builder(
      itemCount: exams.length * 2 + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("${widget.subject} - ${widget.semesterName}", style: greenHTextStyle),
          );
        }

        final adjustedIndex = index - 1;
        if (adjustedIndex.isEven) {
          final examIndex = adjustedIndex ~/ 2;
          return GestureDetector(
            onTap: () {
              _showExamOptions(context, exams[examIndex]);
            },
            child: itemOfList(data: exams[examIndex].title), // Use title instead of name
          );
        } else {
          return Container(
            width: double.infinity,
            height: 1.0,
            color: myLightGray,
          );
        }
      },
    );
  }

  void _showExamOptions(BuildContext context, Preexam exam) {
    bool timedMode = false;
    double examDuration = exam.timeLimit.toDouble(); // Use exam's time limit as default

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
                  onPressed: () async {
                    Navigator.pop(context); // Close dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(
                          examId: exam.id, // Pass exam ID here
                          timedMode: timedMode,
                          totalExamTime: examDuration.toInt() * 60,
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
import 'package:flutter/material.dart';
import 'package:school_application/Models/exam_date_model.dart';
import 'package:school_application/Models/subjects_model.dart';
import 'package:school_application/services/exam_service.dart';
import '../../Models/quiz_date_model.dart';
import '../../services/quiz_service.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class QuizSchedule extends StatefulWidget {
  const QuizSchedule({super.key});

  @override
  State<QuizSchedule> createState() => _QuizScheduleState();
}

class _QuizScheduleState extends State<QuizSchedule> {
  late Future<List<QuizDateModel>> futureExams;
  final QuizService _quizService = QuizService();

  @override
  void initState() {
    super.initState();
    futureExams = _quizService.getNextQuizes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Quizes Schedule", style: greenHTextStyle),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<QuizDateModel>>(
        future: futureExams,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final exams = snapshot.data ?? [];

          if (exams.isEmpty) {
            return const Center(child: Text('No upcoming quizes'));
          }

          return Padding(
            padding: EdgeInsets.all(18.0),
            child: ListView.builder(
              itemCount: exams.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Upcoming quizes",
                      style: flexableTextStyle(
                        size: 30,
                        color: Colors.black,
                        isBold: true,
                      ),
                    ),
                  );
                }
                final exam = exams[index - 1 ];
                return ExamDateCard(
                  title: exam.subjectName,
                  description: "${exam.date} ${exam.timeStart} - ${exam.timeEnd}",
                  icon: SubjectsModel.getIconForSubject(exam.subjectName),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// ExamDateCard remains the same
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
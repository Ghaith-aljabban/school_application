// subject_semesters_screen_quiz.dart
import 'package:flutter/material.dart';
import 'package:school_application/Models/semester_model.dart';
import 'package:school_application/Pages/preeexam/subject_preeexam_avalibe_screen.dart';
import 'package:school_application/Pages/preequizzes/subject_preequizzes_avalibe_screen.dart';

import '../../services/preequizzes_semesters_service.dart';
import '../../services/preexam_service.dart';
import '../../services/preeexams_semesters_service.dart';
import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class SubjectSemestersScreenQuiz extends StatefulWidget {
  final String name;
  final int subjectId;

  const SubjectSemestersScreenQuiz({
    super.key,
    required this.name,
    required this.subjectId,
  });

  @override
  State<SubjectSemestersScreenQuiz> createState() => _SubjectSemestersScreenQuizState();
}

class _SubjectSemestersScreenQuizState extends State<SubjectSemestersScreenQuiz> {
  Future<List<Semester>> _getSemestersFuture() async {
    try {
      return await PreequizzesSemestersService.getSemestersBySubject(widget.subjectId);
    } catch (e) {
      throw e.toString();
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
              Text("Semesters", style: greenHTextStyle),
            ],
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<Semester>>(
        future: _getSemestersFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No semesters found'));
          } else {
            return _buildSemesterList(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildSemesterList(List<Semester> semesters) {
    return ListView.builder(
      itemCount: semesters.length * 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.name, style: greenHTextStyle),
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
                  builder: (context) => QuizListScreen(
                    subject: widget.name,
                    subjectId: widget.subjectId,
                    semesterId: semesters[dataIndex].semesterId,
                    semesterName: semesters[dataIndex].semesterName,
                  ),
                ),
              );
            },
            child: itemOfList(data: semesters[dataIndex].semesterName),
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
}
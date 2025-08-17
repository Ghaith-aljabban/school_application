import 'package:flutter/material.dart';
import 'package:school_application/Models/semester_model.dart';
import 'package:school_application/Pages/preeexam/subject_preeexam_avalibe_screen.dart';
import 'package:school_application/Pages/preequizzes/subject_preequizzes_avalibe_screen.dart';

import '../../services/preequizzes_semesters_service.dart';
import '../../services/preexam_service.dart'; // Add this import
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
  List<Semester> semesters = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSemesters();
  }

  Future<void> _loadSemesters() async {
    try {
      final fetchedSemesters = await PreequizzesSemestersService.getSemestersBySubject(widget.subjectId);
      setState(() {
        semesters = fetchedSemesters;
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
              Text("Semesters", style: greenHTextStyle),
            ],
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(child: Text(errorMessage!))
          : _buildSemesterList(),
    );
  }

  Widget _buildSemesterList() {
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
                    subjectId: widget.subjectId, // Pass subjectId
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
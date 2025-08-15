import 'package:school_application/Models/subjects_model.dart';

import '../main.dart';

class ExamDateModel {
  SubjectsModel subject;
  String date;
  String timeStart;
  String timeEnd;
  ExamDateModel({
    required this.subject,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
  });
}

List<ExamDateModel> myExams = [];

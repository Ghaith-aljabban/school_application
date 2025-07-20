import 'package:school_application/Models/subjects_model.dart';

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

List<ExamDateModel> myExams = [
  ExamDateModel(
    subject: mySubjects[0],
    date: "2025/7/2",
    timeStart: "10:00AM",
    timeEnd: "12:00PM",
  ),
  ExamDateModel(
    subject: mySubjects[1],
    date: "2025/7/2",
    timeStart: "10:00AM",
    timeEnd: "12:00PM",
  ),
  ExamDateModel(
    subject: mySubjects[2],
    date: "2025/7/2",
    timeStart: "10:00AM",
    timeEnd: "12:00PM",
  ),
];

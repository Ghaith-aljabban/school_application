// ======== previous_exams_model.dart ========
import 'package:school_application/models/preeexam_question_model.dart';

class PreviousExamsByYear {
  final String date;
  List<Exam> exams;
  PreviousExamsByYear({required this.date, required this.exams});
}

class Exam {
  final String id;
  final String name;
  final String year;
  final List<ExamQuestion> questions;

  Exam({
    required this.id,
    required this.name,
    required this.year,
    required this.questions,
  });
}

// Mock data for exams
final List<Exam> allExams = [
  Exam(
    id: "math-2024-1",
    name: "Mathematics Final Exam",
    year: "2024",
    questions: mockQuestions,
  ),
  Exam(
    id: "math-2024-2",
    name: "Mathematics Midterm",
    year: "2024",
    questions: mockQuestions,
  ),
];

List<PreviousExamsByYear> subjectPreviousExams = [
  PreviousExamsByYear(date: "2024", exams: allExams),
  PreviousExamsByYear(date: "2023", exams: allExams),
  PreviousExamsByYear(date: "2022", exams: allExams),
  PreviousExamsByYear(date: "2021", exams: allExams),
];

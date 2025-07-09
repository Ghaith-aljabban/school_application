class ReportCardModel {
  final String GPA;
  final String grade;
  final bool isFirstSemister;
  final List<SubjectScore> subject;
  final String year; // Add year property

  ReportCardModel({
    required this.GPA,
    required this.grade,
    required this.isFirstSemister,
    required this.subject,
    required this.year, // Add to constructor
  });
}


class SubjectScore {
  String name;
  int oralexam; //10
  int exam; //60
  int midterm; //20
  int quiz; //10
  SubjectScore({
    required this.name,
    required this.quiz,
    required this.exam,
    required this.midterm,
    required this.oralexam,
});

}

List<ReportCardModel> ghaithReportCards = [
  ReportCardModel(GPA: '100%', grade: '11th Grade', isFirstSemister: true, subject: [
    SubjectScore(name: "arabic", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "english", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "french", quiz: 10, exam: 55, midterm: 20, oralexam: 10),
    SubjectScore(name: "math", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "chemistry", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "physics", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "IT", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
  ],year: '2024'),
  ReportCardModel(GPA: '100%', grade: '11th Grade', isFirstSemister: false, subject: [
    SubjectScore(name: "arabic", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "english", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "french", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "math", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "chemistry", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "physics", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "IT", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
  ],year: '2024'),
  ReportCardModel(GPA: '100%', grade: '12th Grade', isFirstSemister: true, subject: [
    SubjectScore(name: "arabic", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "english", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "french", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "math", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "chemistry", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "physics", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "IT", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
  ],year: '2024'),
  ReportCardModel(GPA: '100%', grade: '12th Grade', isFirstSemister: false, subject: [
    SubjectScore(name: "arabic", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "english", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "french", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "math", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "chemistry", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "physics", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
    SubjectScore(name: "IT", quiz: 10, exam: 60, midterm: 20, oralexam: 10),
  ],year: '2024'),

];
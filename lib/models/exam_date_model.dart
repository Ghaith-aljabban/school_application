class ExamDateModel {
  String subjectName; // Simplified to just the name
  String date;
  String timeStart;
  String timeEnd;

  ExamDateModel({
    required this.subjectName,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
  });

  factory ExamDateModel.fromJson(Map<String, dynamic> json) {
    final start = DateTime.parse(json['start_datetime']);
    final end = DateTime.parse(json['end_datetime']);

    return ExamDateModel(
      subjectName: json['subject_name'],
      date: "${start.day}/${start.month}/${start.year}",
      timeStart: "${start.hour}:${start.minute.toString().padLeft(2, '0')}",
      timeEnd: "${end.hour}:${end.minute.toString().padLeft(2, '0')}",
    );
  }
}

List<ExamDateModel> myExams = [];
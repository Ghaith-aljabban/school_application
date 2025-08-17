class Preexam {
  final int id;
  final int subjectId;
  final String title;
  final String description;
  final int timeLimit;
  final int totalMark;
  final int passingMark;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final int semesterId;

  Preexam({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.timeLimit,
    required this.totalMark,
    required this.passingMark,
    required this.startDatetime,
    required this.endDatetime,
    required this.semesterId,
  });

  factory Preexam.fromMap(Map<String, dynamic> map) {
    return Preexam(
      id: map['id'] ?? 0,
      subjectId: map['subject_id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      timeLimit: map['time_limit'] ?? 0,
      totalMark: map['total_mark'] ?? 0,
      passingMark: map['passing_mark'] ?? 0,
      startDatetime: DateTime.parse(map['start_datetime']),
      endDatetime: DateTime.parse(map['end_datetime']),
      semesterId: map['semester_id'] ?? 0,
    );
  }
}
// daily_schedule_model.dart
class DailySubject {
  final String dayName;
  final List<SubjectTime> subjects;

  DailySubject({
    required this.dayName,
    required this.subjects,
  });
}

class SubjectTime {
  final String timeStart;
  final String timeEnd;
  final String subjectName;

  SubjectTime({
    required this.subjectName,
    required this.timeStart,
    required this.timeEnd,
  });
}
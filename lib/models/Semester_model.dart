// semester_model.dart
class Semester {
  final int semesterId;
  final String semesterName;
  final int academicYearId;
  final String year;

  Semester({
    required this.semesterId,
    required this.semesterName,
    required this.academicYearId,
    required this.year,
  });

  factory Semester.fromMap(Map<String, dynamic> map) {
    return Semester(
      semesterId: map['semesters_id'] ?? 0,
      semesterName: map['semester_name'] ?? '',
      academicYearId: map['academic_year_id'] ?? 0,
      year: map['year'] ?? '',
    );
  }
}
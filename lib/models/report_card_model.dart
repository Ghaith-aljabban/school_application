// Models/report_card_model.dart
class ReportCardModel {
  final int semesterId;
  final String semesterName;
  final List<SubjectScore> subjects;
  final double semesterAverage;
  final int totalSemesterAssignments;
  final double totalSemesterScore;

  ReportCardModel({
    required this.semesterId,
    required this.semesterName,
    required this.subjects,
    required this.semesterAverage,
    required this.totalSemesterAssignments,
    required this.totalSemesterScore,
  });

  factory ReportCardModel.fromMap(Map<String, dynamic> map) {
    return ReportCardModel(
      semesterId: map['semester_id'] ?? 0,
      semesterName: map['semester_name'] ?? '',
      subjects: List<SubjectScore>.from(
        (map['subjects'] ?? []).map((x) => SubjectScore.fromMap(x)),
      ),
      semesterAverage: (map['semesterAverage'] ?? 0).toDouble(),
      totalSemesterAssignments: map['totalSemesterAssignments'] ?? 0,
      totalSemesterScore: (map['totalSemesterScore'] ?? 0).toDouble(),
    );
  }

  // Helper getters
  String get grade => _extractGradeFromSemesterName(semesterName);
  bool get isFirstSemester => semesterName.toLowerCase().contains('fall');

// In the ReportCardModel class, update the _extractGradeFromSemesterName method:
  String _extractGradeFromSemesterName(String name) {
    // Try multiple patterns to extract grade from semester name
    final patterns = [
      RegExp(r'(\d+)(?:th|st|nd|rd)\s*Grade', caseSensitive: false), // "10th Grade"
      RegExp(r'Grade\s*(\d+)', caseSensitive: false), // "Grade 10"
      RegExp(r'(\d+)(?:th|st|nd|rd)', caseSensitive: false), // Just "10th"
      RegExp(r'\b(\d+)\b'), // Any number in the name
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(name);
      if (match != null && match.group(1) != null) {
        final gradeNum = int.tryParse(match.group(1)!);
        if (gradeNum != null) {
          return '${gradeNum}th Grade';
        }
      }
    }

    // If no pattern matches, return the original semester name
    return name;
  }

  String _extractYearFromSemesterName(String name) {
    final regExp = RegExp(r'(\d{4})');
    final match = regExp.firstMatch(name);
    return match?.group(1) ?? DateTime.now().year.toString();
  }
}

class SubjectScore {
  final int subjectId;
  final String subjectName;
  final List<GradeType> gradeTypes;
  final double subjectAverage;
  final int totalAssignments;
  final double totalScore;

  SubjectScore({
    required this.subjectId,
    required this.subjectName,
    required this.gradeTypes,
    required this.subjectAverage,
    required this.totalAssignments,
    required this.totalScore,
  });

  factory SubjectScore.fromMap(Map<String, dynamic> map) {
    return SubjectScore(
      subjectId: map['subject_id'] ?? 0,
      subjectName: map['subject_name'] ?? '',
      gradeTypes: List<GradeType>.from(
        (map['grade_types'] ?? []).map((x) => GradeType.fromMap(x)),
      ),
      subjectAverage: (map['subjectAverage'] ?? 0).toDouble(),
      totalAssignments: map['totalAssignments'] ?? 0,
      totalScore: (map['totalScore'] ?? 0).toDouble(),
    );
  }

  // Helper methods to get specific grade types
  int? getOralExam() => _getScoreForType('oral exam');
  int? getQuiz() => _getScoreForType('quiz');
  int? getExam() => _getScoreForType('exam');
  int? getMidterm() => _getScoreForType('midterm');

  int? _getScoreForType(String type) {
    final gradeType = gradeTypes.firstWhere(
          (gt) => gt.type.toLowerCase().contains(type.toLowerCase()),
      orElse: () => GradeType(type: '', assignments: [], typeAverage: 0, assignmentCount: 0, typeTotal: 0),
    );

    if (gradeType.assignments.isEmpty) return null;
    return gradeType.typeTotal.round();
  }
}

class GradeType {
  final String type;
  final List<Assignment> assignments;
  final double typeAverage;
  final int assignmentCount;
  final double typeTotal;

  GradeType({
    required this.type,
    required this.assignments,
    required this.typeAverage,
    required this.assignmentCount,
    required this.typeTotal,
  });

  factory GradeType.fromMap(Map<String, dynamic> map) {
    return GradeType(
      type: map['type'] ?? '',
      assignments: List<Assignment>.from(
        (map['assignments'] ?? []).map((x) => Assignment.fromMap(x)),
      ),
      typeAverage: (map['typeAverage'] ?? 0).toDouble(),
      assignmentCount: map['assignment_count'] ?? 0,
      typeTotal: (map['typeTotal'] ?? 0).toDouble(),
    );
  }
}

class Assignment {
  final double score;
  final double minScore;
  final double maxScore;
  final double percentage;

  Assignment({
    required this.score,
    required this.minScore,
    required this.maxScore,
    required this.percentage,
  });

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
      score: (map['score'] ?? 0).toDouble(),
      minScore: (map['min_score'] ?? 0).toDouble(),
      maxScore: (map['max_score'] ?? 0).toDouble(),
      percentage: (map['percentage'] ?? 0).toDouble(),
    );
  }
}
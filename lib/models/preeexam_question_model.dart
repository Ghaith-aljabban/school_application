class ExamDetails {
  final int examId;
  final String examUuid;
  final String examTitle;
  final int totalMark;
  final int passingMark;
  final int timeLimit;
  final List<ApiExamQuestion> questions;

  ExamDetails({
    required this.examId,
    required this.examUuid,
    required this.examTitle,
    required this.totalMark,
    required this.passingMark,
    required this.timeLimit,
    required this.questions,
  });

  factory ExamDetails.fromMap(Map<String, dynamic> map) {
    return ExamDetails(
        examId: map['exam_id'] ?? 0,
        examUuid: map['exam_uuid'] ?? '',
        examTitle: map['exam_title'] ?? '',
        totalMark: map['total_mark'] ?? 0,
        passingMark: map['passing_mark'] ?? 0,
        timeLimit: map['time_limit'] ?? 0,
        questions: List<ApiExamQuestion>.from(
        (map['questions'] ?? []).map((x) => ApiExamQuestion.fromMap(x)),
    ));
  }
}

class ApiExamQuestion {
  final int questionId;
  final String questionText;
  final int questionMark;
  final String type;
  final List<QuestionOption> options;

  ApiExamQuestion({
    required this.questionId,
    required this.questionText,
    required this.questionMark,
    required this.type,
    required this.options,
  });

  factory ApiExamQuestion.fromMap(Map<String, dynamic> map) {
    return ApiExamQuestion(
        questionId: map['question_id'] ?? 0,
        questionText: map['question_text'] ?? '',
        questionMark: map['questin_mark'] ?? 0,
        type: map['type'] ?? '',
        options: List<QuestionOption>.from(
        (map['options'] ?? []).map((x) => QuestionOption.fromMap(x)),
    ));
  }
}

class QuestionOption {
  final int optionId;
  final String text;
  final bool isCorrect;

  QuestionOption({
    required this.optionId,
    required this.text,
    required this.isCorrect,
  });

  factory QuestionOption.fromMap(Map<String, dynamic> map) {
    return QuestionOption(
      optionId: map['option_id'] ?? 0,
      text: map['text'] ?? '',
      isCorrect: map['is_correct'] ?? false,
    );
  }
}
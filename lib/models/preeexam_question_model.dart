class ExamQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int grade;

  ExamQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.grade,
  });
}

List<ExamQuestion> mockQuestions = [
  ExamQuestion(
    question: "What is the capital of France?",
    options: ["London", "Berlin", "Paris", "Madrid"],
    correctAnswerIndex: 2,
    grade: 1,
  ),
  ExamQuestion(
    question: "Which planet is known as the Red Planet?",
    options: ["Venus", "Mars", "Jupiter", "Saturn"],
    correctAnswerIndex: 1,
    grade: 1,
  ),
  ExamQuestion(
    question: "What is 2 + 2?",
    options: ["3", "4", "5", "6"],
    correctAnswerIndex: 1,
    grade: 1,
  ),
  ExamQuestion(
    question: "Who painted the Mona Lisa?",
    options: [
      "Vincent van Gogh",
      "Pablo Picasso",
      "Leonardo da Vinci",
      "Michelangelo",
    ],
    correctAnswerIndex: 2,
    grade: 1,
  ),
  ExamQuestion(
    question: "What is the largest mammal?",
    options: ["Elephant", "Blue Whale", "Giraffe", "Polar Bear"],
    correctAnswerIndex: 1,
    grade: 1,
  ),
];

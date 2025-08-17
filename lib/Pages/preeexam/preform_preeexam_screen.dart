import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_application/Models/preeexam_question_model.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

import '../../services/preeexam_quistion_service.dart';

class QuizPage extends StatefulWidget {
  final int examId;
  final bool timedMode;
  final int? totalExamTime;

  const QuizPage({
    Key? key,
    required this.examId,
    this.timedMode = false,
    this.totalExamTime = 3600,
  }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  Timer? _timer;
  int _timeRemaining = 0;
  bool _examCompleted = false;
  late Future<ExamDetails> _examDetailsFuture;
  ExamDetails? examDetails;
  List<int?> userAnswers = []; // Track user answers for all questions

  List<ExamQuestion> _convertApiQuestions(List<ApiExamQuestion> apiQuestions) {
    return apiQuestions.map((apiQ) {
      int correctIndex = -1;
      for (int i = 0; i < apiQ.options.length; i++) {
        if (apiQ.options[i].isCorrect) {
          correctIndex = i;
          break;
        }
      }
      if (correctIndex == -1) correctIndex = 0;

      return ExamQuestion(
        question: apiQ.questionText,
        options: apiQ.options.map((opt) => opt.text).toList(),
        correctAnswerIndex: correctIndex,
        marks: apiQ.questionMark, // Include marks from API
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _examDetailsFuture = _loadExamDetails();
    if (widget.timedMode) {
      _timeRemaining = widget.totalExamTime!;
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<ExamDetails> _loadExamDetails() async {
    try {
      return await PreeexamQuistionService.getExamQuestions(widget.examId);
    } catch (e) {
      throw Exception('Failed to load exam: $e');
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer?.cancel();
        _showResults();
      }
    });
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
  }

  void _confirmSubmit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: myLime,
        title: Text(
          "Submit Exam?",
          style: flexableTextStyle(size: 20, color: myGreen, isBold: true),
        ),
        content: Text(
          "Are you sure you want to submit your answers?",
          style: flexableTextStyle(size: 16, color: myGreen, isBold: false),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: flexableTextStyle(size: 16, color: myGreen, isBold: false),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _checkAnswer(_convertApiQuestions(examDetails?.questions ?? []));
            },
            child: Text(
              "Submit",
              style: flexableTextStyle(size: 16, color: myGreen, isBold: true),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExamDetails>(
      future: _examDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: myLime,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: myLime,
            body: Center(
              child: Text(
                'Error loading exam: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        examDetails = snapshot.data;
        final questions = _convertApiQuestions(examDetails!.questions);
        if (questions.isEmpty) {
          return Scaffold(
            backgroundColor: myLime,
            body: Center(
              child: Text(
                'No questions available for this exam',
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        // Initialize userAnswers list if empty
        if (userAnswers.isEmpty) {
          userAnswers = List<int?>.filled(questions.length, null);
        }

        final question = questions[currentQuestionIndex];
        selectedAnswerIndex = userAnswers[currentQuestionIndex];

        return Scaffold(
          backgroundColor: myLime,
          appBar: AppBar(
            backgroundColor: myLime,
            title: Text(
              examDetails!.examTitle,
              style: flexableTextStyle(size: 20, color: myGreen, isBold: true),
            ),
            actions: [
              if (widget.timedMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      _formatTime(_timeRemaining),
                      style: flexableTextStyle(
                        size: 18,
                        color: _timeRemaining <= 60 ? Colors.red : myGreen,
                        isBold: true,
                      ),
                    ),
                  ),
                ),
            ],
            iconTheme: IconThemeData(color: myGreen),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Question ${currentQuestionIndex + 1} of ${questions.length}",
                  style: flexableTextStyle(size: 18, color: myGreen, isBold: true),
                ),
                const SizedBox(height: 16),
                Text(
                  question.question,
                  style: flexableTextStyle(
                    size: 20,
                    color: Colors.black,
                    isBold: false,
                  ),
                ),
                const SizedBox(height: 20),
                ...List.generate(question.options.length, (index) {
                  final isSelected = selectedAnswerIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAnswerIndex = index;
                        userAnswers[currentQuestionIndex] = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? myGreen.withOpacity(0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected ? myGreen : myGray,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Radio<int>(
                            value: index,
                            groupValue: selectedAnswerIndex,
                            onChanged: (value) {
                              setState(() {
                                selectedAnswerIndex = value;
                                userAnswers[currentQuestionIndex] = value;
                              });
                            },
                            activeColor: myGreen,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              question.options[index],
                              style: flexableTextStyle(
                                size: 16,
                                color: Colors.black,
                                isBold: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentQuestionIndex > 0)
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentQuestionIndex--;
                          });
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: myGreen),
                        child: Text(
                          "Back",
                          style: flexableTextStyle(
                            size: 16,
                            color: Colors.white,
                            isBold: true,
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        if (currentQuestionIndex == questions.length - 1) {
                          _confirmSubmit();
                        } else {
                          _checkAnswer(questions);
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: myGreen),
                      child: Text(
                        currentQuestionIndex == questions.length - 1
                            ? "Submit"
                            : "Next",
                        style: flexableTextStyle(
                          size: 16,
                          color: Colors.white,
                          isBold: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _checkAnswer(List<ExamQuestion> questions) {
    // Save current answer
    userAnswers[currentQuestionIndex] = selectedAnswerIndex;

    // Calculate score based on all answered questions
    score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] != null &&
          userAnswers[i] == questions[i].correctAnswerIndex) {
        score += questions[i].marks;
      }
    }

    if (!mounted) return;

    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswerIndex = userAnswers[currentQuestionIndex];
      } else {
        _examCompleted = true;
        _showResults();
      }
    });
  }

  void _showResults() {
    if (!mounted) return;

    final questions = _convertApiQuestions(examDetails?.questions ?? []);
    int totalMarks = examDetails?.totalMark ??
        questions.fold(0, (sum, q) => sum + q.marks);
    bool passed = score >= (examDetails?.passingMark ?? 0);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: myLime,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Exam ${passed ? 'Passed' : 'Failed'}!",
          style: flexableTextStyle(
              size: 20,
              color: passed ? myGreen : Colors.red,
              isBold: true
          ),
        ),
        content: Text(
          "Your score: $score/$totalMarks\n"
              "Percentage: ${(score / totalMarks * 100).toStringAsFixed(1)}%\n"
              "Passing mark: ${examDetails?.passingMark ?? 0}",
          style: flexableTextStyle(size: 16, color: myGreen, isBold: false),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              "Finish",
              style: flexableTextStyle(size: 16, color: myGreen, isBold: true),
            ),
          ),
        ],
      ),
    );
  }
}

class ExamQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final int marks;

  ExamQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.marks,
  });
}
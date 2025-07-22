import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_application/Models/preeexam_question_model.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

class QuizPage extends StatefulWidget {
  final List<ExamQuestion> questions;
  final bool timedMode;
  final int? totalExamTime; // in seconds

  const QuizPage({
    Key? key,
    required this.questions,
    this.timedMode = false,
    this.totalExamTime = 3600, // Default to 1 hour
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

  @override
  void initState() {
    super.initState();
    if (widget.timedMode) {
      _timeRemaining = widget.totalExamTime!;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        timer.cancel();
        _submitExam();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _checkAnswer() {
    if (selectedAnswerIndex ==
        widget.questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }

    if (!mounted) return;

    setState(() {
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      } else {
        _examCompleted = true;
        _showResults();
      }
    });
  }

  void _showResults() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: myLime,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Quiz Completed!",
          style: flexableTextStyle(size: 20, color: myGreen, isBold: true),
        ),
        content: Text(
          "Your score: $score/${widget.questions.length}\n"
          "Percentage: ${(score / widget.questions.length * 100).toStringAsFixed(1)}%",
          style: flexableTextStyle(size: 16, color: myGreen, isBold: false),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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

  void _confirmSubmit() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: myLime,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          "Submit Quiz?",
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
              style: flexableTextStyle(size: 16, color: myGreen, isBold: true),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _checkAnswer();
              _submitExam();
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

  void _submitExam() {
    _timer?.cancel();
    _showResults();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: myLime,
      appBar: AppBar(
        backgroundColor: myLime,
        title: Text(
          "MC Quiz",
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
              "Question ${currentQuestionIndex + 1} of ${widget.questions.length}",
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
            // Options with uncheck support
            ...List.generate(question.options.length, (index) {
              final isSelected = selectedAnswerIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (selectedAnswerIndex == index) {
                      selectedAnswerIndex = null; // Uncheck
                    } else {
                      selectedAnswerIndex = index;
                    }
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
                            if (selectedAnswerIndex == value) {
                              selectedAnswerIndex = null;
                            } else {
                              selectedAnswerIndex = value;
                            }
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
                        selectedAnswerIndex = null;
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
                    if (currentQuestionIndex == widget.questions.length - 1) {
                      _confirmSubmit();
                    } else {
                      _checkAnswer(); // Allows skipping
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: myGreen),
                  child: Text(
                    currentQuestionIndex == widget.questions.length - 1
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
  }
}

void printRouteStack(BuildContext context) {
  String stack = "Current Navigation Stack:\n";
  int level = 0;

  Navigator.of(context).popUntil((route) {
    stack += "[${level++}] ${route.settings.name ?? route.runtimeType}\n";
    return false; // Continue through entire stack
  });

  debugPrint(stack);
}

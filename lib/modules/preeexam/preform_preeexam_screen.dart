// ======== preform_preeexam_screen.dart ========
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_application/models/preeexam_question_model.dart';

class QuizPage extends StatefulWidget {
  final List<ExamQuestion> questions;
  final bool timedMode;
  final int? timePerQuestion; // in seconds

  const QuizPage({
    Key? key,
    required this.questions,
    this.timedMode = false,
    this.timePerQuestion = 30,
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
      _timeRemaining = widget.timePerQuestion!;
      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        // Time's up, move to next question
        _timer?.cancel();
        _checkAnswer();
      }
    });
  }

  void _checkAnswer() {
    if (selectedAnswerIndex ==
        widget.questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }

    setState(() {
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        if (widget.timedMode) {
          _timeRemaining = widget.timePerQuestion!;
          _startTimer();
        }
      } else {
        _examCompleted = true;
        _showResults();
      }
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Completed!"),
        content: Text(
          "Your score: $score/${widget.questions.length}\n"
          "Percentage: ${(score / widget.questions.length * 100).toStringAsFixed(1)}%",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to exams list
            },
            child: const Text("Finish"),
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
    if (_examCompleted) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MC Quiz"),
        actions: [
          if (widget.timedMode)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  "$_timeRemaining s",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Question ${currentQuestionIndex + 1} of ${widget.questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(question.question, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ...List.generate(
              question.options.length,
              (index) => RadioListTile<int>(
                title: Text(question.options[index]),
                value: index,
                groupValue: selectedAnswerIndex,
                onChanged: (value) {
                  setState(() {
                    selectedAnswerIndex = value;
                  });
                },
              ),
            ),
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
                        if (widget.timedMode) {
                          _timer?.cancel();
                          _timeRemaining = widget.timePerQuestion!;
                          _startTimer();
                        }
                      });
                    },
                    child: const Text("Back"),
                  ),
                ElevatedButton(
                  onPressed: selectedAnswerIndex == null ? null : _checkAnswer,
                  child: Text(
                    currentQuestionIndex == widget.questions.length - 1
                        ? "Submit"
                        : "Next",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitExam,
        tooltip: 'Submit Exam',
        child: const Icon(Icons.done),
      ),
    );
  }
}

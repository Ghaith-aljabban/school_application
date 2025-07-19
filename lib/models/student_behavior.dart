import 'package:flutter/material.dart';

class StudentBehavior {
  final String title;
  final String description;
  final IconData icon;
  final String kind; // Changed to lowercase for Dart naming conventions
  final Color color; // Added color property

  StudentBehavior({
    required this.title,
    required this.description,
    required this.icon,
    required this.kind,
    required this.color,
  });
}

// Helper function to get color based on behavior kind
Color _getColorForKind(String kind) {
  switch (kind) {
    case 'Exam Issues':
      return Colors.redAccent;
    case 'Attendance Problems':
      return Colors.orangeAccent;
    case 'Academic Integrity':
      return Colors.purpleAccent;
    case 'Behavior Concerns':
      return Colors.blueAccent;
    case 'Social Skills':
      return Colors.tealAccent;
    case 'Work Habits':
      return Colors.amber;
    case 'Practical Skills':
      return Colors.greenAccent;
    default:
      return Colors.grey;
  }
}

List<StudentBehavior> studentBehaviors = [
  StudentBehavior(
    title: 'Failed Midterm Exam',
    description: 'Scored below passing grade in midterm examination',
    icon: Icons.assignment_late,
    kind: 'Exam Issues',
    color: _getColorForKind('Exam Issues'),
  ),
  StudentBehavior(
    title: 'Frequent Absences',
    description: 'Missed more than 30% of classes this semester',
    icon: Icons.event_busy,
    kind: 'Attendance Problems',
    color: _getColorForKind('Attendance Problems'),
  ),
  StudentBehavior(
    title: 'Plagiarism Incident',
    description: 'Submitted work containing unoriginal content',
    icon: Icons.content_copy,
    kind: 'Academic Integrity',
    color: _getColorForKind('Academic Integrity'),
  ),
  StudentBehavior(
    title: 'Classroom Disturbances',
    description: 'Regularly disrupts lectures with off-topic comments',
    icon: Icons.volume_off,
    kind: 'Behavior Concerns',
    color: _getColorForKind('Behavior Concerns'),
  ),
  StudentBehavior(
    title: 'Low Quiz Scores',
    description: 'Consistently poor performance in weekly quizzes',
    icon: Icons.quiz,
    kind: 'Exam Issues',
    color: _getColorForKind('Exam Issues'),
  ),
  StudentBehavior(
    title: 'Group Work Conflicts',
    description: 'Difficulty collaborating with peers on team projects',
    icon: Icons.group_remove,
    kind: 'Social Skills',
    color: _getColorForKind('Social Skills'),
  ),
  StudentBehavior(
    title: 'Late Assignments',
    description: 'Multiple submissions past the deadline',
    icon: Icons.timer_off,
    kind: 'Work Habits',
    color: _getColorForKind('Work Habits'),
  ),
  StudentBehavior(
    title: 'Poor Lab Performance',
    description: 'Struggles with practical laboratory exercises',
    icon: Icons.science,
    kind: 'Practical Skills',
    color: _getColorForKind('Practical Skills'),
  ),
];

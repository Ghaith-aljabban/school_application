import 'package:flutter/material.dart';

class StudentBehavior {
  final int? id;
  final int? studentId;
  final String description;
  final String date;
  final int? createdBy;
  final String type;
  
  // UI properties for existing design
  final String title;
  final IconData icon;
  final String kind;
  final Color color;

  StudentBehavior({
    this.id,
    this.studentId,
    required this.description,
    required this.date,
    this.createdBy,
    required this.type,
    required this.title,
    required this.icon,
    required this.kind,
    required this.color,
  });

  // Factory constructor from API response
  factory StudentBehavior.fromApi(Map<String, dynamic> data) {
    final type = data['type'] ?? '';
    final description = data['description'] ?? 'No description available';
    
    return StudentBehavior(
      id: data['id'],
      studentId: data['student_id'],
      description: description,
      date: data['date'] ?? '',
      createdBy: data['created_by'],
      type: type,
      title: _getTitleForType(type),
      icon: _getIconForKind(type),
      kind: type,
      color: _getColorForKind(type),
    );
  }

  // Method to convert to Map for API requests
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student_id': studentId,
      'description': description,
      'date': date,
      'created_by': createdBy,
      'type': type,
    };
  }

  // Helper method to get title for behavior type
  static String _getTitleForType(String type) {
    switch (type) {
      case 'Exam Issues':
        return 'Failed Midterm Exam';
      case 'Attendance Problems':
        return 'Frequent Absences';
      case 'Academic Integrity':
        return 'Academic Integrity Violation';
      case 'Behavior Concerns':
        return 'Behavior Issue';
      case 'Social Skills':
        return 'Social Skills Concern';
      case 'Work Habits':
        return 'Work Habit Issue';
      case 'Practical Skills':
        return 'Practical Skills Concern';
      case 'Positive Behaviors':
        return 'Excellent Participation';
      case 'Health Issues':
        return 'Health Concern';
      case 'Technical Skills':
        return 'Technical Skills Issue';
      case 'Time Management':
        return 'Time Management Issue';
      case 'Participation':
        return 'Participation Concern';
      default:
        return type.isNotEmpty ? type : 'Behavior Record';
    }
  }
}

// Helper function to get color based on behavior kind
// Method to get icon for behavior kind
IconData _getIconForKind(String kind) {
  switch (kind) {
    case 'Exam Issues':
      return Icons.assignment;
    case 'Attendance Problems':
      return Icons.event_busy;
    case 'Academic Integrity':
      return Icons.warning;
    case 'Behavior Concerns':
      return Icons.error;
    case 'Social Skills':
      return Icons.group;
    case 'Work Habits':
      return Icons.work;
    case 'Practical Skills':
      return Icons.build;
    case 'Positive Behaviors':
      return Icons.thumb_up;
    case 'Health Issues':
      return Icons.medical_services;
    case 'Technical Skills':
      return Icons.computer;
    case 'Time Management':
      return Icons.access_time;
    case 'Participation':
      return Icons.mic;
    default:
      return Icons.help;
  }
}

// Existing color method updated with 12 categories
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
    case 'Positive Behaviors':
      return Colors.lightGreen;
    case 'Health Issues':
      return Colors.pinkAccent;
    case 'Technical Skills':
      return Colors.cyanAccent;
    case 'Time Management':
      return Colors.deepOrangeAccent;
    case 'Participation':
      return Colors.lightBlueAccent;
    default:
      return Colors.grey;
  }
}

// Updated list using both methods - keeping for fallback
List<StudentBehavior> studentBehaviors = [
  StudentBehavior(
    description: 'Scored below passing grade in midterm examination',
    date: '',
    type: 'Exam Issues',
    title: 'Failed Midterm Exam',
    kind: 'Exam Issues',
    icon: _getIconForKind('Exam Issues'),
    color: _getColorForKind('Exam Issues'),
  ),
  StudentBehavior(
    description: 'Missed more than 30% of classes this semester',
    date: '',
    type: 'Attendance Problems',
    title: 'Frequent Absences',
    kind: 'Attendance Problems',
    icon: _getIconForKind('Attendance Problems'),
    color: _getColorForKind('Attendance Problems'),
  ),
  // Add remaining items following the same pattern...
  StudentBehavior(
    description: 'Always actively contributes in class discussions',
    date: '',
    type: 'Participation',
    title: 'Excellent Participation',
    kind: 'Participation',
    icon: _getIconForKind('Participation'),
    color: _getColorForKind('Participation'),
  ),
];
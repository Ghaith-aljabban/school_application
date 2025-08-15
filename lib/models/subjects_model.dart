import 'package:flutter/material.dart';

class SubjectsModel {
  int id;
  String name;
  SubjectsModel({required this.name, required this.id});

  factory SubjectsModel.fromMap(Map<String, dynamic> map) {
    return SubjectsModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  static IconData getIconForSubject(String subject) {
    final lowerSubject = subject.toLowerCase();

    switch (lowerSubject) {
// Mathematics
      case 'math':
      case 'mathematics':
      case 'maths':
      case 'calculus':
      case 'algebra':
      case 'geometry':
      case 'trigonometry':
        return Icons.calculate;

// Physics
      case 'physics':
      case 'phys':
      case 'physical science':
      case 'mechanics':
      case 'thermodynamics':
        return Icons.science;

// Chemistry
      case 'chemistry':
      case 'chem':
      case 'organic chemistry':
      case 'inorganic chemistry':
      case 'biochemistry':
        return Icons.emoji_objects;

// Computer Science
      case 'it':
      case 'computer':
      case 'computers':
      case 'computer science':
      case 'cs':
      case 'ict':
      case 'programming':
      case 'coding':
      case 'software':
        return Icons.computer;

// Languages
      case 'arabic':
      case 'ar':
      case 'arabic language':
        return Icons.language;

      case 'english':
      case 'eng':
      case 'english language':
      case 'english literature':
        return Icons.abc;

      case 'french':
      case 'fr':
      case 'french language':
        return Icons.language;

      case 'spanish':
      case 'es':
      case 'spanish language':
        return Icons.language;

// Sciences
      case 'biology':
      case 'bio':
      case 'life science':
        return Icons.eco;

      case 'geology':
      case 'earth science':
        return Icons.terrain;

// Social Studies
      case 'history':
      case 'hist':
      case 'world history':
        return Icons.history;

      case 'geography':
      case 'geo':
        return Icons.map;

      case 'economics':
      case 'econ':
      case 'microeconomics':
      case 'macroeconomics':
        return Icons.attach_money;

      case 'psychology':
      case 'psych':
        return Icons.psychology;

      case 'philosophy':
      case 'phil':
        return Icons.lightbulb;

// Arts
      case 'art':
      case 'arts':
      case 'fine arts':
        return Icons.palette;

      case 'music':
      case 'music theory':
        return Icons.music_note;

      case 'drama':
      case 'theater':
      case 'theatre':
        return Icons.theaters;

// Physical Education
      case 'pe':
      case 'physical education':
      case 'sport':
      case 'sports':
      case 'gym':
        return Icons.sports_soccer;

// Literature
      case 'literature':
      case 'lit':
      case 'english lit':
        return Icons.menu_book;

// Business
      case 'business':
      case 'business studies':
      case 'management':
        return Icons.business;

      case 'accounting':
      case 'accountancy':
        return Icons.calculate;

// Engineering
      case 'engineering':
      case 'mechanical engineering':
      case 'electrical engineering':
        return Icons.engineering;

// Health
      case 'health':
      case 'health science':
      case 'anatomy':
        return Icons.medical_services;

// Default
      default:
        return Icons.school;
    }
  }
}

// final List<SubjectsModel> subjects = data.map((item) {
//   return SubjectsModel(
//     id: item['id'] ?? 0,  // Add this line
//     name: item['name'] ?? 'Unknown Subject',
//   );
// }).toList();




import 'package:flutter/material.dart';

class SubjectsModel {
  String name;
  IconData icon;
  SubjectsModel({required this.name, required this.icon});
}

List<SubjectsModel> mySubjects = [
  SubjectsModel(name: 'Math', icon: Icons.calculate),
  SubjectsModel(name: 'Physics', icon: Icons.airplanemode_active),
  SubjectsModel(name: 'Chemistry', icon: Icons.analytics_rounded),
  SubjectsModel(name: 'IT', icon: Icons.computer),
  SubjectsModel(name: 'Arabic', icon: Icons.language),
  SubjectsModel(name: 'English', icon: Icons.abc),
];

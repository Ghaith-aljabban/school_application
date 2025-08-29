// Pages/report card/report_card_details_screen.dart
import 'package:flutter/material.dart';
import 'package:school_application/Models/report_card_model.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

class ReportCardDetailsScreen extends StatelessWidget {
  final ReportCardModel reportCard;

  const ReportCardDetailsScreen({super.key, required this.reportCard});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Report Cards", style: greenHTextStyle),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              " ${reportCard.grade}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              "Student report card in the ${reportCard.isFirstSemester ? 'first' : 'second'} Semester in ",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            const Text(
              "Subjects:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...reportCard.subjects.map((subject) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subject.subjectName,
                          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                      const SizedBox(height: 8),
                      if (subject.gradeTypes.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text('No assignments', style: TextStyle(color: Colors.grey[600])),
                        )
                      else
                        Column(
                          children: [
                            ...subject.gradeTypes.map((gt) {
                              final double typeScore = gt.assignments
                                  .fold<double>(0, (sum, a) => sum + a.score);
                              final double typeMax = gt.assignments
                                  .fold<double>(0, (sum, a) => sum + a.maxScore);
                              final String typeTotalText = typeMax > 0
                                  ? '${typeScore.toStringAsFixed(0)}/${typeMax.toStringAsFixed(0)}'
                                  : typeScore.toStringAsFixed(1);

                              return ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.zero,
                                title: Text(gt.type.isEmpty ? 'Assignment' : gt.type),
                                trailing: Text(
                                  typeTotalText,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            }).toList(),
                            const Divider(height: 16),
                            Builder(
                              builder: (_) {
                                final double subjectScore = subject.gradeTypes
                                    .expand((gt) => gt.assignments)
                                    .fold<double>(0, (sum, a) => sum + a.score);
                                final double subjectMax = subject.gradeTypes
                                    .expand((gt) => gt.assignments)
                                    .fold<double>(0, (sum, a) => sum + a.maxScore);
                                final String subjectTotalText = subjectMax > 0
                                    ? '${subjectScore.toStringAsFixed(0)}/${subjectMax.toStringAsFixed(0)}'
                                    : subjectScore.toStringAsFixed(1);
                                return Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'Total: $subjectTotalText',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
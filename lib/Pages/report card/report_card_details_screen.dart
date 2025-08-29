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
    // Calculate averages and totals
    double totalOral = 0;
    double totalQuiz = 0;
    double totalExam = 0;
    double totalMidterm = 0;
    double totalAllSubjects = 0;

    int oralCount = 0;
    int quizCount = 0;
    int examCount = 0;
    int midtermCount = 0;

    for (var subject in reportCard.subjects) {
      final oral = subject.getOralExam();
      final quiz = subject.getQuiz();
      final exam = subject.getExam();
      final midterm = subject.getMidterm();

      if (oral != null) {
        totalOral += oral;
        oralCount++;
      }
      if (quiz != null) {
        totalQuiz += quiz;
        quizCount++;
      }
      if (exam != null) {
        totalExam += exam;
        examCount++;
      }
      if (midterm != null) {
        totalMidterm += midterm;
        midtermCount++;
      }

      totalAllSubjects += subject.totalScore;
    }

    // Calculate averages
    double avgOral = oralCount > 0 ? totalOral / oralCount : 0;
    double avgQuiz = quizCount > 0 ? totalQuiz / quizCount : 0;
    double avgExam = examCount > 0 ? totalExam / examCount : 0;
    double avgMidterm = midtermCount > 0 ? totalMidterm / midtermCount : 0;
    double avgTotal = reportCard.subjects.isNotEmpty
        ? totalAllSubjects / reportCard.subjects.length
        : 0;

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
            // Details label
            const Text(
              "Details:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Subjects table
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) => myLime,
                      ),
                      columns: const [
                        DataColumn(label: Text("Subject")),
                        DataColumn(label: Text("Oral Exam"), numeric: true),
                        DataColumn(label: Text("Quiz"), numeric: true),
                        DataColumn(label: Text("Exam"), numeric: true),
                        DataColumn(label: Text("Midterm"), numeric: true),
                        DataColumn(label: Text("Total"), numeric: true),
                      ],
                      rows: [
                        ...reportCard.subjects.map(
                              (subject) => DataRow(
                            cells: [
                              DataCell(Text(subject.subjectName)),
                              DataCell(Text(subject.getOralExam()?.toString() ?? "N/A")),
                              DataCell(Text(subject.getQuiz()?.toString() ?? "N/A")),
                              DataCell(Text(subject.getExam()?.toString() ?? "N/A")),
                              DataCell(Text(subject.getMidterm()?.toString() ?? "N/A")),
                              DataCell(Text(subject.totalScore.toStringAsFixed(1))),
                            ],
                          ),
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Average")),
                            DataCell(Text(avgOral.toStringAsFixed(1))),
                            DataCell(Text(avgQuiz.toStringAsFixed(1))),
                            DataCell(Text(avgExam.toStringAsFixed(1))),
                            DataCell(Text(avgMidterm.toStringAsFixed(1))),
                            DataCell(Text(avgTotal.toStringAsFixed(1))),
                          ],
                          color: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) => Colors.grey[300],
                          ),
                        ),
                      ],
                      dataRowMinHeight: 40,
                      dataRowMaxHeight: 60,
                      headingRowHeight: 50,
                      horizontalMargin: 12,
                      columnSpacing: 12,
                      dividerThickness: 1,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
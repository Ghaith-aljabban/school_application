import 'package:flutter/material.dart';
import 'package:school_application/models/report_card_model.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

class ReportCardDetailsScreen extends StatelessWidget {
  final ReportCardModel reportCard;

  const ReportCardDetailsScreen({super.key, required this.reportCard});

  @override
  Widget build(BuildContext context) {
    // Calculate averages with correct maximums
    final int maxOral = 10;
    final int maxQuiz = 20;
    final int maxExam = 70;

    double totalOral = 0;
    double totalQuiz = 0;
    double totalExam = 0;
    int subjectCount = reportCard.subject.length;

    for (var subject in reportCard.subject) {
      totalOral += subject.oralexam;
      totalQuiz += subject.quiz;
      totalExam += subject.exam;
    }

    // Calculate averages
    double avgOral = subjectCount > 0 ? totalOral / subjectCount : 0;
    double avgQuiz = subjectCount > 0 ? totalQuiz / subjectCount : 0;
    double avgExam = subjectCount > 0 ? totalExam / subjectCount : 0;

    // Calculate maximum possible totals
    int maxTotalOral = maxOral * subjectCount;
    int maxTotalQuiz = maxQuiz * subjectCount;
    int maxTotalExam = maxExam * subjectCount;

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
              "${reportCard.isFirstSemister ? 'First' : 'Second'} Semester ${reportCard.grade}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              "Student report card in the ${reportCard.isFirstSemister ? 'first' : 'second'} Semester in ${reportCard.year}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),

            // GPA
            Text(
              "GPA: ${reportCard.GPA}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: myGreen,
              ),
            ),
            const SizedBox(height: 20),

            // Details label
            const Text(
              "Details:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Subjects table - takes full width
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) => myLime,
                      ),
                      columns: [
                        DataColumn(
                          label: const Text("Subject"),
                          tooltip: "Subject Name",
                        ),
                        DataColumn(
                          label: const Text("Oral Exam"),
                          numeric: true,
                          tooltip: "Oral Exam (Max $maxOral)",
                        ),
                        DataColumn(
                          label: const Text("Quiz"),
                          numeric: true,
                          tooltip: "Quiz (Max $maxQuiz)",
                        ),
                        DataColumn(
                          label: const Text("Exam"),
                          numeric: true,
                          tooltip: "Exam (Max $maxExam)",
                        ),
                      ],
                      rows: [
                        ...reportCard.subject.map((subject) => DataRow(
                          cells: [
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: constraints.maxWidth * 0.3, // Adjust as needed
                                ),
                                child: Text(subject.name),
                              ),
                            ),
                            DataCell(Text("${subject.oralexam}/$maxOral")),
                            DataCell(Text("${subject.quiz}/$maxQuiz")),
                            DataCell(Text("${subject.exam}/$maxExam")),
                          ],
                        )),
                        DataRow(
                          cells: [
                            const DataCell(Text("Average")),
                            DataCell(Text("${avgOral.toStringAsFixed(1)}/$maxOral")),
                            DataCell(Text("${avgQuiz.toStringAsFixed(1)}/$maxQuiz")),
                            DataCell(Text("${avgExam.toStringAsFixed(1)}/$maxExam")),
                          ],
                          color: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) => Colors.grey[300],
                          ),
                        ),
                        DataRow(
                          cells: [
                            const DataCell(Text("Total")),
                            DataCell(Text("${totalOral.toStringAsFixed(1)}/$maxTotalOral")),
                            DataCell(Text("${totalQuiz.toStringAsFixed(1)}/$maxTotalQuiz")),
                            DataCell(Text("${totalExam.toStringAsFixed(1)}/$maxTotalExam")),
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
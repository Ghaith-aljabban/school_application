import 'package:flutter/material.dart';
import 'package:school_application/models/report_card_model.dart';
import 'package:school_application/modules/report%20card/report_card_details_screen.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

import '../../shared/components/constants.dart';


class ReportCardHistoryScreen extends StatelessWidget {
  const ReportCardHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Report Cards", style: greenHTextStyle)
            ],
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: ghaithReportCards.length,
              itemBuilder:(context, index) {
                final reportCard = ghaithReportCards[index];
                return defaultReportcard(
                  header: reportCard.grade + (reportCard.isFirstSemister ? ' first semester' : ' second semester'),
                  description: 'Student report card in the ${reportCard.isFirstSemister ? 'first' : 'second'} Semester in ${reportCard.year}',
                  percentage: 'GPA: ${reportCard.GPA}',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportCardDetailsScreen(reportCard: reportCard),
                      ),
                    );
                  },
                );
              },
            ),
          )
      ),
    );
  }
}

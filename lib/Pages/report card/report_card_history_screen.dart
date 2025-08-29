// Pages/report card/report_card_history_screen.dart
import 'package:flutter/material.dart';
import 'package:school_application/Models/report_card_model.dart';
import 'package:school_application/Pages/report%20card/report_card_details_screen.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

import '../../services/report_card_service.dart';
import '../../shared/components/constants.dart';

class ReportCardHistoryScreen extends StatefulWidget {
  const ReportCardHistoryScreen({super.key});

  @override
  State<ReportCardHistoryScreen> createState() => _ReportCardHistoryScreenState();
}

class _ReportCardHistoryScreenState extends State<ReportCardHistoryScreen> {
  late Future<List<ReportCardModel>> _scorecardsFuture;

  @override
  void initState() {
    super.initState();
    _scorecardsFuture = ScorecardService.getStudentScorecard().then((data) {
      return data.map((item) => ReportCardModel.fromMap(item)).toList();
    });
  }

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
              Text("Report Cards", style: greenHTextStyle),
            ],
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<ReportCardModel>>(
        future: _scorecardsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No report cards available'));
          }

          final reportCards = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: reportCards.length,
              itemBuilder: (context, index) {
                final reportCard = reportCards[index];
                // In the ListView.builder itemBuilder:
                return defaultReportcard(
                  header: reportCard.semesterName, // Use the actual semester name from API
                  description: 'Academic performance for this academic year',
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
          );
        },
      ),
    );
  }
}
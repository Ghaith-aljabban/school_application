import 'package:flutter/material.dart';
import 'package:school_application/models/report_card_model.dart';
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
              SizedBox(width: 20,),
              Icon(Icons.arrow_back_ios_new,color: myGreen,size: 35,),
              Text("Report Cards",style: greenHTextStyle,)
            ],
          ), // ← Your custom icon
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
              itemCount: ghaithReportCards.length,
              itemBuilder:(context, index) {
                return defaultReportcard(header: ghaithReportCards[index].grade + (ghaithReportCards[index].isFirstSemister?' first semester':' second semester'),
                  description: 'Student report card in the second Semester in 2024 ',
                  percentage: 'GPA: ${ghaithReportCards[index].GPA}',);
              }),
          )
      ),
    );
  }
}

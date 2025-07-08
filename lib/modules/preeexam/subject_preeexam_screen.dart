import 'package:flutter/material.dart';

import '../../models/previous_exams_model.dart';
import '../../shared/components/components.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class SubjectPreeexamScreen extends StatelessWidget {
  final String name;
  const SubjectPreeexamScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              SizedBox(width: 20,),
              Icon(Icons.arrow_back_ios_new,color: myGreen,size: 35,),
              Text("Preeexam",style: greenHTextStyle,)
            ],
          ), // ← Your custom icon
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: ListView.builder(
        itemCount: subjectPreviousExams.length * 2, // Added one more for the name at top
        itemBuilder: (context, index) {
          if (index == 0) {
            // First item: display the name
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(name, style: greenHTextStyle),
            );
          }

          final adjustedIndex = index - 1;

          if (adjustedIndex.isEven) {
            final dataIndex = adjustedIndex ~/ 2;
            return itemOfList(data: subjectPreviousExams[dataIndex].date);
          } else {
            return Container(
              width: double.infinity,
              height: 1.0,
              color: myLightGray,
            );
          }
        },
      ),

    );
  }
}

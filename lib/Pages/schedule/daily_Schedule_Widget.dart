// daily_Schedule_Widget.dart
import 'package:flutter/material.dart';
import 'package:school_application/shared/network/styles/colors.dart';
import 'package:school_application/shared/network/styles/styles.dart';

import '../../Models/daily_schedule_model.dart';

Widget DailyScheduleWidget({required SubjectTime subject}) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(width: 10),
    Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              subject.timeStart,
              style: flexableTextStyle(
                color: Colors.black,
                size: 14,
                isBold: true,
              ),
            ),
            Text(
              subject.timeEnd,
              style: flexableTextStyle(color: myGray, size: 12, isBold: false),
            ),
          ],
        ),
      ),
    ),
    Expanded(
      flex: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: myGreen),
                ),
              ),
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: myGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(width: 1, height: 100, color: myGreen),
          const SizedBox(height: 5),
        ],
      ),
    ),
    Expanded(
      flex: 12,
      child: Container(
        height: 50,
        width: 300,
        decoration: defaultBoxDecorated,
        child: Center(
          child: Text(
            subject.subjectName,
            style: flexableTextStyle(
              color: Colors.black,
              size: 16,
              isBold: true,
            ),
          ),
        ),
      ),
    ),
  ],
);

Widget DailyScheduleWidgetNotSelected({required SubjectTime subject}) => Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    SizedBox(width: 10),
    Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text(
              subject.timeStart,
              style: flexableTextStyle(
                color: Colors.black,
                size: 14,
                isBold: true,
              ),
            ),
            Text(
              subject.timeEnd,
              style: flexableTextStyle(color: myGray, size: 12, isBold: false),
            ),
          ],
        ),
      ),
    ),
    Expanded(
      flex: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(height: 25, width: 25),
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: myLime),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(width: 1, height: 100, color: myLime),
          const SizedBox(height: 5),
        ],
      ),
    ),
    Expanded(
      flex: 12,
      child: Container(
        height: 50,
        width: 300,
        decoration: defaultBoxDecorated2,
        child: Center(
          child: Text(
            subject.subjectName,
            style: flexableTextStyle(
              color: Colors.black,
              size: 16,
              isBold: false,
            ),
          ),
        ),
      ),
    ),
  ],
);

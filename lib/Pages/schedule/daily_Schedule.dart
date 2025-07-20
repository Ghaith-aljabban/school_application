// daily_Schedule.dart
import 'package:flutter/material.dart';
import 'package:school_application/Pages/schedule/daily_Schedule_Widget.dart';

import '../../Models/daily_schedule_model.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class DailySchedule extends StatefulWidget {
  @override
  _DailyScheduleState createState() => _DailyScheduleState();
}

class _DailyScheduleState extends State<DailySchedule> {
  int selectedDayIndex = 0; // Default to first day in demoData
  Map<int, int> selectedSubjectIndex = {}; // Track selected subject per day

  @override
  void initState() {
    super.initState();
    // Initialize with first subject selected for each day
    for (int i = 0; i < demoData.length; i++) {
      selectedSubjectIndex[i] = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    dailySubject selectedDay = demoData[selectedDayIndex];
    int currentSelectedSubject = selectedSubjectIndex[selectedDayIndex] ?? 0;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Daily Schedule", style: greenHTextStyle),
            ],
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: demoData.length,
                  itemBuilder: (context, index) {
                    final day = demoData[index];
                    final isSelected = index == selectedDayIndex;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              day.weekDay.substring(0, 3), // Show short day
                              style: flexableTextStyle(
                                color: isSelected ? myGreen : Colors.black,
                                size: 14,
                                isBold: isSelected,
                              ),
                            ),
                            Text(
                              day.dateInMonth,
                              style: flexableTextStyle(
                                color: isSelected ? myGreen : myGray,
                                size: 12,
                                isBold: isSelected,
                              ),
                            ),
                            if (isSelected)
                              Container(
                                margin: EdgeInsets.only(top: 8),
                                height: 3,
                                width: 30,
                                color: myGreen,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
              // Subjects list
              ...selectedDay.subject.asMap().entries.map((entry) {
                final index = entry.key;
                final subject = entry.value;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSubjectIndex[selectedDayIndex] = index;
                    });
                  },
                  child: index == currentSelectedSubject
                      ? DailyScheduleWidget(subject: subject)
                      : DailyScheduleWidgetNotSelected(subject: subject),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}

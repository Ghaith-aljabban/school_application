// daily_Schedule.dart
import 'package:flutter/material.dart';
import 'package:school_application/Pages/schedule/daily_Schedule_Widget.dart';
import 'package:school_application/services/schedule_service.dart';

import '../../Models/daily_schedule_model.dart';
import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class DailySchedule extends StatefulWidget {
  @override
  _DailyScheduleState createState() => _DailyScheduleState();
}

class _DailyScheduleState extends State<DailySchedule> {
  int selectedDayIndex = 0;
  Map<int, int> selectedSubjectIndex = {};

  @override
  void initState() {
    super.initState();
    selectedSubjectIndex = {};
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<List<DailySubject>>(
        future: ScheduleService.fetchSchedule(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: myGreen));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading schedule'));
          }

          final scheduleData = snapshot.data ?? [];

          if (scheduleData.isEmpty) {
            return Center(child: Text('No schedule available'));
          }

          // Initialize selected indices for days
          for (int i = 0; i < scheduleData.length; i++) {
            selectedSubjectIndex.putIfAbsent(i, () => 0);
          }

          return _buildScheduleBody(scheduleData);
        },
      ),
    );
  }

  Widget _buildScheduleBody(List<DailySubject> scheduleData) {
    final selectedDay = scheduleData[selectedDayIndex];
    final currentSelectedSubject = selectedSubjectIndex[selectedDayIndex] ?? 0;

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: scheduleData.length,
                itemBuilder: (context, index) {
                  final day = scheduleData[index];
                  final isSelected = index == selectedDayIndex;
                  final dayName = day.dayName;
                  final shortDay = dayName.length > 3
                      ? dayName.substring(0, 3)
                      : dayName;

                  return GestureDetector(
                    onTap: () => setState(() => selectedDayIndex = index),
                    child: Container(
                      width: 70,
                      height: 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            shortDay,
                            style: flexableTextStyle(
                              color: isSelected ? myGreen : Colors.black,
                              size: 14,
                              isBold: isSelected,
                            ),
                          ),
                          // Date removed since not in API
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
            ...selectedDay.subjects.asMap().entries.map((entry) {
              final index = entry.key;
              final subject = entry.value;

              return GestureDetector(
                onTap: () => setState(() {
                  selectedSubjectIndex[selectedDayIndex] = index;
                }),
                child: index == currentSelectedSubject
                    ? DailyScheduleWidget(subject: subject)
                    : DailyScheduleWidgetNotSelected(subject: subject),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
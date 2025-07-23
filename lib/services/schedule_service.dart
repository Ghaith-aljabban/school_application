// schedule_service.dart
import 'package:dio/dio.dart';
import 'package:school_application/Models/daily_schedule_model.dart';
import 'package:school_application/main.dart';

class ScheduleService {
  static Future<List<DailySubject>> fetchSchedule() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        consUrl('students/schedule'),
        data: {"id": studentID},
      );

      if (response.statusCode == 200) {
        return _parseScheduleData(response.data);
      } else {
        throw Exception('Failed to load schedule');
      }
    } catch (e) {
      throw Exception('Schedule loading error: $e');
    }
  }

  static List<DailySubject> _parseScheduleData(List<dynamic> data) {
    return data.map((day) {
      return DailySubject(
        dayName: day['day_name'],
        subjects: (day['subjects'] as List).map((subject) {
          return SubjectTime(
            subjectName: subject['subject_name'],
            timeStart: _formatTime(subject['start_time']),
            timeEnd: _formatTime(subject['end_time']),
          );
        }).toList(),
      );
    }).toList();
  }

  static String _formatTime(String time24) {
    final parts = time24.split(':');
    int hour = int.parse(parts[0]);
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;
    return '$hour:$minute$period';
  }
}
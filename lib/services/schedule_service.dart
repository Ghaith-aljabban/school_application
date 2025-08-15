// schedule_service.dart
import 'package:dio/dio.dart';
import 'package:school_application/Models/daily_schedule_model.dart';
import 'package:school_application/main.dart';

class ScheduleService {
  static Future<List<DailySubject>> fetchSchedule() async {
    try {
      final dio = Dio();
      final response = await dio.get(consUrl('students/schedule'),
        options: Options(headers: {'Authorization': 'Bearer $token'}),);

      if (response.statusCode == 200) {
        // Handle both single day and multiple days cases
        if (response.data is List) {
          return _parseScheduleData(response.data);
        } else {
          // Wrap single day in a list
          return _parseScheduleData([response.data]);
        }
      } else {
        throw Exception('Failed to load schedule: Status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  static List<DailySubject> _parseScheduleData(List<dynamic> data) {
    try {
      return data.map((day) {
        return DailySubject(
          dayName: day['day_name'] ?? 'Unknown day',
          subjects: (day['subjects'] as List?)?.map((subject) {
            return SubjectTime(
              subjectName: subject['subject_name'] ?? 'Unknown subject',
              timeStart: _formatTime(subject['start_time'] ?? '00:00:00'),
              timeEnd: _formatTime(subject['end_time'] ?? '00:00:00'),
            );
          }).toList() ?? [],
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to parse schedule data: $e');
    }
  }

  static String _formatTime(String time24) {
    try {
      final parts = time24.split(':');
      int hour = int.parse(parts[0]);
      final minute = parts[1];
      final period = hour >= 12 ? 'PM' : 'AM';
      hour = hour % 12;
      hour = hour == 0 ? 12 : hour;
      return '$hour:$minute$period';
    } catch (e) {
      return time24; // Return original if formatting fails
    }
  }
}
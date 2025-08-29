// services/scorecard_service.dart
import 'package:dio/dio.dart';
import 'package:school_application/main.dart';

class ScorecardService {
  static final Dio _dio = Dio();

  static Future<List<dynamic>> getStudentScorecard() async {
    try {
      final response = await _dio.get(
        consUrl('students/scorecard'),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to load scorecard: $e');
    }
  }
}
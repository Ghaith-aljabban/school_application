import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:school_application/Models/preeexam_question_model.dart';
import 'package:school_application/main.dart';

class PreeexamQuistionService {
  static final Dio _dio = Dio();

  static Future<ExamDetails> getExamQuestions(int examId) async {
    try {
      final response = await _dio.get(
        consUrl('exams/questions'),
        data: jsonEncode({'id': examId}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ExamDetails.fromMap(response.data);
      } else {
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
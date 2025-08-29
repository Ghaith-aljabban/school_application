import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:school_application/main.dart';
import 'package:school_application/Models/exam_date_model.dart';

class ExamService {


  Future<List<ExamDateModel>> getNextExams() async {
    try {
       Dio dio = Dio();
      Response response = await dio.get(
        consUrl('exams/student-nextexams'),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((exam) => ExamDateModel.fromJson(exam))
            .toList();
      } else {
        throw Exception('Failed to load exams');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
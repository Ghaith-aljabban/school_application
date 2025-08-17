// semester_service.dart
import 'package:dio/dio.dart';
import 'package:school_application/Models/semester_model.dart';
import '../main.dart'; // For consUrl and token

class PreequizzesSemestersService {
  static Future<List<Semester>> getSemestersBySubject(int subjectId) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        consUrl('exams/subject/$subjectId/quiz-semesters'),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        List<Semester> semesters = [];
        for (var item in response.data) {
          semesters.add(Semester.fromMap(item));
        }
        return semesters;
      } else {
        throw Exception('Failed to load semesters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching semesters: $e');
    }
  }
}
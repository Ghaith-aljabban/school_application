import 'package:dio/dio.dart';
import '../Models/previous_exams_model.dart';
import '../main.dart'; // For consUrl and token

class PrequizService  {
  static Future<List<Preexam>> getStudentPreexams({
    required int subjectId,
    required int semesterId,
  }) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        consUrl('exams/student-prequizzes'),
        data: {
          'subjectId': subjectId,
          'semesterId': semesterId
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),

      );
      if (response.statusCode == 200) {
        List<Preexam> preexams = [];
        for (var item in response.data) {
          preexams.add(Preexam.fromMap(item));
        }
        return preexams;
      } else {
        throw Exception('Failed to load preexams: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Enhanced error logging
      print("Dio Error:");
      print("  URL: ${e.requestOptions.uri}");
      print("  Headers: ${e.requestOptions.headers}");
      print("  Response: ${e.response?.data}");
      print("  Status: ${e.response?.statusCode}");
      rethrow;
    } catch (e) {
      print("Generic Error: $e");
      rethrow;
    }
  }
}
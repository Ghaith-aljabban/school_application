import 'package:dio/dio.dart';
import 'package:school_application/main.dart';
import '../Models/student_behavior.dart';

class BehaviorService {
  static Future<List<StudentBehavior>> getUserBehaviors(String token) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        consUrl('behaviors/me/list'),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        
        // Convert API response to StudentBehavior objects
        List<StudentBehavior> behaviors = data.map((item) {
          return StudentBehavior.fromApi(item);
        }).toList();

        return behaviors;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        print('Response status: ${e.response?.statusCode}');
      }
      return [];
    } catch (e) {
      print('Unexpected error: $e');
      return [];
    }
  }
}

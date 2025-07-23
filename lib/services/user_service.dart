import 'package:dio/dio.dart';
import 'package:school_application/main.dart';

import '../Models/user_model.dart';

class UserService {
  static Future<User?> getOne(int id, String token) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        consUrl('users/$id'),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // Parse the response data into a User object
        return User.fromMap(response.data);
      } else {
        // Handle non-200 status codes
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      print('Dio error: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        print('Response status: ${e.response?.statusCode}');
      }
      return null;
    } catch (e) {
      // Handle other errors
      print('Unexpected error: $e');
      return null;
    }
  }
}
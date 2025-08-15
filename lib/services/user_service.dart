import 'package:dio/dio.dart';
import 'package:school_application/main.dart';

import '../Models/user_model.dart';

class UserService {
  static Future<User?> getOne(int id, String token) async {
    final dio = Dio();

    try {
      final response = await dio.get(
        consUrl('users/current-user'),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // Parse the response data - the API returns a nested structure with "user" array
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('user') &&
            responseData['user'] is List &&
            (responseData['user'] as List).isNotEmpty) {

          // Get the first user object from the array
          final userData = (responseData['user'] as List)[0] as Map<String, dynamic>;

          return User.fromMap(userData);
        } else {
          print('Invalid response format');
          return null;
        }
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const String _tokenKey = 'user_token';
  static const String _studentIdKey = 'student_id';
  static const String _isFirstTimeKey = 'is_first_time';

  // Save token and student ID
  static Future<void> saveUserData({required String token, required int studentId}) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _studentIdKey, value: studentId.toString());
  }

  // Get token
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Get student ID
  static Future<int?> getStudentId() async {
    final studentIdString = await _storage.read(key: _studentIdKey);
    if (studentIdString == null) {
      return null;
    }
    return int.tryParse(studentIdString);
  }

  // Check if user is logged in (has both token and student ID)
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    final studentId = await getStudentId();
    return token != null && studentId != null;
  }

  // Check if this is the first time opening the app
  static Future<bool> isFirstTime() async {
    final isFirstTime = await _storage.read(key: _isFirstTimeKey);
    return isFirstTime == null ? true : (isFirstTime.toLowerCase() == 'true');
  }

  // Set first time flag to false
  static Future<void> setNotFirstTime() async {
    await _storage.write(key: _isFirstTimeKey, value: 'false');
  }

  // Clear all user data (for logout)
  static Future<void> clearUserData() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _studentIdKey);
  }

  // Initialize global variables from secure storage
  static Future<void> initializeGlobalVariables() async {
    final token = await getToken();
    final studentId = await getStudentId();

    // Import your main.dart globals here and set them
    // This will be called from main.dart
    if (token != null && studentId != null) {
      // Set your global variables here
      // token = token;
      // studentID = studentId;
    }
  }
}

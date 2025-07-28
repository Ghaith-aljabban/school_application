import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static const String _tokenKey = 'user_token';
  static const String _studentIdKey = 'student_id';
  static const String _isFirstTimeKey = 'is_first_time';

  // Save token and student ID
  static Future<void> saveUserData({required String token, required int studentId}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_studentIdKey, studentId);
  }

  // Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Get student ID
  static Future<int?> getStudentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_studentIdKey);
  }

  // Check if user is logged in (has both token and student ID)
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final studentId = prefs.getInt(_studentIdKey);
    return token != null && studentId != null;
  }

  // Check if this is the first time opening the app
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstTimeKey) ?? true;
  }

  // Set first time flag to false
  static Future<void> setNotFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstTimeKey, false);
  }

  // Clear all user data (for logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_studentIdKey);
  }

  // Initialize global variables from SharedPreferences
  static Future<void> initializeGlobalVariables() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final studentId = prefs.getInt(_studentIdKey);

    // Import your main.dart globals here and set them
    // This will be called from main.dart
    if (token != null && studentId != null) {
      // Set your global variables here
      // token = token;
      // studentID = studentId;
    }
  }
}
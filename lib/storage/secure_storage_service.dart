import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Models/subjects_model.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const String _tokenKey = 'user_token';
  static const String _studentIdKey = 'student_id';
  static const String _isFirstTimeKey = 'is_first_time';
  static const String _keySubjects = 'subjects';

  static Future<void> saveUserData({
    required String token,
    required int studentId,
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _studentIdKey, value: studentId.toString());
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<int?> getStudentId() async {
    final studentIdString = await _storage.read(key: _studentIdKey);
    return studentIdString != null ? int.tryParse(studentIdString) : null;
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    final studentId = await getStudentId();
    return token != null && studentId != null;
  }

  static Future<bool> isFirstTime() async {
    final isFirstTime = await _storage.read(key: _isFirstTimeKey);
    return isFirstTime == null || isFirstTime.toLowerCase() == 'true';
  }

  static Future<void> setNotFirstTime() async {
    await _storage.write(key: _isFirstTimeKey, value: 'false');
  }

  static Future<void> clearUserData() async {
    await Future.wait([
      _storage.delete(key: _tokenKey),
      _storage.delete(key: _studentIdKey),
      _storage.delete(key: _keySubjects),
    ]);
  }

// secure_storage_service.dart
  static Future<void> saveSubjects(List<SubjectsModel> subjects) async {
    final subjectsJson = json.encode(subjects.map((subject) => {
      'id': subject.id,
      'name': subject.name,
    }).toList());

    await _storage.write(key: _keySubjects, value: subjectsJson);
  }

  static Future<List<SubjectsModel>> getSubjects() async {
    final subjectsString = await _storage.read(key: _keySubjects);
    if (subjectsString == null) return [];

    try {
      final List<dynamic> data = json.decode(subjectsString);
      return data.map((item) => SubjectsModel.fromMap(item)).toList();
    } catch (e) {
      print('Error decoding subjects: $e');
      return [];
    }
  }

  static Future<void> initializeGlobalVariables() async {
    final token = await getToken();
    final studentId = await getStudentId();

    if (token != null && studentId != null) {
      // Set your global variables here if needed
      // token = token;
      // studentID = studentId;
    }
  }
}
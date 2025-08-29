import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:school_application/main.dart';
import 'package:school_application/storage/secure_storage_service.dart';
import 'package:school_application/services/firebase_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../Models/auth_model.dart';
import '../Models/user_model.dart';

class AuthService {
  static Future<Map<String, dynamic>> login({required AuthModel authModel}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(consUrl('users/signin'),
        data: authModel.toMap(),
      );
      if (response.statusCode == 200) {
        // Set global variables
        token = response.data['token'];
        studentID = response.data['user']["id"];

        // Save to SharedPreferences
        await SecureStorageService.saveUserData(
          token: response.data['token'],
          studentId: response.data['user']["id"],
        );

        // After login, (re)fetch and register FCM token with backend
        try {
          final fcmToken = await FirebaseMessaging.instance.getToken();
          if (fcmToken != null && fcmToken.isNotEmpty) {
            await FirebaseService.registerFcmToken(
              fcmToken: fcmToken,
              deviceType: 'mobile',
            );
          }
        } catch (_) {}

        // Check user role from response
        String userRole = response.data['user']['role'] ?? 
                         response.data['user']['user_type'] ?? 
                         response.data['user']['type'] ?? 
                         response.data['user_type'] ?? 
                         'unknown';

        return {
          'success': true,
          'role': userRole,
          'message': 'Login successful'
        };
      } else {
        return {
          'success': false,
          'message': 'Login failed'
        };
      }
    } catch (e) {
      print(e);
      return {
        'success': false,
        'message': 'Network error or invalid credentials'
      };
    }
  }
}
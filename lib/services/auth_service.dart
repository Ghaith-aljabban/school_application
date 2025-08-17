import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:school_application/main.dart';
import 'package:school_application/storage/secure_storage_service.dart';
import '../Models/auth_model.dart';
import '../Models/user_model.dart';

class AuthService {
  static Future<bool?> login({required AuthModel authModel}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(consUrl('users/signin'),
        data: authModel.toMap(),
      );
      print(response.data  );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Set global variables
        token = response.data['token'];
        studentID = response.data['user']["id"];

        // Save to SharedPreferences
        await SecureStorageService.saveUserData(
          token: response.data['token'],
          studentId: response.data['user']["id"],
        );

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
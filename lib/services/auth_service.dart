
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:school_application/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/auth_model.dart';
import '../Models/user_model.dart';

class AuthService
{
  static Future<bool?> login({required AuthModel authModel}) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(consUrl('users/signin'),
        data: authModel.toMap(),
      );
      if (response.statusCode == 200) {
        token = response.data['token'];
        studentID = response.data['user']["id"];

        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('token', response.data['token']);
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
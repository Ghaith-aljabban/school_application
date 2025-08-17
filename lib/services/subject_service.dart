// services/subject_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:school_application/storage/secure_storage_service.dart';

import '../Models/subjects_model.dart';
import '../main.dart';

// subject_service.dart
class SubjectService {
  static Future<List<SubjectsModel>> getSubjects() async {
    Dio dio = Dio();

     token = (await SecureStorageService.getToken())!;

    Response response = await dio.get(consUrl('students/subjects'),
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200) {
      List<SubjectsModel> subjects = [];
      for (var i = 0; i < response.data!.length; i++) {
        subjects.add(SubjectsModel.fromMap(response.data![i]));
      }


      return subjects;
    } else {
      throw Exception('Failed to load subjects: ${response.statusCode}');
    }
  }
}
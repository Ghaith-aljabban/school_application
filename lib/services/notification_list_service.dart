// notification_service.dart
import 'package:dio/dio.dart';
import 'package:school_application/main.dart';
import 'package:school_application/Models/notification_model.dart';

class NotificationListService {
  final Dio _dio = Dio();

  Future<List<Notification>> getNotifications() async {
    try {
      final response = await _dio.get(consUrl('notifications'),options: Options(headers: {
          'Authorization': 'Bearer $token',
          }));
      print(response);
      if (response.statusCode == 200) {
        List<Notification> notifications = (response.data as List)
            .map((item) => Notification.fromMap(item))
            .toList();
        return notifications;
      } else {
        throw Exception('Failed to load notifications');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load notifications: ${e.message}');
    }
  }
}
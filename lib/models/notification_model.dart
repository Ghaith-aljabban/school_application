// notification_model.dart
class Notification {
  int id;
  int userId;
  String title;
  String body;
  bool isRead;
  String sentAt;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.sentAt,
  });

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      body: map['body'],
      isRead: map['is_read'],
      sentAt: map['sent_at'],
    );
  }
}
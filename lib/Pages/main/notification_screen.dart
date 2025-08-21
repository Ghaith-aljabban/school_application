// notification_screen.dart
import 'package:flutter/material.dart' hide Notification;
import 'package:school_application/Models/notification_model.dart';
import 'package:school_application/shared/components/components.dart';
import 'package:school_application/services/notification_list_service.dart';

import '../../shared/network/styles/colors.dart';
import '../../shared/network/styles/styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationService _notificationService = NotificationService();
  late Future<List<Notification>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  // Separate method to load notifications for refresh functionality
  void _loadNotifications() {
    setState(() {
      _notificationsFuture = _notificationService.getNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: GestureDetector(
          child: Row(
            children: [
              const SizedBox(width: 20),
              Icon(Icons.arrow_back_ios_new, color: myGreen, size: 35),
              Text("Notification", style: greenHTextStyle),
            ],
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: RefreshIndicator(
          onRefresh: () async {
            // Refresh the notifications when pulled down
            _loadNotifications();
            // Wait a moment to show the refresh animation
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: FutureBuilder<List<Notification>>(
            future: _notificationsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('No notifications available'),
                );
              } else {
                final notifications = snapshot.data!;
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        notificationCard(
                          title: notifications[index].title,
                          description: notifications[index].body,
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
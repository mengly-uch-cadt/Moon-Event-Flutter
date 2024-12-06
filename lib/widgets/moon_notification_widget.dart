import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonNotificationWidget extends StatelessWidget {
  const MoonNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of notifications
    final notifications = [
      NotificationData(
        title: 'Tech Conference 2024',
        description: 'Join us for an exciting tech conference!',
        sendTime: '2024-12-06 10:00 AM',
      ),
      NotificationData(
        title: 'Music Festival 2024',
        description: 'A grand music festival with various artists.',
        sendTime: '2024-12-05 03:00 PM',
      ),
      NotificationData(
        title: 'Startup Pitch Event',
        description: 'Pitch your ideas to investors at the Startup event.',
        sendTime: '2024-12-07 09:30 AM',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "notifications", secondTitle: ""),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: NotificationTile(
              title: notification.title,
              description: notification.description,
              sendTime: notification.sendTime,
            ),
          );
        },
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String description;
  final String sendTime;

  const NotificationTile({
    required this.title,
    required this.description,
    required this.sendTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          
        ],
      ),
      trailing: Text(sendTime),
    );
  }
}


class NotificationData {
  final String title;
  final String description;
  final String sendTime;

  NotificationData({
    required this.title,
    required this.description,
    required this.sendTime,
  });
}

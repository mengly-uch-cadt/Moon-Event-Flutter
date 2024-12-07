import 'dart:math'; // Import Random for generating random numbers
import 'package:flutter/material.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonPlanEventWidget extends StatelessWidget {
  MoonPlanEventWidget({super.key});

  // Static event data (using your static data)
  final List<Map<String, dynamic>> events = [
    {
      'imageUrl': '1',
      'title': 'Tech Conference 2024',
      'description': 'A conference about the latest in technology.',
      'date': DateTime.now().add(Duration(days: Random().nextInt(30))),
      'time': TimeOfDay(hour: 2, minute: 50),
      'category': 'Technology',
      'numberUsers': 0,
    },
    {
      'imageUrl': '2',
      'title': 'Music Festival 2024',
      'description': 'A festival showcasing various artists.',
      'date': DateTime.now().add(Duration(days: Random().nextInt(30))),
      'time': TimeOfDay(hour: 3, minute: 30),
      'category': 'Music',
      'numberUsers': 0,
    },
    {
      'imageUrl': '3',
      'title': 'Sports Meetup 2024',
      'description': 'Join us for a day of sports activities.',
      'date': DateTime.now().add(Duration(days: Random().nextInt(30))),
      'time': TimeOfDay(hour: 5, minute: 0),
      'category': 'Sports',
      'numberUsers': 0,
    },
    {
      'imageUrl': '4',
      'title': 'Art Exhibition 2024',
      'description': 'Explore the world of contemporary art.',
      'date': DateTime.now().add(Duration(days: Random().nextInt(30))),
      'time': TimeOfDay(hour: 11, minute: 15),
      'category': 'Art',
      'numberUsers': 0,
    },
    {
      'imageUrl': '5',
      'title': 'Startup Pitch Event 2024',
      'description': 'Presenting innovative startup ideas.',
      'date': DateTime.now().add(Duration(days: Random().nextInt(30))),
      'time': TimeOfDay(hour: 10, minute: 0),
      'category': 'Business',
      'numberUsers': 0,
    },
    {
      'imageUrl': '6',
      'title': 'Cooking Class 2024',
      'description': 'Learn to cook new and exciting dishes.',
      'date': DateTime.now().add(Duration(days: Random().nextInt(30))),
      'time': TimeOfDay(hour: 1, minute: 30),
      'category': 'Cooking',
      'numberUsers': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MoonTitleWidget(firstTitle: "Plan", secondTitle: "Events"),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Calendar",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          shrinkWrap: true, // Prevent the GridView from taking up all available space
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Display two cards per row
            childAspectRatio: 0.60, // Adjust this ratio to fit your card size
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return MoonEventCardWidget(
              imageUrl: event['imageUrl'],
              title: event['title'],
              description: event['description'],
              date: event['date'],
              time: event['time'],
              category: event['category'],
              numberParticipants: event['numberUsers'],
            );
          },
        ),
      ),
    );
  }
}

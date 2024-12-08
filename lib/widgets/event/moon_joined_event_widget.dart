// import 'dart:math'; // Import Random for generating random numbers
// import 'package:flutter/material.dart';
// import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
// import 'package:moon_event/widgets/moon_title_widget.dart';

// class MoonJoinedEventWidget extends StatelessWidget {
//   MoonJoinedEventWidget({super.key});

//  // Static event data (using your static data)
//   final List<Map<String, dynamic>> events = [
//     {
//       'imageUrl': '1',
//       'title': 'Tech Conference 2024',
//       'description': 'A conference about the latest in technology.',
//       'date': "12-11-2024",
//       'time': "2:50 AM",
//       'category': 'Technology',
//       'numberUsers': 0,
//     },
//     {
//       'imageUrl': '2',
//       'title': 'Music Festival 2024',
//       'description': 'A festival showcasing various artists.',
//       'date': "12-11-2024",
//       'time': "2:50 AM",
//       'category': 'Music',
//       'numberUsers': 0,
//     },
//     {
//       'imageUrl': '3',
//       'title': 'Sports Meetup 2024',
//       'description': 'Join us for a day of sports activities.',
//       'date': "12-11-2024",
//       'time': "2:50 AM",
//       'category': 'Sports',
//       'numberUsers': 0,
//     },
//     {
//       'imageUrl': '4',
//       'title': 'Art Exhibition 2024',
//       'description': 'Explore the world of contemporary art.',
//       'date': "12-11-2024",
//       'time': "2:50 AM",
//       'category': 'Art',
//       'numberUsers': 0,
//     },
//     {
//       'imageUrl': '5',
//       'title': 'Startup Pitch Event 2024',
//       'description': 'Presenting innovative startup ideas.',
//       'date': "12-11-2024",
//       'time': "2:50 AM",
//       'category': 'Business',
//       'numberUsers': 0,
//     },
//     {
//       'imageUrl': '6',
//       'title': 'Cooking Class 2024',
//       'description': 'Learn to cook new and exciting dishes.',
//       'date': "12-11-2024",
//       'time': "2:50 AM",
//       'category': 'Cooking',
//       'numberUsers': 0,
//     },
//   ];

//  @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const MoonTitleWidget(firstTitle: "Joined", secondTitle: "Events"),
//         actions: [
//           TextButton(
//             onPressed: () {},
//             child: Text(
//               "Calendar",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: GridView.builder(
//           shrinkWrap: true, // Prevent the GridView from taking up all available space
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Display two cards per row
//             childAspectRatio: 0.60, // Adjust this ratio to fit your card size
//           ),
//           itemCount: events.length,
//           itemBuilder: (context, index) {
//             final event = events[index];
//             return MoonEventCardWidget(
//               imageUrl: event['imageUrl'],
//               title: event['title'],
//               description: event['description'],
//               date: event['date'],
//               time: event['time'],
//               category: event['category'],
//               numberParticipants: event['numberUsers'], 
//               location: '',
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MoonJoinedEventWidget extends StatelessWidget {
  const MoonJoinedEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Joined Events'),
      ),
      body: const Center(
        child: Text('Joined Events'),
      ),
    );
  }
}

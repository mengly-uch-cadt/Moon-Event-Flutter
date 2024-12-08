// import 'dart:math'; // Import Random for generating random numbers
// import 'package:flutter/material.dart';
// import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
// import 'package:moon_event/widgets/moon_title_widget.dart';

// class MoonPlanEventWidget extends StatelessWidget {
//   MoonPlanEventWidget({super.key});

//  final List<Map<String, dynamic>> events = [
//   {
//     'imageUrl': '1',
//     'title': 'Tech Conference 2024',
//     'description': 'A conference about the latest in technology.',
//     'date': DateTime(2024, 12, 11).millisecondsSinceEpoch,
//     'time': "2:50 AM",
//     'category': 'Technology',
//     'location': 'San Francisco, CA',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '2',
//     'title': 'Music Festival 2024',
//     'description': 'A festival showcasing various artists.',
//     'date': DateTime(2024, 12, 15).millisecondsSinceEpoch,
//     'time': "5:30 PM",
//     'category': 'Music',
//     'location': 'Los Angeles, CA',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '3',
//     'title': 'Sports Meetup 2024',
//     'description': 'Join us for a day of sports activities.',
//     'date': DateTime(2024, 12, 18).millisecondsSinceEpoch,
//     'time': "9:00 AM",
//     'category': 'Sports',
//     'location': 'Chicago, IL',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '4',
//     'title': 'Art Exhibition 2024',
//     'description': 'Explore the world of contemporary art.',
//     'date': DateTime(2024, 12, 20).millisecondsSinceEpoch,
//     'time': "1:00 PM",
//     'category': 'Art',
//     'location': 'New York, NY',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '5',
//     'title': 'Startup Pitch Event 2024',
//     'description': 'Presenting innovative startup ideas.',
//     'date': DateTime(2024, 12, 22).millisecondsSinceEpoch,
//     'time': "10:00 AM",
//     'category': 'Business',
//     'location': 'Austin, TX',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '6',
//     'title': 'Cooking Class 2024',
//     'description': 'Learn to cook new and exciting dishes.',
//     'date': DateTime(2024, 12, 25).millisecondsSinceEpoch,
//     'time': "4:00 PM",
//     'category': 'Cooking',
//     'location': 'Seattle, WA',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '7',
//     'title': 'Fitness Bootcamp 2024',
//     'description': 'A high-energy fitness event for everyone.',
//     'date': DateTime(2024, 12, 27).millisecondsSinceEpoch,
//     'time': "6:00 AM",
//     'category': 'Fitness',
//     'location': 'Phoenix, AZ',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '8',
//     'title': 'Photography Workshop 2024',
//     'description': 'Master photography techniques from experts.',
//     'date': DateTime(2024, 12, 29).millisecondsSinceEpoch,
//     'time': "11:00 AM",
//     'category': 'Photography',
//     'location': 'Denver, CO',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '9',
//     'title': 'Gaming Expo 2024',
//     'description': 'Showcasing the latest in gaming technology.',
//     'date': DateTime(2024, 12, 30).millisecondsSinceEpoch,
//     'time': "3:00 PM",
//     'category': 'Gaming',
//     'location': 'Las Vegas, NV',
//     'numberUsers': 0,
//   },
//   {
//     'imageUrl': '10',
//     'title': 'Charity Gala 2024',
//     'description': 'An evening to support and celebrate good causes.',
//     'date': DateTime(2024, 12, 31).millisecondsSinceEpoch,
//     'time': "7:00 PM",
//     'category': 'Charity',
//     'location': 'Washington, D.C.',
//     'numberUsers': 0,
//   },
// ];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const MoonTitleWidget(firstTitle: "Plan", secondTitle: "Events"),
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
//               category: ,
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

class MoonPlanEventWidget extends StatelessWidget {
  const MoonPlanEventWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Events'),
      ),
      body: const Center(
        child: Text('Plan Events'),
      ),
    );
  }
}
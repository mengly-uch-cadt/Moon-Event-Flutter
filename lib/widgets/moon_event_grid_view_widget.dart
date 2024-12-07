// import 'package:flutter/material.dart';

// class MoonEventGridViewWidget extends StatelessWidget {
//   const MoonEventGridViewWidget({super.key});
//   Get

//   @override
//   Widget build(BuildContext context) {
//     return  GridView.builder(
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
//             );
//           },
//         );
//   }
// }
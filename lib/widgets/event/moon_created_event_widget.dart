// import 'dart:math'; // Import Random for generating random numbers
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:moon_event/state/user_state.dart';
// import 'package:moon_event/theme.dart';
// import 'package:moon_event/widgets/event/moon_created_event_form_widget.dart';
// import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
// import 'package:moon_event/widgets/moon_alert_widget.dart';
// import 'package:moon_event/widgets/moon_title_widget.dart';

// class MoonCreatedEventWidget extends ConsumerStatefulWidget {
//   MoonCreatedEventWidget({super.key});

//   @override
//   ConsumerState<MoonCreatedEventWidget> createState() => _MoonCreatedEventWidgetState();
// }

// class _MoonCreatedEventWidgetState extends ConsumerState<MoonCreatedEventWidget> {
//   final ScrollController _scrollController = ScrollController();
//   bool _isBottom = false; // Track if the scroll is at the bottom

//   // Static event data (using your static data)
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

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       final isBottom = _scrollController.offset >= _scrollController.position.maxScrollExtent;
//       if (isBottom != _isBottom) {
//         setState(() {
//           _isBottom = isBottom;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const MoonTitleWidget(firstTitle: "Created", secondTitle: "Events"),
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
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: GridView.builder(
//               controller: _scrollController,
//               shrinkWrap: true, // Prevent the GridView from taking up all available space
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Display two cards per row
//                 childAspectRatio: 0.60, // Adjust this ratio to fit your card size
//               ),
//               itemCount: events.length,
//               itemBuilder: (context, index) {
//                 final event = events[index];
//                 return MoonEventCardWidget(
//                   imageUrl: event['imageUrl'],
//                   title: event['title'],
//                   description: event['description'],
//                   date: event['date'],
//                   time: event['time'],
//                   category: event['category'],
//                   numberParticipants: event['numberUsers'],
//                 );
//               },
//             ),
//           ),
//           if (!_isBottom) // Show the FAB only if not at the bottom
//             Positioned(
//               bottom: 16.0, // Adjust the vertical position
//               right: 16.0, // Adjust the horizontal position
//                 child: FloatingActionButton(
//                 onPressed: () {
//                   if (ref.read(userProvider) == null) {
//                     showDialog(context: context, builder: (ctx) => 
//                       const MoonAlertWidget(
//                         icon: Icons.error_outline,
//                         title: 'Error',
//                         description: 'Please log in to create an event.',
//                         typeError: true,
//                       ));
//                     return;
//                   }
//                   showDialog(
//                     context: context, 
//                     builder: (ctx)=> MoonCreatedEventFormWidget(),
//                   );
//                 },
//                 backgroundColor: AppColors.primary, // Set the background color
//                 focusColor: AppColors.primary,
//                 tooltip: 'Create New Event',
//                 child: Icon(Icons.add, color: AppColors.white,),
//                 ),
//               ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';

class MoonEventGridViewWidget extends StatelessWidget {
  const MoonEventGridViewWidget({super.key, required this.events, ScrollController? scrollController})
      : _scrollController = scrollController; // Assign the ScrollController to the private variable
  
  final List<GetEvent> events;
  final ScrollController? _scrollController; // Make it nullable

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController, // ScrollController is now nullable
      shrinkWrap: true, // Prevent the GridView from taking up all available space
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Display two cards per row
        childAspectRatio: 0.78, // Adjust this ratio to fit your card size
      ),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return MoonEventCardWidget(
          imageUrl: event.imageUrl,
          title: event.title,
          description: event.description,
          location: event.location,
          date: event.date,
          time: event.time,
          numberParticipants: event.participants.length,
          category: event.category,
        );
      },
    );
  }
}

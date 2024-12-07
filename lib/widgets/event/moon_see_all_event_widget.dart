import 'package:flutter/material.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonSeeAllEventWidget extends StatelessWidget {
  const MoonSeeAllEventWidget({super.key, required this.events, required this.moonTitleWidget});
  final List<GetEvent> events;
  final MoonTitleWidget moonTitleWidget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: moonTitleWidget,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: GridView.builder(
          shrinkWrap: true, // Prevent the GridView from taking up all available space
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Display two cards per row
            childAspectRatio: 0.58, // Adjust this ratio to fit your card size
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
              numberParticipants: 0,
              category: event.category,
            );
          },
        ),
      ),
    );
  }
}
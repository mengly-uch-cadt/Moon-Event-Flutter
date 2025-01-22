import 'package:flutter/material.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/utils/half_screen_util.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:moon_event/widgets/event/moon_event_details_widget.dart';

class MoonEventListWidget extends StatelessWidget {
  const MoonEventListWidget({super.key, required this.events});
  final List<GetEvent> events;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: events.map((event) {
          return SizedBox(
            width: halfScreen(context),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => MoonEventDetailsWidget(event: event)
                  )
                );
              },
              child: MoonEventCardWidget(
                event: event,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


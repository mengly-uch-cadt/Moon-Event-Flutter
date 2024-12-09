import 'package:flutter/material.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/widgets/event/moon_event_grid_view_widget.dart';
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
        child: MoonEventGridViewWidget(events: events)
      ),
    );
  }
}
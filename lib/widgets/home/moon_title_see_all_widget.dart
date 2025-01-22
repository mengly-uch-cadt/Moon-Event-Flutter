import 'package:flutter/material.dart';
import 'package:moon_event/model/get_event.dart';
import 'package:moon_event/widgets/event/moon_see_all_event_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonTitleSeeAllWidget extends StatelessWidget {
  const MoonTitleSeeAllWidget({
    super.key, 
    required this.firstTitle, 
    required this.secondTitle, 
    required this.events
  });
  final String firstTitle;
  final String secondTitle;
  final List<GetEvent> events;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MoonTitleWidget(
          firstTitle: firstTitle,
          secondTitle: secondTitle,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => MoonSeeAllEventWidget(
                  events: events, 
                  moonTitleWidget: MoonTitleWidget(
                    firstTitle: firstTitle, 
                    secondTitle: secondTitle
                  ),
                )
              )
            );
          },
          child: Text(
            "See All", 
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
      ],
    );
  }
}
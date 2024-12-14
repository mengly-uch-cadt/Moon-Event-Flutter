import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/utils/half_screen_util.dart';
import 'package:moon_event/widgets/event/moon_event_card_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../model/get_event.dart';

class MoonEventAxisSkeletonizerWidget extends StatelessWidget {
  const MoonEventAxisSkeletonizerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(3, (index) {
            return SizedBox(
              width: halfScreen(context),
              child: MoonEventCardWidget(
                   event: GetEvent(
                    title: 'asdfasdfasdfas asdfasdf',
                    description:"asdfasdfasdfasdf",
                    location: 'asdfasdfasdfasdf',
                    date: Timestamp.now(),
                    startTime: 'asdfasdf',
                    endTime: 'asdfasdf',
                    category: Category(category: '', uuid: '', icon: ''),
                    imageUrl: '', 
                    eventUuid: 'asdfasdf', 
                    organizerId: 'asdfasdfasdf', 
                    participantsRegistered: [], 
                    participantsJoined: [], 
                    isPublic: false
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
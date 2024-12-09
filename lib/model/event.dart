import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_event/utils/generate_uuid_util.dart';

class Event {
  String eventUuid;
  String title;
  String description;
  DateTime  date;
  String startTime;
  String endTime;
  String location;
  String imageUrl;
  String organizerId;
  List<String> participantsWillAttend;
  List<String> participantsJoined;
  bool isPublic;
  String categoryId;
  int participantCount;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.imageUrl,
    required this.organizerId,
    required this.participantsWillAttend,
    required this.participantsJoined,
    required this.isPublic,
    required this.categoryId,
    required this.participantCount,
  }):eventUuid = generateUuid();

  // Converts an Event object into a Map
  Map<String, dynamic> toMap() {
    return {
      'eventUuid'             : eventUuid,
      'title'                 : title,
      'description'           : description,
      'date'                  : Timestamp.fromDate(date),
      'startTime'              : startTime,
      'endTime'               : endTime,
      'location'              : location,
      'imageUrl'              : imageUrl,
      'organizerId'           : organizerId,
      'participantsWillAttend': participantsWillAttend,
      'participantsJoined'    : participantsJoined,
      'isPublic'              : isPublic,
      'categoryId'            : categoryId,
      'participantCount'      : participantCount,
    };
  }
}

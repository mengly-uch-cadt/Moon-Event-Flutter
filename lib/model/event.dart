import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_event/utils/generate_uuid_util.dart';

class Event {
  String eventUuid;
  String title;
  String description;
  DateTime  date;
  String time;
  String location;
  String imageUrl;
  String organizerId;
  List<String> participants;
  bool isPublic;
  String categoryId;
  int participantCount;

  Event({
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
    required this.organizerId,
    required this.participants,
    required this.isPublic,
    required this.categoryId,
    required this.participantCount,
  }):eventUuid = generateUuid();

  // Converts an Event object into a Map
  Map<String, dynamic> toMap() {
    return {
      'eventUuid': eventUuid,
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'time': time,
      'location': location,
      'imageUrl': imageUrl,
      'organizerId': organizerId,
      'participants': participants,
      'isPublic': isPublic,
      'categoryId': categoryId,
      'participantCount': participantCount,
    };
  }
}

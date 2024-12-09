import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moon_event/model/category.dart';

class GetEvent {
  String eventUuid;
  String title;
  String description;
  Timestamp date;
  String startTime;
  String endTime;
  String location;
  String imageUrl;
  String organizerId;
  List<String> participantsWillAttend;
  List<String> participantsJoined;
  bool isPublic;
  Category category;
  int participantCount;

  GetEvent({
    required this.eventUuid,
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
    required this.category,
    required this.participantCount,
  });


  factory GetEvent.fromMap(Map<String, dynamic> data) {
    return GetEvent(
      eventUuid: data['eventUuid'],
      title: data['title'],
      description: data['description'],
      date: data['date'] as Timestamp,
      startTime: data['startTime'],
      endTime: data['endTime'],
      location: data['location'],
      imageUrl: data['imageUrl'],
      organizerId: data['organizerId'],
      participantsWillAttend: List<String>.from(data['participantsWillAttend']),
      participantsJoined: List<String>.from(data['participantsJoined']),
      isPublic: data['isPublic'],
      category: Category.fromMap(data['category'], data['category']['uuid']),
      participantCount: data['participantCount'] ?? 0,
    );
  }
}

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
  List<String> participantsRegistered;
  List<String> participantsJoined;
  bool isPublic;
  Category category;

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
    required this.participantsRegistered,
    required this.participantsJoined,
    required this.isPublic,
    required this.category,
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
      participantsRegistered: List<String>.from(data['participantsRegistered']),
      participantsJoined: List<String>.from(data['participantsJoined']),
      isPublic: data['isPublic'],
      category: Category.fromMap(data['category'], data['category']['uuid']),
    );
  }
}

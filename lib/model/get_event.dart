import 'package:moon_event/model/category.dart';

class GetEvent {
  String eventUuid;
  String title;
  String description;
  String date;
  String time;
  String location;
  String imageUrl;
  String organizerId;
  List<String> participants;
  bool isPublic;
  Category category;

  GetEvent({
    required this.eventUuid,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
    required this.organizerId,
    required this.participants,
    required this.isPublic,
    required this.category,
  });


  factory GetEvent.fromMap(Map<String, dynamic> data) {
    return GetEvent(
      eventUuid: data['eventUuid'],
      title: data['title'],
      description: data['description'],
      date: data['date'],
      time: data['time'],
      location: data['location'],
      imageUrl: data['imageUrl'],
      organizerId: data['organizerId'],
      participants: List<String>.from(data['participants']),
      isPublic: data['isPublic'],
      category: Category.fromMap(data['category'], data['category']['uuid']),
    );
  }
}

class Event {
  String? eventId;
  String title;
  String description;
  String date;
  String time;
  String location;
  String imageUrl;
  String organizerId;
  List<String> participants;
  bool isPublic;
  String category;

  Event({
    this.eventId,
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

  // Converts an Event object into a Map
  // toIso8601String is a method in Dart's DateTime class that converts a DateTime object into a string formatted in ISO 8601 standard. 
  Map<String, dynamic> toMap() {
    return {
      'eventId': eventId,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'imageUrl': imageUrl,
      'organizerId': organizerId,
      'participants': participants,
      'isPublic': isPublic,
      'category': category,
    };
  }

  // Creates an Event object from a Map
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventId: map['eventId'] as String?,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      location: map['location'] as String,
      imageUrl: map['imageUrl'] as String,
      organizerId: map['organizerId'] as String,
      participants: List<String>.from(map['participants'] ?? []),
      isPublic: map['isPublic'] as bool,
      category: map['category'] as String
    );
  }
}

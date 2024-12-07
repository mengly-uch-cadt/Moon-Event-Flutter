import 'dart:ui';

class Category {
  final String uuid;  // To store the document ID
  final String category;
  final String icon;

  Category({
    required this.uuid,
    required this.category,
    required this.icon,
  });

  // Optionally, create a factory constructor for initializing from a Firestore document
  factory Category.fromMap(Map<String, dynamic> map, String id) {
    return Category(
      uuid: id,   // Use Firestore document ID as the uuid
      category: map['category'] ?? '',
      icon: map['icon'] ?? '',
    );
  }
}

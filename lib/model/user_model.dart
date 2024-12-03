import 'dart:convert';
import 'package:uuid/uuid.dart';

class User {
  int id;
  String uuid;
  String name;
  String email;
  String password;
  String? profilePictureUrl;
  String? bio;
  int notificationsEnabled;

  User({
    required this.id,
    required this.uuid,
    required this.name,
    required this.email,
    required this.password,
    this.profilePictureUrl,
    this.bio,
    this.notificationsEnabled = 1,
  });

  // Constructor for registration, which only takes name, email, and password
  User.register({
    required this.name,
    required this.email,
    required this.password,
  })  : id = 0,
        uuid = _generateUuid(),
        profilePictureUrl = null,
        bio = null,
        notificationsEnabled = 1;
  // Generates a UUID using the uuid package
  static String _generateUuid() {
    var uuid = const Uuid();
    return uuid.v4(); // Generates a random UUID v4
  }

  // Converts a User object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'email': email,
      'password': password,
      'profile_picture_url': profilePictureUrl,
      'bio': bio,
      'notifications_enabled': notificationsEnabled,
    };
  }

  // Creates a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      uuid: map['uuid'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      profilePictureUrl: map['profile_picture_url'],
      bio: map['bio'],
      notificationsEnabled: map['notifications_enabled'] ?? 1,
    );
  }

  // Converts a User object into a JSON string
  String toJson() => json.encode(toMap());

  // Creates a User object from a JSON string
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

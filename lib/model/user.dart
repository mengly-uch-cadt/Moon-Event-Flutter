import 'dart:convert';

class User {
  String? uid;
  String firstName;
  String lastName;
  String email;
  String? profilePictureUrl;
  String? bio;
  bool notificationsEnabled;

  User({
    this.uid = '',
    required this.firstName,
    required this.lastName,
    required this.email,
    this.profilePictureUrl='',
    this.bio = '',
    this.notificationsEnabled = true,
  });

  // Constructor for registration, which only takes name, email, and password
  User.register({
    required this.firstName,
    required this.lastName,
    required this.email,
  })  : uid = '',
        profilePictureUrl = '',
        bio = '',
        notificationsEnabled = true;

  // Converts a User object into a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profile_picture_url': profilePictureUrl,
      'bio': bio,
      'notifications_enabled': notificationsEnabled,
    };
  }

  // Creates a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
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

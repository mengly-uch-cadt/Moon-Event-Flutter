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

  // Constructor for update user info 
  User.update({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePictureUrl,
    required this.bio,
    required this.notificationsEnabled,
  });

  // Converts a User object into a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'bio': bio,
      'notificationsEnabled': notificationsEnabled,
    };
  }

  // Creates a User object from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      profilePictureUrl: map['profilePictureUrl'],
      bio: map['bio'],
      notificationsEnabled: map['notificationsEnabled'] ?? 1,
    );
  }

  // // Converts a User object into a JSON string
  // String toJson() => json.encode(toMap());

  // // // Creates a User object from a JSON string
  // factory User.fromJson(String source) => User.fromMap(json.decode(source));
}

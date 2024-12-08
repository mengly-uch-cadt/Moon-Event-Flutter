
class GetUser {
  final String uid;
  final String email;

  GetUser({
    required this.uid,
    required this.email,
  });

  factory GetUser.fromMapOnlyUidEmail(Map<String, dynamic> map) {
    return GetUser(
      uid: map['uid'],
      email: map['email'],
    );
  }
}
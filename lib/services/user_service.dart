import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:moon_event/model/get_user.dart';
import 'package:moon_event/model/user.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload profile image to Firebase Storage and get the URL
  Future<String> uploadProfileImage(File imageFile) async {
    try {
      // Get the file name and create a reference to Firebase Storage
      String fileName = path.basename(imageFile.path);
      Reference storageRef = _storage.ref().child('profile_images/$fileName');

      // Upload the image to Firebase Storage
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      return e.toString();
    }
  }

  // Update user information and profile image URL
  Future<ResponseResult> updateUserInformation({
    required String uid,
    required String firstName,
    required String lastName,
    required String bio,
    required File profileImage,
    required String email,
    required bool notificationsEnabled,
  }) async {
    try {
      // Upload the profile image and get the URL
      String profileImageUrl = await uploadProfileImage(profileImage);
      // String profileImageUrl = '';

      // Update user information in Firestore
      await _firestore.collection('users').doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'bio': bio,
        'profilePictureUrl': profileImageUrl,
      });

      User updateUser = User.update(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        profilePictureUrl: profileImageUrl,
        bio: bio,
        notificationsEnabled: notificationsEnabled,
      );

      return ResponseResult.success(data: updateUser, message: 'User information updated successfully');
    } catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  // Get all users
  Future<ResponseResult> getUsers() async {
    try {
      QuerySnapshot userSnapshot = await _firestore.collection('users').get();
      List<GetUser> users = userSnapshot.docs.map((doc) => GetUser.fromMapOnlyUidEmail(doc.data() as Map<String, dynamic>)).toList();
      return ResponseResult.success(data: users, message: 'Users fetched successfully');
    } catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  // Get user by UID
  Future<ResponseResult> getUserByUid(String uid) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(uid).get();
      User user = User.fromMap(userSnapshot.data() as Map<String, dynamic>);
      return ResponseResult.success(data: user, message: 'User fetched successfully');
    } catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }
}

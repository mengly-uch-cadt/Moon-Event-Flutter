import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: library_prefixes
import 'package:moon_event/model/user.dart' as AppUser;
import 'package:moon_event/utils/response_result_util.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Sign Up // User is model of Firebase auth so need to use AppUser.User form user model 
  Future<ResponseResult> signUp({required AppUser.User user, required String password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      // update user name in firebase auth
      await userCredential.user!.updateDisplayName('${user.firstName} ${user.lastName}');
      await userCredential.user!.reload();
      user.uid = userCredential.user!.uid;

      // save user data in firestore
      await _firestore.collection('users').doc(user.uid).set(user.toMap());

      return ResponseResult.success(
        data: userCredential.user,
        message: 'User registration successful',
      );  
    } catch (e) {
      return ResponseResult.failure(
        message: e.toString(),
      );
    }
  }

  // Login
  Future<ResponseResult> login({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get UID and fetch user data from Firestore
      String uid = userCredential.user!.uid;
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (userDoc.exists) {
        AppUser.User appUser = AppUser.User.fromMap(userDoc.data() as Map<String, dynamic>);
        return ResponseResult.success(
          data: appUser,
          message: 'User login successful',
        );
      } else {
        return ResponseResult.failure(
          message: 'User data not found in Firestore',
        );
      }
    } catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
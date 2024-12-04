import 'package:firebase_auth/firebase_auth.dart';
import 'package:moon_event/utils/response_result_util.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up
  Future<ResponseResult> signUp({required String email, required String password, required String username}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // update user name 
      await userCredential.user!.updateDisplayName(username);
      await userCredential.user!.reload();

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
      return ResponseResult.success(
        data: userCredential.user, 
        message: 'User login successful'
      );
    } catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
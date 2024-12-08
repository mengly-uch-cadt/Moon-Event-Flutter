import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create a secure storage instance
const secureStorage = FlutterSecureStorage();


Future<void> saveLoginState(String userId) async {
  await secureStorage.write(key: 'isLoggedIn', value: 'true');
  await secureStorage.write(key: 'userId', value: userId); // Save user ID securely
}

Future<String?> getUserId() async {
  final userId = await secureStorage.read(key: 'userId');
  if (userId == null) {
    throw Exception('User ID not found in secure storage.');
  }
  return userId;
}


Future<bool> isUserLoggedIn() async {
  final isLoggedIn = await secureStorage.read(key: 'isLoggedIn');
  return isLoggedIn == 'true';
}

Future<void> logout() async {
  await secureStorage.deleteAll(); // Clears all saved data
}

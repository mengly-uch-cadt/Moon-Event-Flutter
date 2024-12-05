import 'package:moon_event/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUserData(User userData) {
    state = userData;
  }

  void clearsetUserData() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class IsLoggedInNotifier extends StateNotifier<bool> {
  IsLoggedInNotifier() : super(false);

  void setLoggedIn(bool isLoggedIn) {
    state = isLoggedIn;
  }

  void clearLoggedIn() {
    state = false;
  }
}

final isLoggedInProvider = StateNotifierProvider<IsLoggedInNotifier, bool>((ref) {
  return IsLoggedInNotifier();
}
);
import 'package:moon_event/model/get_user.dart';
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

class GetUsersNotifier extends StateNotifier<List<GetUser>?> {
  GetUsersNotifier() : super(null);

  void setGetUsersData(List<GetUser> userData) {
    state = userData;
  }

  void clearGetUsersData() {
    state = null;
  }
}

final getUsersProvider = StateNotifierProvider<GetUsersNotifier, List<GetUser>?>((ref) {
  return GetUsersNotifier();
});
import 'package:moon_event/model/user.dart';
import 'package:moon_event/services/user_service.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/utils/secure_local_storage_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

UserService userService = UserService();

void fetchUserData(WidgetRef ref) async {
    final String? userUid = await getUserId();
    if (userUid == null) {
      throw Exception('User ID is null');
    }
    Future<ResponseResult> responseResult = userService.getUserByUid(userUid);
    responseResult.then((responseResult) {
      if (responseResult.isSuccess) {
        final User user = responseResult.data;
        ref.read(userProvider.notifier).setUserData(user);
      } else {
        throw Exception('Failed to get user data');
      }
    });
  }
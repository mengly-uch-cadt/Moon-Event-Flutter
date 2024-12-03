import 'package:flutter/material.dart';
import 'package:moon_event/model/user_model.dart';
import 'package:moon_event/utils/database.dart';
import 'package:moon_event/utils/hash_password_util.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';

class LoginUtil {
  // Function to authenticate a user with email and password
  Future<User?> loginUser({required String email, required String password, required BuildContext context} ) async {
    final connection = await Database.connect();  // Connect to the database
    final hashedPassword = hashPassword(password);

    final results = await connection.query(
      'SELECT * FROM users WHERE email = ? AND password = ?',
      [email, hashedPassword],
    );

    await connection.close(); 
    if (results.isNotEmpty) {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return const MoonAlertWidget(
              icon: Icons.check_circle,
              title: 'Login Successful',
            );
          },
        );
      return User.fromMap(results.first.fields);
    } else {
      showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return const MoonAlertWidget(
              icon: Icons.error,
              title: 'Login Failed',
              typeError: true,
            );
          },
        );
      return null;
    }
  }
}

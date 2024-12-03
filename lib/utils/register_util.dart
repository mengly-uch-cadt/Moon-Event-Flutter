import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:moon_event/model/user_model.dart';
import 'package:moon_event/screen/home_screen.dart';
import 'package:moon_event/utils/database.dart';
import 'package:moon_event/utils/hash_password_util.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';

class RegisterUtil {
  // Function to register a new user with name, email, and password
  static Future<void> registerUser({required User user, required BuildContext context}) async {
    try {
      final connection = await Database.connect();  // Connect to the database

      // Encrypt the password
      final encryptedPassword = hashPassword(user.password);

      final result = await connection.query(
        'INSERT INTO users (uuid, name, email, password) VALUES (?, ?, ?, ?)',
        [user.uuid, user.name, user.email, encryptedPassword],
      );
      await connection.close();  // Close the connection

      if (result.affectedRows != null && result.affectedRows! > 0) {
        // If registration was successful, show success dialog
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
        return const MoonAlertWidget(
          icon: Icons.check_circle,
          title: 'Registration Successful',
        );
          },
        ).then((_) {
          Navigator.push(
            // ignore: use_build_context_synchronously
            context, MaterialPageRoute(
              builder: (context) => const MoonHomeScreen()
            )
          );
        });
      } else {
        // If no rows were affected, show an error
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return const MoonAlertWidget(
              icon: Icons.error,
              title: 'Registration Failed',
              typeError: true,
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return const MoonAlertWidget(
            icon: Icons.error,
            title: 'An error occurred. Please try again later.',
          );
        },
      );
    }
  }
}

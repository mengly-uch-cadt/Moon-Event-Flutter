import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/utils/secure_local_storage_util.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/profile/moon_login_widget.dart';
import 'package:moon_event/widgets/profile/moon_profile_info_widget.dart';
import 'package:moon_event/widgets/profile/moon_register_widget.dart';

class MoonProfileScreen extends ConsumerStatefulWidget {
  const MoonProfileScreen({super.key});

  @override
  ConsumerState<MoonProfileScreen> createState() => _MoonProfileScreenState();
}

class _MoonProfileScreenState extends ConsumerState<MoonProfileScreen> {
  bool isLoggedIn = false; // Initially set to false

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Call the checkLoginStatus method on widget initialization
  }

  void checkLoginStatus() async {
    bool loggedIn = await isUserLoggedIn(); // Check login status asynchronously
    setState(() {
      isLoggedIn = loggedIn; // Update the state after getting the result
    });
  }

  void onLogout() async {
    await logout(); // Logout the user
    ref.read(userProvider.notifier).clearsetUserData(); // Clear user data
    setState(() {
      isLoggedIn = false; // After logout, update the isLoggedIn state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: isLoggedIn
                ? Column(
                    children: [
                      const MoonProfileInfoWidget(), // Show profile info widget
                      MoonButtonWidget(
                        text: "Logout",
                        onPressed: onLogout, // Logout action
                      ),
                    ],
                  )
                : Column(
                    children: [
                      MoonButtonWidget(
                        text: "Login",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoonLoginWidget(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      MoonButtonWidget(
                        text: "Register",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MoonRegisterWidget(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
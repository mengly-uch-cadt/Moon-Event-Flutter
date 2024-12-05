import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/state/user_state.dart';
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
  @override
  Widget build(BuildContext context) {
    // Watch the login status from the provider
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: isLoggedIn
                ? Column(
                    children: [
                      const MoonProfileInfoWidget(),
                      MoonButtonWidget(
                        text: "Logout",
                        onPressed: _onLogout,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      MoonButtonWidget(
                        text: "Login",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const MoonLoginWidget();  // Show login widget
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 25),
                      MoonButtonWidget(
                        text: "Register",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const MoonRegisterWidget();  // Show register widget
                            },
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

  // Function to handle logout
  void _onLogout() async {
    ref.read(isLoggedInProvider.notifier).clearLoggedIn();  // Update login state
    ref.read(userProvider.notifier).clearsetUserData(); // Clear user data
  }
}

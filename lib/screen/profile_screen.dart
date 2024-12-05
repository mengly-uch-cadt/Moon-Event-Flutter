import 'package:flutter/material.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/profile/moon_login_widget.dart';
import 'package:moon_event/widgets/profile/moon_profile_info_widget.dart';
import 'package:moon_event/widgets/profile/moon_register_widget.dart';

class MoonProfileScreen extends StatefulWidget {
  const MoonProfileScreen({super.key, required this.onLoginSuccess});
  final VoidCallback onLoginSuccess;

  @override
  State<MoonProfileScreen> createState() => _MoonProfileScreenState();
}

class _MoonProfileScreenState extends State<MoonProfileScreen> {
  bool loggedIn = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          loggedIn
          ? Column(
            children: [
              const MoonProfileInfoWidget(),
              MoonButtonWidget(
                text: "Logout",
                onPressed: () {
                  setState(() {
                    loggedIn = false;
                  });
                },
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
                      return MoonLoginWidget(
                        onLoginSuccess: () {
                          setState(() {
                            loggedIn = true; // Update state to logged-in
                          });
                          widget.onLoginSuccess(); // Trigger callback
                          
                        },
                      );
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
                      return const MoonRegisterWidget();
                    },                    
                  );
                },
              ),
            ],
          ),
         
        ],
      ),
    );
  }
}

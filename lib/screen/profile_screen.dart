import 'package:flutter/material.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/profile/moon_login_widget.dart';
import 'package:moon_event/widgets/profile/moon_register_widget.dart';

class MoonProfileScreen extends StatefulWidget {
  const MoonProfileScreen({super.key, required this.onLoginSuccess});
  final VoidCallback onLoginSuccess;

  @override
  State<MoonProfileScreen> createState() => _MoonProfileScreenState();
}

class _MoonProfileScreenState extends State<MoonProfileScreen> {
  bool notLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              notLoggedIn
              ? Column(
                children: [
                  MoonButtonWidget(
                    text: "Logout",
                    onPressed: () {
                      setState(() {
                        notLoggedIn = false;
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
                              widget.onLoginSuccess(); // Trigger callback
                              setState(() {
                                notLoggedIn = false; // Update state to logged-in
                              });
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
        ),
      ),
    );
  }
}

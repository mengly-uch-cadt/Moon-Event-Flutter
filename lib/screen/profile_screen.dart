import 'package:flutter/material.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/profile/moon_login_widget.dart';

class MoonProfileScreen extends StatelessWidget {
  const MoonProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
          )
        ],
      ),
    );
  }
}
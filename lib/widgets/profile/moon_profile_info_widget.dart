import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonProfileInfoWidget extends StatelessWidget {
  const MoonProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MoonTitleWidget(firstTitle: 'Profile', secondTitle: 'Info'),

          ],
        ),
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage('assets/profiles/female_profile.jpg'),
        ),
        const SizedBox(height: 20),
        Text(
          'John Doe',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary
            ),
        ),
        const SizedBox(height: 15),
        const Text('Passionate about technology, creativity, and making ideas come to life. Always learning, always growing. 🚀'), 
        
        const SizedBox(height: 25),

        MoonButtonWidget(
          text: 'Edit Profile',
          onPressed: () {
            // Add functionality to edit profile
          },
        ),
        const SizedBox(height: 20),
        MoonButtonWidget(
          text: 'Change Password',
          onPressed: () {
            // Add functionality to edit profile
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
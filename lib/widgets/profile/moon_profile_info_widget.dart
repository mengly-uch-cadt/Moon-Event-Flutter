import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/user.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonProfileInfoWidget extends ConsumerStatefulWidget {
  const MoonProfileInfoWidget({super.key});

  @override
  ConsumerState<MoonProfileInfoWidget> createState() => _MoonProfileInfoWidgetState();
}

class _MoonProfileInfoWidgetState extends ConsumerState<MoonProfileInfoWidget> {
  User? user;
  @override
  Widget build(BuildContext context) {
    user = ref.watch(userProvider);
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
        CircleAvatar(
          radius: 100,
          backgroundImage: user?.profilePictureUrl != '' 
              ? NetworkImage(user!.profilePictureUrl!) 
              : const AssetImage('assets/profiles/female_profile.jpg') as ImageProvider,
        ),
        const SizedBox(height: 20),
        Text(
          '${user?.firstName} ${user?.lastName}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.secondary
            ),
        ),
        const SizedBox(height: 15),
        user?.bio != null ? Text(user!.bio!) :
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
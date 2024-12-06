import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/widgets/moon_notification_widget.dart';

class MoonCustomAppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  final double appBarHeight; // Custom height

  // Constructor to allow dynamic height
  const MoonCustomAppBarWidget({super.key, this.appBarHeight = 120});

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the user state
    final user = ref.watch(userProvider);

    // Check if user is null and provide a fallback
    final userName = (user?.firstName != null && user?.lastName != null)
        ? '${user!.firstName} ${user.lastName}'
        : 'Guest';

    final userProfilePicture = user?.profilePictureUrl != null && user!.profilePictureUrl!.isNotEmpty
        ? NetworkImage(user.profilePictureUrl!)
        : const AssetImage('assets/profiles/female_profile.jpg') as ImageProvider;

    return Container(
      color: AppColors.secondary, // Background color
      height: appBarHeight, // Set custom height
      padding: const EdgeInsets.fromLTRB(20, 30, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Profile image
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: userProfilePicture,
                  ),
                  const SizedBox(width: 10),
                  // Welcome back text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome back,',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                      ),
                      Text(
                        userName, 
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Notification and globe icons
              Row(
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/notification.svg',
                      width: 24,
                      // ignore: deprecated_member_use
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (ctx) => const MoonNotificationWidget(),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

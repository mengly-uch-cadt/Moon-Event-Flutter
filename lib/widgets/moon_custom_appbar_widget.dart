import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_event/theme.dart';

class MoonCustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight; // Custom height

  // Constructor to allow dynamic height
  const MoonCustomAppBarWidget({super.key, this.appBarHeight = 120});

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {
    // Watch the user state
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
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/profiles/female_profile.jpg'),
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
                      const Text(
                        'Guest', // Use dynamic user name or default to 'Guest'
                        style: TextStyle(
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
                      // Add your notification logic
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/earth.svg',
                      width: 24,
                      // ignore: deprecated_member_use
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      // Add your language switch logic
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

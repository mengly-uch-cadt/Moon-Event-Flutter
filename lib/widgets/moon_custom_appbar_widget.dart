import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moon_event/state/theme_state.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_notification_widget.dart';
import 'package:moon_event/widgets/skeletonizer/moon_profile_skeletonizer_widget.dart';

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

    // Watch the theme mode state
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    // Check if user is null and provide a fallback
    final userName = (user?.firstName != null && user?.lastName != null)
        ? '${user!.firstName} ${user.lastName}'
        : 'Guest';

    final userProfilePictureUrl = user?.profilePictureUrl;

    return Container(
      color: AppColors.getSecondaryColor(context), // Background color
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
                    backgroundColor: AppColors.gray,
                    child: userProfilePictureUrl != null && userProfilePictureUrl.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              userProfilePictureUrl,
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image is ready
                                } else {
                                  // Skeleton during loading
                                  return const MoonProfileSkeletonizerWidget();
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      AssetImage('assets/profiles/female_profile.jpg'),
                                );
                              },
                            ),
                          )
                        : const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage('assets/profiles/female_profile.jpg'),
                          ),
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
              // Notification and dark mode toggle
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
                      if (ref.read(userProvider) == null) {
                        showDialog(
                          context: context,
                          builder: (ctx) => const MoonAlertWidget(
                            icon: Icons.error_outline,
                            title: 'Error',
                            description: 'Please log in to create an event.',
                            typeError: true,
                          ),
                        );
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (ctx) => const MoonNotificationWidget(),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: AppColors.white,
                    ),
                    onPressed: () {
                      // Toggle the theme mode
                      final newMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
                      ref.read(themeModeProvider.notifier).state = newMode;
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

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/model/user.dart';
import 'package:moon_event/services/auth_service.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';
import 'package:moon_event/widgets/profile/moon_change_password_widget.dart';
import 'package:moon_event/widgets/profile/moon_edit_profile_info_widget.dart';
import 'package:moon_event/widgets/skeletonizer/moon_profile_skeletonizer_widget.dart';

class MoonProfileInfoWidget extends ConsumerStatefulWidget {
  const MoonProfileInfoWidget({super.key});

  @override
  ConsumerState<MoonProfileInfoWidget> createState() => _MoonProfileInfoWidgetState();
}

class _MoonProfileInfoWidgetState extends ConsumerState<MoonProfileInfoWidget> {
  User? user;
  bool isForgotPasswordProcessing = false;
  @override
  Widget build(BuildContext context) {
    user = ref.watch(userProvider);
    final userProfilePictureUrl = user?.profilePictureUrl;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MoonTitleWidget(firstTitle: 'Profile', secondTitle: 'Information'),
            ],
          ),
          const SizedBox(height: 10),
          CircleAvatar(
            radius: 100,
            backgroundColor: AppColors.gray, // Set background to transparent
            child: userProfilePictureUrl != null && userProfilePictureUrl.isNotEmpty
              ? ClipOval(
                child: Image.network(
                  userProfilePictureUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image is ready
                    } else {
                    // Skeleton during loading
                      return const MoonProfileSkeletonizerWidget();
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback in case of an error
                    return const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/profiles/female_profile.jpg'),
                    );
                  },
                ),
                )
              : const CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/profiles/female_profile.jpg'),
                ),
          ),
          const SizedBox(height: 20),
          Text(
            '${user?.firstName} ${user?.lastName}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
          ),
          const SizedBox(height: 15),
          user?.bio != "" ? Text(user!.bio!): const SizedBox(),
          const SizedBox(height: 25),
          MoonButtonWidget(
            text: 'Edit Profile',
            onPressed: () {
              showDialog(
                context: context, 
                builder: (ctx) => const MoonEditProfileInfoWidget(),
              );
            },
          ),
          const SizedBox(height: 10),
          MoonButtonWidget(
            text: 'Change Password',
            onPressed: () {
              showDialog(
                context: context, 
                builder: (ctx) => const MoonChangePasswordWidget(),
              );
            },
          ),
          const SizedBox(height: 10),
          MoonButtonWidget(
            text: 'Forgot Password',
            onPressed: () {
              setState(() {
                isForgotPasswordProcessing = true;
              });
              AuthService authService = AuthService();
              authService.forgotPassword(null).then((responseResult) {
                setState(() {
                  isForgotPasswordProcessing = false;
                });
                if(responseResult.isSuccess){
                  showDialog(
                    context:context, 
                    builder: (ctx) =>   MoonAlertWidget(
                      icon: Icons.check_circle_outline,
                      title: 'Email Sent Successfully',
                      description: responseResult.message,
                      typeError: false,
                    )
                  );
                }
                else{
                  showDialog(
                    context:context, 
                    builder: (ctx) => MoonAlertWidget(
                      icon: Icons.error_outline,
                      title: 'Error',
                      description: responseResult.message,
                      typeError: true,
                    )
                  );
                }
              });
            },
            isProcessing: isForgotPasswordProcessing, 
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
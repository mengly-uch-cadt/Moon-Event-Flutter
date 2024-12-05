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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
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
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.secondary
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
              AuthService authService = AuthService();
              authService.forgotPassword(null).then((responseResult) {
                if(responseResult.isSuccess){
                  showDialog(
                    // ignore: use_build_context_synchronously
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
                    // ignore: use_build_context_synchronously
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
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
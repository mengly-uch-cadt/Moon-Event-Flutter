
// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:moon_event/services/auth_service.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/input/moon_password_field_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonChangePasswordWidget extends StatefulWidget {
  const MoonChangePasswordWidget({super.key});

  @override
  State<MoonChangePasswordWidget> createState() => _MoonChangePasswordWidgetState();
}

class _MoonChangePasswordWidgetState extends State<MoonChangePasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _conPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MoonTitleWidget(firstTitle: "Change", secondTitle: "Password"),
                ],
              ),
              const SizedBox(height: 20),
              MoonPasswordFormFieldWidget(
                controller: _oldPasswordController, 
                labelText: "Old Password", 
                hintText: "Enter your old password",
                isPasswordField: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (value.length > 20) {
                    return 'Password must not exceed 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              MoonPasswordFormFieldWidget(
                controller: _newPasswordController, 
                labelText: "New Password", 
                hintText: "Enter your new password",
                isPasswordField: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (value.length > 20) {
                    return 'Password must not exceed 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              MoonPasswordFormFieldWidget(
                controller: _conPasswordController, 
                labelText: "Confirm Password", 
                hintText: "Enter your confirm password",
                isPasswordField: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your confirm password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final AuthService authService = AuthService();

                    authService.changePassword(
                      currentPassword: _oldPasswordController.text,
                      newPassword: _newPasswordController.text,
                    ).then((responseResult) {
                      if (responseResult.isSuccess) {
                        showDialog(
                          context: context, 
                          builder: (ctx) => const MoonAlertWidget(
                            icon: Icons.check_circle_outline,
                            title: 'Success',
                            description: 'Password changed successfully',
                            typeError: false,
                          ),
                        );
                      } else {
                        showDialog(
                          context: context, 
                          builder: (ctx) => MoonAlertWidget(
                            icon: Icons.error_outline,
                            title: 'Error',
                            description: responseResult.message,
                            typeError: true,
                          ),
                        );
                      }
                    }).catchError((error) {
                      showDialog(
                        context: context, 
                        builder: (ctx) => MoonAlertWidget(
                          icon: Icons.error_outline,
                          title: 'Error',
                          description: error.toString(),
                          typeError: true,
                        ),
                      );
                    });
                  }
                },
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
        ),
    );
  }
}
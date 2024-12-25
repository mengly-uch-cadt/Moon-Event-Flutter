// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:moon_event/main.dart';
import 'package:moon_event/services/auth_service.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/utils/secure_local_storage_util.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/widgets/input/moon_password_field_widget.dart';
import 'package:moon_event/widgets/input/moon_text_field_widget.dart';
import 'package:moon_event/widgets/profile/moon_forgot_password_widget.dart';
import 'package:moon_event/widgets/profile/moon_register_widget.dart';

class MoonLoginWidget extends ConsumerStatefulWidget {
  const MoonLoginWidget({super.key, this.isFromEventDetails = false});
  final bool? isFromEventDetails;
  @override
  ConsumerState<MoonLoginWidget> createState() => _MoonLoginWidgetState();
}

class _MoonLoginWidgetState extends ConsumerState<MoonLoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isProcessing = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onLoginSuccess(String userId) async {
    await saveLoginState(userId);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .appBarTheme
            .backgroundColor, // Use the backgroundColor from the appBarTheme in primaryTheme
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Close the keyboard
        },
        child: SingleChildScrollView(
          child: Center(
            // Center widget for overall centering
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.getSecondaryColor(context)),
                    ),
                    const SizedBox(height: 25),
                    MoonTextFieldWidget(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                        },
                    ),
                    const SizedBox(height: 20),
                    MoonPasswordFormFieldWidget(
                      controller: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      isPasswordField: true, // Indicating it's a password field
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MoonForgotPasswordWidget(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot password",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.red),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    // ===========================================================
                    // Login Button
                    // ===========================================================
                    MoonButtonWidget(
                      text: "Login",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isProcessing = true;
                          });
                          AuthService authService = AuthService();
                          ResponseResult responseResult = await authService.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          setState(() {
                            isProcessing = false;
                          });
                          if (responseResult.isSuccess) {
                            final String userId = responseResult.data.uid;
                            onLoginSuccess(userId);
                            ref.read(userProvider.notifier).setUserData(responseResult.data);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(responseResult.message, style: TextStyle(color: AppColors.getTextColor(context))),
                                backgroundColor: AppColors.getSecondaryColor(context),
                              ),
                            );
                            // Still continue on event details page
                            if (widget.isFromEventDetails == true) {
                              Navigator.pop(context);
                              return;
                            }
                            // Navigate to home screen
                            Navigator.push(context, 
                              MaterialPageRoute(builder: (context) => const MoonBottomNavigationBar())
                            );
                          } else {
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
                        } else {
                          setState(() {
                            isProcessing = false;
                          });
                          // Show an error or leave it to validators to handle
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fix the errors in the form', style: TextStyle(color: AppColors.getTextColor(context))),
                              backgroundColor: AppColors.getSecondaryColor(context),
                            ),
                          );
                        }
                      },
                      isProcessing: isProcessing,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MoonRegisterWidget(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign up",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.red),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

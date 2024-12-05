import 'package:flutter/material.dart';
import 'package:moon_event/services/auth_service.dart';
import 'package:moon_event/state/user_state.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/local_storage.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moon_event/widgets/moon_password_field_widget.dart';
import 'package:moon_event/widgets/moon_text_field_widget.dart';
import 'package:moon_event/widgets/profile/moon_forgot_password_widget.dart';
import 'package:moon_event/widgets/profile/moon_register_widget.dart';

class MoonLoginWidget extends ConsumerStatefulWidget {
  const MoonLoginWidget({super.key});

  @override
  ConsumerState<MoonLoginWidget> createState() => _MoonLoginWidgetState();
}

class _MoonLoginWidgetState extends ConsumerState<MoonLoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                          color: AppColors.secondary),
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
                    MoonButtonWidget(
                      text: "Login",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          AuthService authService = AuthService();
                          ResponseResult responseResult = await authService.login(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          if (responseResult.isSuccess) {
                            ref.read(userProvider.notifier).setUserData(responseResult.data);
                            ref.read(isLoggedInProvider.notifier).setLoggedIn(true);  // Update login state
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(responseResult.message),
                              ),
                            );
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);  // Close the login dialog
                            // Now we explicitly update the screen to show profile information
                            // Replace with this navigation approach to ensure proper screen update
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          } else {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(responseResult.message),
                              ),
                            );
                          }
                        } else {
                          // Show an error or leave it to validators to handle
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please fix the errors in the form'),
                            ),
                          );
                        }
                      },
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

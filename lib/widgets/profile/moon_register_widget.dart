// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:moon_event/main.dart';
import 'package:moon_event/model/user.dart';
import 'package:moon_event/services/auth_service.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/utils/response_result_util.dart';
import 'package:moon_event/utils/secure_local_storage_util.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/input/moon_password_field_widget.dart';
import 'package:moon_event/widgets/input/moon_text_field_widget.dart';
import 'package:moon_event/widgets/profile/moon_login_widget.dart';

class MoonRegisterWidget extends StatefulWidget {
  const MoonRegisterWidget({super.key});

  @override
  State<MoonRegisterWidget> createState() => _MoonRegisterWidgetState();
}

class _MoonRegisterWidgetState extends State<MoonRegisterWidget> {
  final GlobalKey<FormState> _formKey                    = GlobalKey<FormState>();
  final TextEditingController _firstNameController       = TextEditingController();
  final TextEditingController _lastNameController        = TextEditingController();
  final TextEditingController _emailController           = TextEditingController();
  final TextEditingController _passwordController        = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool isProcessing = false;
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                      'Register',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.getSecondaryColor(context)),
                    ),
                    const SizedBox(height: 25),
                    MoonTextFieldWidget(
                      controller: _firstNameController,
                      labelText: 'Firstname',
                      hintText: "Enter your firstname",
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your firstname';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MoonTextFieldWidget(
                      controller: _lastNameController,
                      labelText: 'Lastname',
                      hintText: "Enter your lastname",
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your lastname';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MoonTextFieldWidget(
                      controller: _emailController,
                      labelText: 'Email Address',
                      hintText: "Enter your email address",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
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
                    const SizedBox(height: 20),
                    MoonPasswordFormFieldWidget(
                      controller: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      isPasswordField: true, // Indicating it's a password field
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    MoonButtonWidget(
                      text: "Register",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isProcessing = true;
                          });
                          AuthService authService = AuthService();
                          User user = User.register(
                            email: _emailController.text, 
                            firstName: _firstNameController.text, 
                            lastName: _lastNameController.text
                            );
                            ResponseResult responseResult = await authService.signUp(
                              user: user,
                              password: _passwordController.text,
                            );
                            setState(() {
                              isProcessing = false;
                            });
                            if (responseResult.isSuccess) {
                              saveLoginState(responseResult.data!.uid);
                              showDialog(
                                context: context, 
                                builder: (context) => MoonAlertWidget(
                                  icon: Icons.check_circle_outline,
                                  title: 'User Registration Successfully',
                                  description: responseResult.message,
                                  typeError: false,
                                ),    
                              ).then((_) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyApp()));
                              });
                            } else {
                              showDialog(
                                context: context, 
                                builder: (context) => MoonAlertWidget(
                                  icon: Icons.error_outline,
                                  title: 'Error',
                                  description: responseResult.message,
                                  typeError: true,
                                ),
                              );
                            }
                        } else {
                          setState(() {
                            isProcessing = false;
                          });
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
                          "Already have an account?",
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
                                    const MoonLoginWidget(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
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

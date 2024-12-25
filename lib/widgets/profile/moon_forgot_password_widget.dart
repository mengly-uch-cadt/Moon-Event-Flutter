// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:moon_event/services/auth_service.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_alert_widget.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/input/moon_text_field_widget.dart';
import 'package:moon_event/widgets/moon_title_widget.dart';

class MoonForgotPasswordWidget extends StatefulWidget {
  const MoonForgotPasswordWidget({super.key});

  @override
  State<MoonForgotPasswordWidget> createState() => _MoonForgotPasswordWidgetState();
}

class _MoonForgotPasswordWidgetState extends State<MoonForgotPasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool isProcessing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              const MoonTitleWidget(firstTitle: "forgot", secondTitle: "password"),
              const SizedBox(height: 10),
              Text(
                "Don’t worry, happens to all of us. Enter your email below to recover your password.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack,
                    ),
              ),
              const SizedBox(height: 40),
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
              const SizedBox(height: 45),
              MoonButtonWidget(
                text: "Send Email",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isProcessing = true;
                    });
                    AuthService().forgotPassword(_emailController.text).then((responseResult) {
                      setState(() {
                        isProcessing = false;
                      });
                      if(responseResult.isSuccess){
                        showDialog(
                          context: context,
                          builder: (context) => MoonAlertWidget(
                            icon: Icons.check_circle_outline,
                            title: 'Success',
                            description: responseResult.message,
                            typeError: false,
                          ),
                        );
                      }else{
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
                    }).catchError((e) {
                      setState(() {
                        isProcessing = false;
                      });
                      showDialog(
                        context: context,
                        builder: (context) => MoonAlertWidget(
                          icon: Icons.error_outline,
                          title: 'Error',
                          description: e.toString(),
                          typeError: true,
                        ),
                      );
                    });
                  }
                },
                isProcessing: isProcessing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:moon_event/theme.dart';
import 'package:moon_event/widgets/moon_button_widget.dart';
import 'package:moon_event/widgets/moon_divider_widget.dart';
import 'package:moon_event/widgets/moon_text_field_widget.dart';

class MoonForgotPasswordWidget extends StatefulWidget {
  const MoonForgotPasswordWidget({super.key});

  @override
  State<MoonForgotPasswordWidget> createState() => _MoonForgotPasswordWidgetState();
}

class _MoonForgotPasswordWidgetState extends State<MoonForgotPasswordWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleGetCode() async {
    if (_formKey.currentState!.validate()) {
      print("Phone: ${_phoneController.text}");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.chevron_left, color: Colors.black),
              iconSize: 20,
            ),
            Text(
              'Back to login',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                "Forgot Password?",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
              ),
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
                controller: _phoneController,
                labelText: 'Phone number',
                hintText: "Enter your phone number",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 9 || value.length > 10) {
                    return 'Please enter a valid phone number';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 45),
              MoonButtonWidget(
                text: "Get Code",
                onPressed: _handleGetCode,
              ),
              const SizedBox(height: 55),
              Row(
                children: [
                  const MoonDividerWidget(),
                  const SizedBox(width: 3),
                  Text(
                    "Or continue with",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 3),
                  const MoonDividerWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

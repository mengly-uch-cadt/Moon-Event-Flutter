import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_event/theme.dart';

class MoonPasswordFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPasswordField; // To distinguish password field
  final bool? obscureText;    // Can be used for toggling visibility
  final IconData? icon;       // Optional icon
  final VoidCallback? onIconPressed; // Optional callback for icon action

  const MoonPasswordFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.isPasswordField = false, // Default to false, means not a password field
    this.obscureText = true,      // Default to true for password field
    this.icon,                    // Optional icon
    this.onIconPressed,           // Optional icon press handler
  });

  @override
  // ignore: library_private_types_in_public_api
  _MoonPasswordFormFieldWidgetState createState() => _MoonPasswordFormFieldWidgetState();
}

class _MoonPasswordFormFieldWidgetState extends State<MoonPasswordFormFieldWidget> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Control obscureText based on visibility toggle
    bool obscureText = widget.isPasswordField ? !_isPasswordVisible : false;

    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText, // Toggle password visibility
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: AppColors.textBlack,
        ),
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.kantumruyPro().fontFamily,
          fontWeight: FontWeight.w100, // Set font weight to normal
          fontSize: 16,
          color: AppColors.textBlack, // Adjust to your AppAppColors
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
        ),
        // If it's a password field, add the icon to toggle visibility
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null, // If not a password, no icon
      ),
    );
  }
}
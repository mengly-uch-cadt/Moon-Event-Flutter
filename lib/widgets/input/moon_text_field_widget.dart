import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_event/theme.dart';

class MoonTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final IconData? icon;
  final VoidCallback? onIconPressed;
  final TextInputType? keyboardType;

  const MoonTextFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.obscureText = false, // Set default to false if not provided
    this.icon,                 // icon is optional
    this.onIconPressed, 
    this.keyboardType = TextInputType.text,        // callback to toggle visibility, optional
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false, // If not provided, default to false
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.kantumruyPro().fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: AppColors.getTextColor(context), // Adjust to your AppAppColors
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.kantumruyPro().fontFamily,
          fontWeight: FontWeight.w100, // Set font weight to normal
          fontSize: 16,
          color: AppColors.getTextBlack(context), // Adjust to your AppAppColors
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppAppColors
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppAppColors
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red), // Adjust to your AppAppColors
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red), // Adjust to your AppAppColors
        ),
        suffixIcon: icon != null
            ? IconButton(
                icon: Icon(icon),
                onPressed: onIconPressed, // Toggle visibility on press
              )
            : null, // Only show icon if it's provided
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction, // Triggers validation while typing
    );
  }
}
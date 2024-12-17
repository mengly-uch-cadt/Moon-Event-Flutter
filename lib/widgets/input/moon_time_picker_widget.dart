// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_event/theme.dart';

class MoonTimePickerWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;

  const MoonTimePickerWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true, // Prevents manual input
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.kantumruyPro().fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: AppColors.textBlack,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.kantumruyPro().fontFamily,
          fontWeight: FontWeight.w100,
          fontSize: 16,
          color: AppColors.textBlack,
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
        suffixIcon: Icon(Icons.access_time, color: AppColors.primary),
      ),
      validator: validator,
      onTap: () async {
        // Display the time picker dialog
        TimeOfDay? selectedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primary, // Header background color
                  onPrimary: Colors.white, // Header text color
                  onSurface: AppColors.textBlack, // Text color
                ),
              ),
              child: child!,
            );
          },
        );

        if (selectedTime != null) {
          // Format the selected time and set it in the controller
          controller.text = selectedTime.format(context);
        }
      },
    );
  }
}

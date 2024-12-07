import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_event/theme.dart';

class MoonDatePickerWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final DateTime firstDate;
  final DateTime lastDate;

  const MoonDatePickerWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.firstDate,
    required this.lastDate,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
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
              color: AppColors.primary,
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
            suffixIcon: Icon(Icons.calendar_today, color: AppColors.primary),
          ),
          validator: validator,
          onTap: () async {
            // Display the date picker dialog
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: firstDate,
              lastDate: lastDate,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: AppColors.primary, // Header background color
                      onPrimary: Colors.white, // Header text color
                      onSurface: AppColors.textBlack, // Text color
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary, // Button text color
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (selectedDate != null) {
              // Format the selected date and set it in the controller
              controller.text =
                  "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
            }
          },
        ),
      ],
    );
  }
}

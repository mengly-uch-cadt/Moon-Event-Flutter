import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moon_event/model/category.dart';
import 'package:moon_event/theme.dart';

class MoonDropdownInputWidget extends StatelessWidget {
  final String? value; // value is now the category ID (String)
  final List<Category> items; // A list of maps containing category ID and name
  final String labelText;
  final String hintText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const MoonDropdownInputWidget({
    super.key,
    required this.value,
    required this.items,
    required this.labelText,
    required this.hintText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: GoogleFonts.kantumruyPro().fontFamily,
          fontWeight: FontWeight.w400,
          fontSize: 18,
          color: AppColors.getTextColor(context), // Adjust to your AppColors
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.kantumruyPro().fontFamily,
          fontWeight: FontWeight.w100,
          fontSize: 16,
          color: AppColors.getTextColor(context), // Adjust to your AppColors
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppColors
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray), // Adjust to your AppColors
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red), // Adjust to your AppColors
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.red), // Adjust to your AppColors
        ),
      ),
      items: items.map((category) {
        return DropdownMenuItem<String>(
          value: category.uuid, // Use the category ID as the value
          child: Text(
            category.category, // Display the category 
            style: TextStyle(
              fontFamily: GoogleFonts.kantumruyPro().fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.getTextColor(context),
            ),
          ),
        );
      }).toList(),
      dropdownColor: AppColors.white, // Optional: Set dropdown background color
    );
  }
}

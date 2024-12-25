import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors{
  static Color primary        = const Color(0xFF2033C4);
  static Color secondary      = const Color(0xFF0F185E);
  static Color white          = const Color(0xFFFFFFFF);
  static Color black          = const Color(0xFF000000);
  static Color blackAccent    = const Color(0xFF1F1F1F);
  static Color platinum       = const Color(0xFFEFF1F3);
  static Color gray           = const Color(0xFFD9D9D9);
  static Color lighterShade   = const Color(0xFF3C4C90);
  static Color darkLiver      = const Color(0xFF4D4D4D);
  static Color outerSpace     = const Color(0xFF494949);
  static Color red            = const Color(0xFFD02828);
  static Color textBlack      = const Color(0xFF313131);
  static Color borderInput    = const Color(0xFFD5D5D5);
  static Color cancelInput    = const Color(0xFFF7F8F9);
  static Color star           = const Color(0xFFF5AC00);
  static Color darkRed        = const Color(0xFF8B0000);
  static Color backgroundDark = const Color(0xFF0d0d0d);
  static Color darkBlue       = const Color(0xFF000099);
  static Color textGray       = const Color(0xFFb3b3b3);
  
  static Color getBackgroundColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;  // Use Theme brightness instead
    return brightness == Brightness.dark ? AppColors.black : AppColors.white;
  }

  // Method to get dynamic text color based on the theme
  static Color getTextColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;  // Use Theme brightness instead
    return brightness == Brightness.dark ? AppColors.white : AppColors.black; // Returns correct color based on brightness
  }

  // Method to get dynamic secondary color based on the theme
  static Color getSecondaryColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppColors.secondary : AppColors.secondary; // Dark Red for dark mode
  }

  // Method to get dynamic card color 
  static Color getCardColor(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppColors.blackAccent : AppColors.white; // Black Accent for dark mode
  }

  // Method to get dynamic TextBlack
  static Color getTextBlack(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? AppColors.textGray : AppColors.textBlack; // Black Accent for dark mode
  }
}

class AppTextTheme {
  static TextTheme getTextTheme(BuildContext context) {
    return GoogleFonts.kantumruyProTextTheme(
      Theme.of(context).textTheme,
    ).copyWith(
      displayLarge     : GoogleFonts.kantumruyPro(fontSize: 40, color: AppColors.textBlack),
      displayMedium    : GoogleFonts.kantumruyPro(fontSize: 32, color: AppColors.textBlack),
      displaySmall     : GoogleFonts.kantumruyPro(fontSize: 24, color: AppColors.textBlack),
      headlineLarge    : GoogleFonts.kantumruyPro(fontSize: 32, color: AppColors.textBlack, fontWeight: FontWeight.bold),
      headlineMedium   : GoogleFonts.kantumruyPro(fontSize: 24, color: AppColors.textBlack, fontWeight: FontWeight.w600),
      headlineSmall    : GoogleFonts.kantumruyPro(fontSize: 20, color: AppColors.textBlack, fontWeight: FontWeight.w500),
      titleLarge       : GoogleFonts.kantumruyPro(fontSize: 18, color: AppColors.textBlack, fontWeight: FontWeight.bold),
      titleMedium      : GoogleFonts.kantumruyPro(fontSize: 16, color: AppColors.textBlack, fontWeight: FontWeight.bold),
      titleSmall       : GoogleFonts.kantumruyPro(fontSize: 14, color: AppColors.textBlack, fontWeight: FontWeight.bold),
      bodyLarge        : GoogleFonts.kantumruyPro(fontSize: 16, color: AppColors.textBlack),
      bodyMedium       : GoogleFonts.kantumruyPro(fontSize: 15, color: AppColors.textBlack, fontWeight: FontWeight.w300),
      bodySmall        : GoogleFonts.kantumruyPro(fontSize: 12, color: AppColors.textBlack),
      labelLarge       : GoogleFonts.kantumruyPro(fontSize: 16, color: AppColors.textBlack, fontWeight: FontWeight.bold),
      labelMedium      : GoogleFonts.kantumruyPro(fontSize: 14, color: AppColors.textBlack, fontWeight: FontWeight.bold),
      labelSmall       : GoogleFonts.kantumruyPro(fontSize: 12, color: AppColors.textBlack, fontWeight: FontWeight.bold),
    );
  }
}

final ThemeData primaryTheme = ThemeData(
  brightness: Brightness.light,
  // seed color theme
  colorScheme: ColorScheme.fromSeed( // Color scheme for the app
    seedColor: AppColors.blackAccent, // Seed color
    brightness: Brightness.light, // Ensure brightness matches
  ),

  scaffoldBackgroundColor: AppColors.white, // Scaffold background color
  // useMaterial3: true, // Enable Material 3 design

  // app bar theme colors
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.white, // Explicitly set the background color to your primary color
    foregroundColor: AppColors.blackAccent,   // Text color in the AppBar, e.g., white
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // seed color theme
  colorScheme: ColorScheme.fromSeed( // Color scheme for the app
    seedColor: AppColors.white, // Seed color
    brightness: Brightness.dark, // Ensure brightness matches
  ),
  scaffoldBackgroundColor: AppColors.blackAccent, // Scaffold background color
  
  // app bar theme colors
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.blackAccent, // Explicitly set the background color to your primary color
    foregroundColor: AppColors.white,   // Text color in the AppBar, e.g., white
    surfaceTintColor: Colors.transparent,
    centerTitle: true,
  ),
);

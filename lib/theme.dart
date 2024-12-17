import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors{
  // Blue
  // static Color primary     = const Color(0xFF2033C4);
  // static Color secondary    = const Color(0xFF0F185E);
  // Purble
  // static Color primary      = const Color(0xFFD1C4E9);
  // static Color secondary    = const Color(0xFF6A1B9A);
  // Emerald Green
  // static Color primary      = const Color(0xFF2E7D32);
  // static Color secondary    = const Color(0xFF155619);
  // Brown
  // static Color primary      = const Color(0xFFa47148);
  // static Color secondary    = const Color(0xFF583101);

  // Purple
  static Color primary      = const Color(0xFF7b2cbf);
  static Color secondary    = const Color(0xFF240046);

  static Color white        = const Color(0xFFFFFFFF);
  static Color black        = const Color(0xFF000000);
  static Color blackAccent  = const Color(0xFF1F1F1F);
  static Color platinum     = const Color(0xFFEFF1F3);
  static Color gray         = const Color(0xFFD9D9D9);
  static Color lighterShade = const Color(0xFF3C4C90);
  static Color darkLiver    = const Color(0xFF4D4D4D);
  static Color outerSpace   = const Color(0xFF494949);
  static Color red          = const Color(0xFFD02828);
  static Color textBlack    = const Color(0xFF313131);
  static Color borderInput  = const Color(0xFFD5D5D5);
  static Color cancelInput  = const Color(0xFFF7F8F9);
  static Color star         = const Color(0xFFF5AC00);
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
  // seed color theme
  colorScheme: ColorScheme.fromSeed( // Color scheme for the app 
    seedColor: AppColors.blackAccent, // Seed color
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




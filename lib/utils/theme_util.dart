import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorageUtil {
  static const String _themeKey = 'theme_mode';

  /// Save the theme mode
  static Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode);
  }

  /// Get the saved theme mode
  static Future<String?> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey);
  }
}

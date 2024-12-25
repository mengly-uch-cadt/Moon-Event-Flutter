// dynamic_colors.dart
import 'package:flutter/material.dart';

class DynamicColors {
  static Color getColor(BuildContext context, Color lightModeColor, Color darkModeColor) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? darkModeColor : lightModeColor;
  }
}

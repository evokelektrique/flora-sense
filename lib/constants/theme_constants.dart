
// Define color palettes
import 'package:flutter/material.dart';

const ColorPalette darkModePalette = ColorPalette(
  primary: Color(0xFF00C853),
  secondary: Color(0xFF00E676),
  background: Color(0xFF1B1B1B),
  appBarBackground: Color.fromARGB(255, 13, 212, 179),
  iconColor: Color(0xFF00E676),
  snackBarBackground: Color(0xFF333333),
  snackBarActionColor: Color(0xFF00C853),
  snackBarContentColor: Colors.white,
  discardedColor: Color(0xFFB0BEC5), // Gray color for discarded text/icons
);

const ColorPalette lightModePalette = ColorPalette(
  primary: Color(0xFF00C853),
  secondary: Color(0xFF00E676),
  background: Color(0xFFE8F5E9),
  appBarBackground: Color(0xFF00E676),
  iconColor: Color(0xFF00C853),
  snackBarBackground: Color(0xFFE0F2F1),
  snackBarActionColor: Color(0xFF00C853),
  snackBarContentColor: Colors.black,
  discardedColor: Color(0xFF9E9E9E), // Gray color for discarded text/icons
);

// Color palette class
class ColorPalette {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color appBarBackground;
  final Color iconColor;
  final Color snackBarBackground;
  final Color snackBarActionColor;
  final Color snackBarContentColor;
  final Color discardedColor;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.appBarBackground,
    required this.iconColor,
    required this.snackBarBackground,
    required this.snackBarActionColor,
    required this.snackBarContentColor,
    required this.discardedColor,
  });
}
// Define text styles
const TextStyle textStyleDarkMode = TextStyle(color: Colors.white);
const TextStyle textStyleLightMode = TextStyle(color: Colors.black);

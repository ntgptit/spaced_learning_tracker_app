import 'package:flutter/material.dart';

/// App color constants
/// All colors are defined here to ensure consistency across the app
class AppColors {
  // Primary color and its variants
  static const Color primary = Color(0xFF1A73E8);
  static const Color primaryLight = Color(0xFF8AB4F8);
  static const Color primaryDark = Color(0xFF0D47A1);

  // Secondary color and its variants
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryLight = Color(0xFFB2EBF2);
  static const Color secondaryDark = Color(0xFF018786);

  // Background colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text colors
  static const Color textPrimary = Color(0xFF202124);
  static const Color textSecondary = Color(0xFF5F6368);
  static const Color textDisabled = Color(0xFF9AA0A6);
  static const Color textPrimaryDark = Color(0xFFE8EAED);
  static const Color textSecondaryDark = Color(0xFFAECBFA);
  static const Color textDisabledDark = Color(0xFF9AA0A6);

  // Error colors
  static const Color error = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);

  // Success colors
  static const Color success = Color(0xFF34A853);
  static const Color successDark = Color(0xFF81C995);

  // Warning colors
  static const Color warning = Color(0xFFFFA000);
  static const Color warningDark = Color(0xFFFFCA28);

  // Info colors
  static const Color info = Color(0xFF4285F4);
  static const Color infoDark = Color(0xFF8AB4F8);

  // Divider colors
  static const Color divider = Color(0xFFDADCE0);
  static const Color dividerDark = Color(0xFF3C4043);

  // Card colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2D2D);

  // Shadow colors
  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x1AFFFFFF);

  // Status colors
  static const Color offline = Color(0xFF9E9E9E);
  static const Color online = Color(0xFF34A853);
  static const Color busy = Color(0xFFEA4335);
  static const Color away = Color(0xFFFFA000);

  // Overlay colors
  static const Color overlayLight = Color(0x80FFFFFF);
  static const Color overlayDark = Color(0x80000000);

  // Transparent
  static const Color transparent = Color(0x00000000);

  // Exam result colors
  static const Color excellent = Color(0xFF34A853);
  static const Color good = Color(0xFF4285F4);
  static const Color average = Color(0xFFFFA000);
  static const Color poor = Color(0xFFEA4335);

  // Get color based on theme mode
  static Color getColor(Color lightColor, Color darkColor, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return lightColor;
      case ThemeMode.dark:
        return darkColor;
      case ThemeMode.system:
      // This should be adjusted based on platform brightness in real usage
        return lightColor;
    }
  }
}
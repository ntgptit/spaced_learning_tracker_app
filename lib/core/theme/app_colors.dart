import 'package:flutter/material.dart';

/// App color constants
/// All colors are defined here to ensure consistency across the app
class AppColors {
  // Primary color and its variants
  static const Color primary = Color(0xFF345351);
  static const Color primaryLight = Color(0xFF4c6b69);
  static const Color primaryDark = Color(0xFF00201f);

  // Secondary color and its variants
  static const Color secondary = Color(0xFF556160);
  static const Color secondaryLight = Color(0xFFd8e5e3);
  static const Color secondaryDark = Color(0xFF121e1d);

  // Background colors
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color backgroundDark = Color(0xFF121413);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text colors
  static const Color textPrimary = Color(0xFF1a1c1c);
  static const Color textSecondary = Color(0xFF414847);
  static const Color textDisabled = Color(0xFF9AA0A6);
  static const Color textPrimaryDark = Color(0xFFe3e2e1);
  static const Color textSecondaryDark = Color(0xFFc1c8c7);
  static const Color textDisabledDark = Color(0xFF9AA0A6);

  // Error colors
  static const Color error = Color(0xFFba1a1a);
  static const Color errorDark = Color(0xFFffb4ab);

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

  // Exam result colors
  static const Color excellent = Color(0xFF34A853);
  static const Color good = Color(0xFF4285F4);
  static const Color average = Color(0xFFFFA000);
  static const Color poor = Color(0xFFEA4335);
}

/// Extension to add alpha value to colors
extension ColorExtension on Color {
  Color withValues({
    int? red,
    int? green,
    int? blue,
    double? alpha,
  }) {
    return Color.fromARGB(
      alpha != null ? (alpha * 255).round() : this.alpha,
      red ?? this.red,
      green ?? this.green,
      blue ?? this.blue,
    );
  }
}

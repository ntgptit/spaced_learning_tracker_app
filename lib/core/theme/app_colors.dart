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

  // Material 3 container colors (light mode)
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF8F9F9);
  static const Color surfaceContainer = Color(0xFFF2F3F3);
  static const Color surfaceContainerHigh = Color(0xFFECEDED);
  static const Color surfaceContainerHighest = Color(0xFFE6E7E7);

  // Material 3 container colors (dark mode)
  static const Color surfaceContainerLowestDark = Color(0xFF121413);
  static const Color surfaceContainerLowDark = Color(0xFF191B1A);
  static const Color surfaceContainerDark = Color(0xFF1F2120);
  static const Color surfaceContainerHighDark = Color(0xFF252726);
  static const Color surfaceContainerHighestDark = Color(0xFF2C2E2D);

  // Surface tint colors for elevation
  static const Color surfaceTint = primary;
  static const Color surfaceTintDark = primaryLight;

  // Outline colors
  static const Color outline = Color(0xFFBDC1C6);
  static const Color outlineVariant = Color(0xFFDADCE0);
  static const Color outlineDark = Color(0xFF5F6368);
  static const Color outlineVariantDark = Color(0xFF3C4043);

  // Gradients - Popular combinations
  static const List<Color> primaryGradient = [primary, primaryLight];
  static const List<Color> secondaryGradient = [secondary, secondaryLight];
  static const List<Color> successGradient = [success, Color(0xFF81C995)];
  static const List<Color> errorGradient = [error, Color(0xFFE57373)];
  static const List<Color> warningGradient = [warning, Color(0xFFFFCA28)];
  static const List<Color> infoGradient = [info, Color(0xFF8AB4F8)];

  // Specialized gradients
  static const List<Color> darkBlueGradient = [
    Color(0xFF2196F3),
    Color(0xFF0D47A1),
  ];
  static const List<Color> purpleGradient = [
    Color(0xFF9C27B0),
    Color(0xFF4A148C),
  ];
  static const List<Color> orangeGradient = [
    Color(0xFFFF9800),
    Color(0xFFEF6C00),
  ];
  static const List<Color> tealGradient = [
    Color(0xFF009688),
    Color(0xFF00695C),
  ];

  // Private constructor to prevent instantiation
  AppColors._();

  /// Get appropriate color based on brightness
  static Color getByBrightness(
    Brightness brightness,
    Color lightColor,
    Color darkColor,
  ) {
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  /// Get appropriate status color based on a status string
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'online':
      case 'active':
      case 'available':
        return online;
      case 'busy':
      case 'occupied':
      case 'do not disturb':
        return busy;
      case 'away':
      case 'idle':
        return away;
      case 'offline':
      case 'inactive':
      case 'unavailable':
        return offline;
      default:
        return offline;
    }
  }

  /// Get appropriate result color based on numerical value
  static Color getResultColor(double value, {double maxValue = 100.0}) {
    final percentage = value / maxValue;

    if (percentage >= 0.85) return excellent;
    if (percentage >= 0.70) return good;
    if (percentage >= 0.50) return average;
    return poor;
  }
}

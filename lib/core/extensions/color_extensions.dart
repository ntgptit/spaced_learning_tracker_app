import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Extension to manipulate colors
extension ColorExtension on Color {
  /// Create a new color with modified values
  Color withValues({int? red, int? green, int? blue, double? alpha}) {
    return Color.fromARGB(
      alpha != null ? (alpha * 255).round() : this.alpha,
      red ?? this.red,
      green ?? this.green,
      blue ?? this.blue,
    );
  }

  /// Create a new color with modified brightness
  Color withBrightness(double factor) {
    assert(
      factor >= -1.0 && factor <= 1.0,
      'Factor must be between -1.0 and 1.0',
    );

    int r = red;
    int g = green;
    int b = blue;

    if (factor < 0) {
      // Darken
      r = (r * (1 + factor)).round().clamp(0, 255);
      g = (g * (1 + factor)).round().clamp(0, 255);
      b = (b * (1 + factor)).round().clamp(0, 255);
    } else if (factor > 0) {
      // Lighten
      r = (r + (255 - r) * factor).round().clamp(0, 255);
      g = (g + (255 - g) * factor).round().clamp(0, 255);
      b = (b + (255 - b) * factor).round().clamp(0, 255);
    }

    return Color.fromARGB(alpha, r, g, b);
  }

  /// Darken a color
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    return withBrightness(-amount);
  }

  /// Lighten a color
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');
    return withBrightness(amount);
  }

  /// Mix with another color
  Color mix(Color other, [double amount = 0.5]) {
    assert(amount >= 0 && amount <= 1, 'Amount must be between 0 and 1');

    final r = (red * (1 - amount) + other.red * amount).round().clamp(0, 255);
    final g = (green * (1 - amount) + other.green * amount).round().clamp(
      0,
      255,
    );
    final b = (blue * (1 - amount) + other.blue * amount).round().clamp(0, 255);
    final a = (alpha * (1 - amount) + other.alpha * amount).round().clamp(
      0,
      255,
    );

    return Color.fromARGB(a, r, g, b);
  }

  /// Convert color to a hex string
  String toHex({bool includeAlpha = false, bool includeHash = true}) {
    String hex = includeHash ? '#' : '';

    if (includeAlpha) {
      hex += alpha.toRadixString(16).padLeft(2, '0');
    }

    hex += red.toRadixString(16).padLeft(2, '0');
    hex += green.toRadixString(16).padLeft(2, '0');
    hex += blue.toRadixString(16).padLeft(2, '0');

    return hex.toUpperCase();
  }

  /// Get a MaterialStateColor for use in Material buttons, inputs, etc.
  MaterialStateColor toMaterialStateColor() {
    return MaterialStateColor.resolveWith((states) => this);
  }

  /// Check if a color is light
  bool get isLight => computeLuminance() > 0.5;

  /// Check if a color is dark
  bool get isDark => !isLight;

  /// Get contrasting foreground color (white or black)
  Color get contrastText =>
      isLight ? AppColors.textPrimary : AppColors.textPrimaryDark;
}

/// Extension to get MaterialColor tonal palette from a base Color
extension MaterialColorExtension on Color {
  /// Create a MaterialColor from a base color
  MaterialColor toMaterialColor() {
    final int r = red;
    final int g = green;
    final int b = blue;

    // Create shades by adjusting the brightness up and down
    return MaterialColor(value, {
      50: Color.fromRGBO(r, g, b, 0.1),
      100: Color.fromRGBO(r, g, b, 0.2),
      200: Color.fromRGBO(r, g, b, 0.3),
      300: Color.fromRGBO(r, g, b, 0.4),
      400: Color.fromRGBO(r, g, b, 0.5),
      500: Color.fromRGBO(r, g, b, 0.6),
      600: Color.fromRGBO(r, g, b, 0.7),
      700: Color.fromRGBO(r, g, b, 0.8),
      800: Color.fromRGBO(r, g, b, 0.9),
      900: Color.fromRGBO(r, g, b, 1.0),
    });
  }

  /// Create a custom MaterialColor with proper tonal steps
  /// Create a custom MaterialColor with proper tonal steps
  MaterialColor toCustomMaterialColor() {
    // Định nghĩa hàm helper _colorFromHSL trước khi sử dụng
    Color _colorFromHSL(HSLColor hslColor, double lightness) {
      final newLightness = (lightness.clamp(0.0, 1.0));
      return hslColor.withLightness(newLightness).toColor();
    }

    // Sau đó mới sử dụng nó trong _getSwatch
    Map<int, Color> _getSwatch(Color color) {
      final hslColor = HSLColor.fromColor(color);
      final lightness = hslColor.lightness;

      // Create a map of tonal variations
      return {
        050: _colorFromHSL(hslColor, lightness + 0.35),
        100: _colorFromHSL(hslColor, lightness + 0.30),
        200: _colorFromHSL(hslColor, lightness + 0.25),
        300: _colorFromHSL(hslColor, lightness + 0.15),
        400: _colorFromHSL(hslColor, lightness + 0.05),
        500: _colorFromHSL(hslColor, lightness),
        600: _colorFromHSL(hslColor, lightness - 0.05),
        700: _colorFromHSL(hslColor, lightness - 0.10),
        800: _colorFromHSL(hslColor, lightness - 0.15),
        900: _colorFromHSL(hslColor, lightness - 0.20),
      };
    }

    final swatch = _getSwatch(this);
    return MaterialColor(this.value, {
      50: swatch[050]!,
      100: swatch[100]!,
      200: swatch[200]!,
      300: swatch[300]!,
      400: swatch[400]!,
      500: swatch[500]!,
      600: swatch[600]!,
      700: swatch[700]!,
      800: swatch[800]!,
      900: swatch[900]!,
    });
  }
}

/// Extension for creating colors from hex strings
extension StringColorExtension on String {
  /// Parse a hex color string to a Color object
  Color toColor() {
    // Handle color strings in various formats
    String colorString = this.trim();

    if (colorString.isEmpty) {
      return Colors.transparent;
    }

    // Remove hash if present
    if (colorString.startsWith('#')) {
      colorString = colorString.substring(1);
    }

    // Add alpha value if needed
    if (colorString.length == 6) {
      colorString = 'FF$colorString';
    } else if (colorString.length == 3) {
      // Handle shorthand hex format (e.g. #F00)
      final r = colorString[0];
      final g = colorString[1];
      final b = colorString[2];
      colorString = 'FF$r$r$g$g$b$b';
    }

    // Parse the hex value to int
    int? value = int.tryParse(colorString, radix: 16);
    return value != null ? Color(value) : Colors.transparent;
  }
}

/// Utility class for color manipulation
class ColorUtils {
  // Private constructor to prevent instantiation
  ColorUtils._();

  /// Return appropriate text color (black or white) for a given background color
  static Color getContrastingTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5
        ? AppColors.textPrimary
        : AppColors.textPrimaryDark;
  }

  /// Generate a color scheme from a seed color
  static ColorScheme generateColorScheme(
    Color seedColor, {
    Brightness brightness = Brightness.light,
  }) {
    return ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness);
  }

  /// Generate a random color
  static Color getRandomColor({int alpha = 255}) {
    final random = DateTime.now().millisecondsSinceEpoch;
    return Color((random & 0xFFFFFF) | (alpha << 24));
  }

  /// Convert RGB to HSL
  static HSLColor rgbToHsl(int r, int g, int b) {
    return HSLColor.fromColor(Color.fromARGB(255, r, g, b));
  }

  /// Convert HSL to RGB
  static Color hslToRgb(double h, double s, double l) {
    return HSLColor.fromAHSL(1.0, h, s, l).toColor();
  }

  /// Create a color palette (5 colors) from a base color
  static List<Color> createPalette(Color baseColor, {bool harmonious = true}) {
    final hslColor = HSLColor.fromColor(baseColor);
    final hue = hslColor.hue;

    if (harmonious) {
      // Create harmonious palette (analogous)
      return [
        HSLColor.fromAHSL(
          1.0,
          (hue - 40) % 360,
          hslColor.saturation,
          hslColor.lightness,
        ).toColor(),
        HSLColor.fromAHSL(
          1.0,
          (hue - 20) % 360,
          hslColor.saturation,
          hslColor.lightness,
        ).toColor(),
        baseColor,
        HSLColor.fromAHSL(
          1.0,
          (hue + 20) % 360,
          hslColor.saturation,
          hslColor.lightness,
        ).toColor(),
        HSLColor.fromAHSL(
          1.0,
          (hue + 40) % 360,
          hslColor.saturation,
          hslColor.lightness,
        ).toColor(),
      ];
    } else {
      // Create tonal palette (different lightness)
      return [
        HSLColor.fromAHSL(
          1.0,
          hue,
          hslColor.saturation,
          (hslColor.lightness + 0.3).clamp(0.0, 1.0),
        ).toColor(),
        HSLColor.fromAHSL(
          1.0,
          hue,
          hslColor.saturation,
          (hslColor.lightness + 0.15).clamp(0.0, 1.0),
        ).toColor(),
        baseColor,
        HSLColor.fromAHSL(
          1.0,
          hue,
          hslColor.saturation,
          (hslColor.lightness - 0.15).clamp(0.0, 1.0),
        ).toColor(),
        HSLColor.fromAHSL(
          1.0,
          hue,
          hslColor.saturation,
          (hslColor.lightness - 0.3).clamp(0.0, 1.0),
        ).toColor(),
      ];
    }
  }

  /// Create complementary color
  static Color getComplementary(Color color) {
    final hslColor = HSLColor.fromColor(color);
    return HSLColor.fromAHSL(
      1.0,
      (hslColor.hue + 180) % 360,
      hslColor.saturation,
      hslColor.lightness,
    ).toColor();
  }

  /// Create a linear gradient from colors
  static LinearGradient createLinearGradient(
    List<Color> colors, {
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) {
    return LinearGradient(colors: colors, begin: begin, end: end);
  }

  /// Create a radial gradient from colors
  static RadialGradient createRadialGradient(
    List<Color> colors, {
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
  }) {
    return RadialGradient(colors: colors, center: center, radius: radius);
  }
}

/// Extension to add semantic color extensions to ThemeData
extension ThemeDataColorExtension on ThemeData {
  /// Get appropriate color based on the current theme brightness
  Color colorByBrightness(Color lightColor, Color darkColor) {
    return brightness == Brightness.light ? lightColor : darkColor;
  }

  /// Get appropriate background color based on theme brightness
  Color get backgroundColor =>
      colorByBrightness(AppColors.backgroundLight, AppColors.backgroundDark);

  /// Get appropriate surface color based on theme brightness
  Color get surfaceColor =>
      colorByBrightness(AppColors.surface, AppColors.surfaceDark);

  /// Get appropriate text color based on theme brightness
  Color get textColor =>
      colorByBrightness(AppColors.textPrimary, AppColors.textPrimaryDark);

  /// Get appropriate secondary text color based on theme brightness
  Color get textSecondaryColor =>
      colorByBrightness(AppColors.textSecondary, AppColors.textSecondaryDark);
}

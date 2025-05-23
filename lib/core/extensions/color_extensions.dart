import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

extension ColorExtension on Color {
  Color withValues({int? red, int? green, int? blue, double? alpha}) {
    return Color.fromARGB(
      alpha != null ? (alpha * 255).round() : this.alpha,
      red ?? this.red,
      green ?? this.green,
      blue ?? this.blue,
    );
  }

  Color withBrightness(double factor) {
    assert(factor >= -1.0 && factor <= 1.0, 'Factor: -1.0 to 1.0');
    int r = red;
    int g = green;
    int b = blue;
    if (factor < 0) {
      r = (r * (1 + factor)).round().clamp(0, 255);
      g = (g * (1 + factor)).round().clamp(0, 255);
      b = (b * (1 + factor)).round().clamp(0, 255);
      return Color.fromARGB(alpha, r, g, b);
    }
    if (factor > 0) {
      r = (r + (255 - r) * factor).round().clamp(0, 255);
      g = (g + (255 - g) * factor).round().clamp(0, 255);
      b = (b + (255 - b) * factor).round().clamp(0, 255);
      return Color.fromARGB(alpha, r, g, b);
    }
    return this;
  }

  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    return withBrightness(-amount);
  }

  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    return withBrightness(amount);
  }

  Color mix(Color other, [double amount = 0.5]) {
    assert(amount >= 0 && amount <= 1);
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

  String toHex({bool includeAlpha = false, bool includeHash = true}) {
    String hex = includeHash ? '#' : '';
    if (includeAlpha) hex += alpha.toRadixString(16).padLeft(2, '0');
    hex += red.toRadixString(16).padLeft(2, '0');
    hex += green.toRadixString(16).padLeft(2, '0');
    hex += blue.toRadixString(16).padLeft(2, '0');
    return hex.toUpperCase();
  }

  WidgetStateColor toWidgetStateColor() {
    return WidgetStateColor.resolveWith((_) => this);
  }

  bool get isLight => computeLuminance() > 0.5;

  bool get isDark => !isLight;

  Color get contrastText =>
      isLight ? AppColors.textPrimary : AppColors.textPrimaryDark;
}

extension MaterialColorExtension on Color {
  MaterialColor toMaterialColor() {
    final int r = red, g = green, b = blue;
    return MaterialColor(value, {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1.0),
    });
  }

  MaterialColor toCustomMaterialColor() {
    Color colorFromHSL(HSLColor hsl, double lightness) =>
        hsl.withLightness(lightness.clamp(0.0, 1.0)).toColor();

    Map<int, Color> getSwatch(Color color) {
      final hsl = HSLColor.fromColor(color);
      final l = hsl.lightness;
      return {
        50: colorFromHSL(hsl, l + 0.35),
        100: colorFromHSL(hsl, l + 0.30),
        200: colorFromHSL(hsl, l + 0.25),
        300: colorFromHSL(hsl, l + 0.15),
        400: colorFromHSL(hsl, l + 0.05),
        500: colorFromHSL(hsl, l),
        600: colorFromHSL(hsl, l - 0.05),
        700: colorFromHSL(hsl, l - 0.10),
        800: colorFromHSL(hsl, l - 0.15),
        900: colorFromHSL(hsl, l - 0.20),
      };
    }

    final swatch = getSwatch(this);
    return MaterialColor(value, {
      50: swatch[50]!,
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

extension StringColorExtension on String {
  Color toColor() {
    String str = trim();
    if (str.isEmpty) return Colors.transparent;
    if (str.startsWith('#')) str = str.substring(1);
    if (str.length == 6) str = 'FF$str';
    if (str.length == 3) {
      final r = str[0], g = str[1], b = str[2];
      str = 'FF$r$r$g$g$b$b';
    }
    final value = int.tryParse(str, radix: 16);
    return value != null ? Color(value) : Colors.transparent;
  }
}

class ColorUtils {
  ColorUtils._();

  static Color getContrastingTextColor(Color bg) {
    return bg.computeLuminance() > 0.5
        ? AppColors.textPrimary
        : AppColors.textPrimaryDark;
  }

  static ColorScheme generateColorScheme(
    Color seed, {
    Brightness brightness = Brightness.light,
  }) => ColorScheme.fromSeed(seedColor: seed, brightness: brightness);

  static Color getRandomColor({int alpha = 255}) {
    final random = DateTime.now().millisecondsSinceEpoch;
    return Color((random & 0xFFFFFF) | (alpha << 24));
  }

  static HSLColor rgbToHsl(int r, int g, int b) =>
      HSLColor.fromColor(Color.fromARGB(255, r, g, b));

  static Color hslToRgb(double h, double s, double l) =>
      HSLColor.fromAHSL(1.0, h, s, l).toColor();

  static List<Color> createPalette(Color base, {bool harmonious = true}) {
    final hsl = HSLColor.fromColor(base);
    final hue = hsl.hue;
    if (harmonious) {
      return [
        HSLColor.fromAHSL(
          1,
          (hue - 40) % 360,
          hsl.saturation,
          hsl.lightness,
        ).toColor(),
        HSLColor.fromAHSL(
          1,
          (hue - 20) % 360,
          hsl.saturation,
          hsl.lightness,
        ).toColor(),
        base,
        HSLColor.fromAHSL(
          1,
          (hue + 20) % 360,
          hsl.saturation,
          hsl.lightness,
        ).toColor(),
        HSLColor.fromAHSL(
          1,
          (hue + 40) % 360,
          hsl.saturation,
          hsl.lightness,
        ).toColor(),
      ];
    }
    return [
      HSLColor.fromAHSL(
        1.0,
        hue,
        hsl.saturation,
        (hsl.lightness + 0.3).clamp(0.0, 1.0),
      ).toColor(),
      HSLColor.fromAHSL(
        1.0,
        hue,
        hsl.saturation,
        (hsl.lightness + 0.15).clamp(0.0, 1.0),
      ).toColor(),
      base,
      HSLColor.fromAHSL(
        1.0,
        hue,
        hsl.saturation,
        (hsl.lightness - 0.15).clamp(0.0, 1.0),
      ).toColor(),
      HSLColor.fromAHSL(
        1.0,
        hue,
        hsl.saturation,
        (hsl.lightness - 0.3).clamp(0.0, 1.0),
      ).toColor(),
    ];
  }

  static Color getComplementary(Color color) {
    final hsl = HSLColor.fromColor(color);
    return HSLColor.fromAHSL(
      1.0,
      (hsl.hue + 180) % 360,
      hsl.saturation,
      hsl.lightness,
    ).toColor();
  }

  static LinearGradient createLinearGradient(
    List<Color> colors, {
    AlignmentGeometry begin = Alignment.topLeft,
    AlignmentGeometry end = Alignment.bottomRight,
  }) => LinearGradient(colors: colors, begin: begin, end: end);

  static RadialGradient createRadialGradient(
    List<Color> colors, {
    AlignmentGeometry center = Alignment.center,
    double radius = 0.5,
  }) => RadialGradient(colors: colors, center: center, radius: radius);
}

extension ThemeDataColorExtension on ThemeData {
  Color colorByBrightness(Color lightColor, Color darkColor) =>
      brightness == Brightness.light ? lightColor : darkColor;

  Color get backgroundColor =>
      colorByBrightness(AppColors.backgroundLight, AppColors.backgroundDark);

  Color get surfaceColor =>
      colorByBrightness(AppColors.surface, AppColors.surfaceDark);

  Color get textColor =>
      colorByBrightness(AppColors.textPrimary, AppColors.textPrimaryDark);

  Color get textSecondaryColor =>
      colorByBrightness(AppColors.textSecondary, AppColors.textSecondaryDark);
}

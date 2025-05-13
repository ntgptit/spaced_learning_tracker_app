import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff345351),
      surfaceTint: Color(0xff456462),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4c6b69),
      onPrimaryContainer: Color(0xffc9eae7),
      secondary: Color(0xff556160),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd8e5e3),
      onSecondaryContainer: Color(0xff5b6766),
      tertiary: Color(0xff4f4a63),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff67627c),
      onTertiaryContainer: Color(0xffe7dffe),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffaf9f8),
      onSurface: Color(0xff1a1c1c),
      onSurfaceVariant: Color(0xff414847),
      outline: Color(0xff717877),
      outlineVariant: Color(0xffc1c8c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3130),
      inversePrimary: Color(0xffaccdca),
      primaryFixed: Color(0xffc7e9e6),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xffaccdca),
      onPrimaryFixedVariant: Color(0xff2d4c4a),
      secondaryFixed: Color(0xffd8e5e3),
      onSecondaryFixed: Color(0xff121e1d),
      secondaryFixedDim: Color(0xffbcc9c7),
      onSecondaryFixedVariant: Color(0xff3d4948),
      tertiaryFixed: Color(0xffe6defd),
      onTertiaryFixed: Color(0xff1c192f),
      tertiaryFixedDim: Color(0xffc9c2e0),
      onTertiaryFixedVariant: Color(0xff48445c),
      surfaceDim: Color(0xffdadad9),
      surfaceBright: Color(0xfffaf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3f2),
      surfaceContainer: Color(0xffeeeeed),
      surfaceContainerHigh: Color(0xffe8e8e7),
      surfaceContainerHighest: Color(0xffe3e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1c3b3a),
      surfaceTint: Color(0xff456462),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4c6b69),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2d3837),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff636f6e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff37334b),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff67627c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffaf9f8),
      onSurface: Color(0xff101111),
      onSurfaceVariant: Color(0xff313837),
      outline: Color(0xff4d5453),
      outlineVariant: Color(0xff676e6e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3130),
      inversePrimary: Color(0xffaccdca),
      primaryFixed: Color(0xff547371),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff3b5a58),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff636f6e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4b5756),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6f6a84),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff56526b),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc6c6c6),
      surfaceBright: Color(0xfffaf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f3f2),
      surfaceContainer: Color(0xffe8e8e7),
      surfaceContainerHigh: Color(0xffdddddc),
      surfaceContainerHighest: Color(0xffd2d1d1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff113130),
      surfaceTint: Color(0xff456462),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff304e4d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff232e2d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff404b4a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2d2940),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4a465f),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffaf9f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff272d2d),
      outlineVariant: Color(0xff434b4a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2f3130),
      inversePrimary: Color(0xffaccdca),
      primaryFixed: Color(0xff304e4d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff183836),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff404b4a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff293534),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4a465f),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff343047),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb9b9b8),
      surfaceBright: Color(0xfffaf9f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f1f0),
      surfaceContainer: Color(0xffe3e2e1),
      surfaceContainerHigh: Color(0xffd5d4d3),
      surfaceContainerHighest: Color(0xffc6c6c6),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffaccdca),
      surfaceTint: Color(0xffaccdca),
      onPrimary: Color(0xff163534),
      primaryContainer: Color(0xff4c6b69),
      onPrimaryContainer: Color(0xffc9eae7),
      secondary: Color(0xffbcc9c7),
      onSecondary: Color(0xff273332),
      secondaryContainer: Color(0xff3d4948),
      onSecondaryContainer: Color(0xffabb8b6),
      tertiary: Color(0xffc9c2e0),
      onTertiary: Color(0xff312d45),
      tertiaryContainer: Color(0xff67627c),
      onTertiaryContainer: Color(0xffe7dffe),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff121413),
      onSurface: Color(0xffe3e2e1),
      onSurfaceVariant: Color(0xffc1c8c7),
      outline: Color(0xff8b9291),
      outlineVariant: Color(0xff414847),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e1),
      inversePrimary: Color(0xff456462),
      primaryFixed: Color(0xffc7e9e6),
      onPrimaryFixed: Color(0xff00201f),
      primaryFixedDim: Color(0xffaccdca),
      onPrimaryFixedVariant: Color(0xff2d4c4a),
      secondaryFixed: Color(0xffd8e5e3),
      onSecondaryFixed: Color(0xff121e1d),
      secondaryFixedDim: Color(0xffbcc9c7),
      onSecondaryFixedVariant: Color(0xff3d4948),
      tertiaryFixed: Color(0xffe6defd),
      onTertiaryFixed: Color(0xff1c192f),
      tertiaryFixedDim: Color(0xffc9c2e0),
      onTertiaryFixedVariant: Color(0xff48445c),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff383939),
      surfaceContainerLowest: Color(0xff0d0e0e),
      surfaceContainerLow: Color(0xff1a1c1c),
      surfaceContainer: Color(0xff1e2020),
      surfaceContainerHigh: Color(0xff292a2a),
      surfaceContainerHighest: Color(0xff343535),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc1e3e0),
      surfaceTint: Color(0xffaccdca),
      onPrimary: Color(0xff092a29),
      primaryContainer: Color(0xff779794),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffd2dfdd),
      onSecondary: Color(0xff1c2827),
      secondaryContainer: Color(0xff879392),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe0d8f7),
      onTertiary: Color(0xff262339),
      tertiaryContainer: Color(0xff938da9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff121413),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd7dedc),
      outline: Color(0xffacb3b2),
      outlineVariant: Color(0xff8b9291),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e1),
      inversePrimary: Color(0xff2f4d4b),
      primaryFixed: Color(0xffc7e9e6),
      onPrimaryFixed: Color(0xff001413),
      primaryFixedDim: Color(0xffaccdca),
      onPrimaryFixedVariant: Color(0xff1c3b3a),
      secondaryFixed: Color(0xffd8e5e3),
      onSecondaryFixed: Color(0xff081312),
      secondaryFixedDim: Color(0xffbcc9c7),
      onSecondaryFixedVariant: Color(0xff2d3837),
      tertiaryFixed: Color(0xffe6defd),
      onTertiaryFixed: Color(0xff120e24),
      tertiaryFixedDim: Color(0xffc9c2e0),
      onTertiaryFixedVariant: Color(0xff37334b),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff434544),
      surfaceContainerLowest: Color(0xff060807),
      surfaceContainerLow: Color(0xff1c1e1e),
      surfaceContainer: Color(0xff272828),
      surfaceContainerHigh: Color(0xff313332),
      surfaceContainerHighest: Color(0xff3c3e3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd5f7f4),
      surfaceTint: Color(0xffaccdca),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa8c9c6),
      onPrimaryContainer: Color(0xff000e0d),
      secondary: Color(0xffe6f3f1),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb8c5c4),
      onSecondaryContainer: Color(0xff030d0d),
      tertiary: Color(0xfff3edff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc5bfdc),
      onTertiaryContainer: Color(0xff0c081d),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff121413),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeaf1f0),
      outlineVariant: Color(0xffbdc4c3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe3e2e1),
      inversePrimary: Color(0xff2f4d4b),
      primaryFixed: Color(0xffc7e9e6),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffaccdca),
      onPrimaryFixedVariant: Color(0xff001413),
      secondaryFixed: Color(0xffd8e5e3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbcc9c7),
      onSecondaryFixedVariant: Color(0xff081312),
      tertiaryFixed: Color(0xffe6defd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc9c2e0),
      onTertiaryFixedVariant: Color(0xff120e24),
      surfaceDim: Color(0xff121413),
      surfaceBright: Color(0xff4f5050),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1e2020),
      surfaceContainer: Color(0xff2f3130),
      surfaceContainerHigh: Color(0xff3a3c3b),
      surfaceContainerHighest: Color(0xff464747),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

import 'package:flutter/material.dart';
import 'package:slt_app/core/theme/app_colors.dart';
import 'package:slt_app/core/theme/app_dimens.dart';

/// App typography
/// All text styles are defined here to ensure consistency across the app
class AppTypography {
  static const String fontFamily = 'Poppins';

  // Base text styles
  static TextStyle _baseTextStyle(
      double fontSize,
      FontWeight fontWeight,
      Color color,
      double? height,
      TextDecoration? decoration,
      double? letterSpacing,
      ) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }

  // Light Theme Text Styles
  static TextStyle get displayLarge => _baseTextStyle(
    AppDimens.fontSizeDisplay,
    FontWeight.bold,
    AppColors.textPrimary,
    1.2,
    null,
    -0.5,
  );

  static TextStyle get displayMedium => _baseTextStyle(
    AppDimens.fontSizeHeadline,
    FontWeight.bold,
    AppColors.textPrimary,
    1.2,
    null,
    -0.25,
  );

  static TextStyle get displaySmall => _baseTextStyle(
    AppDimens.fontSizeTitle,
    FontWeight.w600,
    AppColors.textPrimary,
    1.2,
    null,
    0,
  );

  static TextStyle get headlineLarge => _baseTextStyle(
    AppDimens.fontSizeXXL,
    FontWeight.w600,
    AppColors.textPrimary,
    1.3,
    null,
    0,
  );

  static TextStyle get headlineMedium => _baseTextStyle(
    AppDimens.fontSizeXL,
    FontWeight.w600,
    AppColors.textPrimary,
    1.3,
    null,
    0,
  );

  static TextStyle get headlineSmall => _baseTextStyle(
    AppDimens.fontSizeL,
    FontWeight.w600,
    AppColors.textPrimary,
    1.3,
    null,
    0,
  );

  static TextStyle get titleLarge => _baseTextStyle(
    AppDimens.fontSizeL,
    FontWeight.w600,
    AppColors.textPrimary,
    1.3,
    null,
    0,
  );

  static TextStyle get titleMedium => _baseTextStyle(
    AppDimens.fontSizeM,
    FontWeight.w600,
    AppColors.textPrimary,
    1.3,
    null,
    0,
  );

  static TextStyle get titleSmall => _baseTextStyle(
    AppDimens.fontSizeS,
    FontWeight.w600,
    AppColors.textPrimary,
    1.3,
    null,
    0,
  );

  static TextStyle get bodyLarge => _baseTextStyle(
    AppDimens.fontSizeL,
    FontWeight.normal,
    AppColors.textPrimary,
    1.5,
    null,
    0.25,
  );

  static TextStyle get bodyMedium => _baseTextStyle(
    AppDimens.fontSizeM,
    FontWeight.normal,
    AppColors.textPrimary,
    1.5,
    null,
    0.25,
  );

  static TextStyle get bodySmall => _baseTextStyle(
    AppDimens.fontSizeS,
    FontWeight.normal,
    AppColors.textSecondary,
    1.5,
    null,
    0.4,
  );

  static TextStyle get labelLarge => _baseTextStyle(
    AppDimens.fontSizeM,
    FontWeight.w500,
    AppColors.textPrimary,
    1.4,
    null,
    0.1,
  );

  static TextStyle get labelMedium => _baseTextStyle(
    AppDimens.fontSizeS,
    FontWeight.w500,
    AppColors.textPrimary,
    1.4,
    null,
    0.5,
  );

  static TextStyle get labelSmall => _baseTextStyle(
    AppDimens.fontSizeXS,
    FontWeight.w500,
    AppColors.textSecondary,
    1.4,
    null,
    0.5,
  );

  // Dark Theme Text Styles
  static TextStyle get displayLargeDark => displayLarge.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get displayMediumDark => displayMedium.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get displaySmallDark => displaySmall.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get headlineLargeDark => headlineLarge.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get headlineMediumDark => headlineMedium.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get headlineSmallDark => headlineSmall.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get titleLargeDark => titleLarge.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get titleMediumDark => titleMedium.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get titleSmallDark => titleSmall.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get bodyLargeDark => bodyLarge.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get bodyMediumDark => bodyMedium.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get bodySmallDark => bodySmall.copyWith(color: AppColors.textSecondaryDark);
  static TextStyle get labelLargeDark => labelLarge.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get labelMediumDark => labelMedium.copyWith(color: AppColors.textPrimaryDark);
  static TextStyle get labelSmallDark => labelSmall.copyWith(color: AppColors.textSecondaryDark);

  // Get text style based on theme mode
  static TextStyle getTextStyle(TextStyle lightStyle, TextStyle darkStyle, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return lightStyle;
      case ThemeMode.dark:
        return darkStyle;
      case ThemeMode.system:
      // This should be adjusted based on platform brightness in real usage
        return lightStyle;
    }
  }
}
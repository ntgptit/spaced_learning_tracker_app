import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dimens.dart';

class AppTypography {
  static const String fontFamily = 'Poppins';

  static TextStyle _baseTextStyle(
    double fontSize,
    FontWeight fontWeight,
    Color color, {
    double? height,
    TextDecoration? decoration,
    double? letterSpacing,
  }) {
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

  static TextStyle get displayLarge => _baseTextStyle(
    AppDimens.fontDisplayL,
    FontWeight.w700,
    AppColors.textPrimary,
    height: 1.15,
    letterSpacing: -0.5,
  );

  static TextStyle get displayMedium => _baseTextStyle(
    AppDimens.fontDisplayM,
    FontWeight.w700,
    AppColors.textPrimary,
    height: 1.15,
    letterSpacing: -0.25,
  );

  static TextStyle get displaySmall => _baseTextStyle(
    AppDimens.fontDisplayS,
    FontWeight.w600,
    AppColors.textPrimary,
    height: 1.15,
    letterSpacing: 0,
  );

  static TextStyle get headlineLarge => _baseTextStyle(
    AppDimens.fontHeadlineL,
    FontWeight.w600,
    AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0,
  );

  static TextStyle get headlineMedium => _baseTextStyle(
    AppDimens.fontHeadlineM,
    FontWeight.w600,
    AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0,
  );

  static TextStyle get headlineSmall => _baseTextStyle(
    AppDimens.fontHeadlineS,
    FontWeight.w600,
    AppColors.textPrimary,
    height: 1.2,
    letterSpacing: 0,
  );

  static TextStyle get titleLarge => _baseTextStyle(
    AppDimens.fontTitleL,
    FontWeight.w500,
    AppColors.textPrimary,
    height: 1.3,
    letterSpacing: 0,
  );

  static TextStyle get titleMedium => _baseTextStyle(
    AppDimens.fontTitleM,
    FontWeight.w500,
    AppColors.textPrimary,
    height: 1.3,
    letterSpacing: 0.15,
  );

  static TextStyle get titleSmall => _baseTextStyle(
    AppDimens.fontTitleS,
    FontWeight.w500,
    AppColors.textPrimary,
    height: 1.3,
    letterSpacing: 0.1,
  );

  static TextStyle get bodyLarge => _baseTextStyle(
    AppDimens.fontBodyL,
    FontWeight.w400,
    AppColors.textPrimary,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => _baseTextStyle(
    AppDimens.fontBodyM,
    FontWeight.w400,
    AppColors.textPrimary,
    height: 1.5,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => _baseTextStyle(
    AppDimens.fontBodyS,
    FontWeight.w400,
    AppColors.textSecondary,
    height: 1.5,
    letterSpacing: 0.4,
  );

  static TextStyle get labelLarge => _baseTextStyle(
    AppDimens.fontLabelL,
    FontWeight.w500,
    AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => _baseTextStyle(
    AppDimens.fontLabelM,
    FontWeight.w500,
    AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => _baseTextStyle(
    AppDimens.fontLabelS,
    FontWeight.w500,
    AppColors.textSecondary,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle get displayLargeDark =>
      displayLarge.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get displayMediumDark =>
      displayMedium.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get displaySmallDark =>
      displaySmall.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get headlineLargeDark =>
      headlineLarge.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get headlineMediumDark =>
      headlineMedium.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get headlineSmallDark =>
      headlineSmall.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get titleLargeDark =>
      titleLarge.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get titleMediumDark =>
      titleMedium.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get titleSmallDark =>
      titleSmall.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get bodyLargeDark =>
      bodyLarge.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get bodyMediumDark =>
      bodyMedium.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get bodySmallDark =>
      bodySmall.copyWith(color: AppColors.textSecondaryDark);

  static TextStyle get labelLargeDark =>
      labelLarge.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get labelMediumDark =>
      labelMedium.copyWith(color: AppColors.textPrimaryDark);

  static TextStyle get labelSmallDark =>
      labelSmall.copyWith(color: AppColors.textSecondaryDark);

  static TextStyle getTextStyle(
    TextStyle lightStyle,
    TextStyle darkStyle,
    ThemeMode mode,
  ) {
    switch (mode) {
      case ThemeMode.light:
        return lightStyle;
      case ThemeMode.dark:
        return darkStyle;
      case ThemeMode.system:
        return lightStyle; // Adjust based on platform brightness in real usage
    }
  }

  AppTypography._();
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_typography.dart';

/// App theme configuration for light and dark modes
class AppTheme {
  static ThemeData get lightTheme => _buildTheme(Brightness.light);

  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: _buildColorScheme(isLight),
      scaffoldBackgroundColor: isLight
          ? AppColors.backgroundLight
          : AppColors.backgroundDark,
      appBarTheme: _buildAppBarTheme(isLight),
      cardTheme: _buildCardTheme(isLight),
      listTileTheme: _buildListTileTheme(isLight),
      dialogTheme: _buildDialogTheme(isLight),
      bottomSheetTheme: _buildBottomSheetTheme(isLight),
      textTheme: _buildTextTheme(isLight),
      inputDecorationTheme: _buildInputDecorationTheme(isLight),
      elevatedButtonTheme: _buildElevatedButtonTheme(isLight),
      textButtonTheme: _buildTextButtonTheme(isLight),
      outlinedButtonTheme: _buildOutlinedButtonTheme(isLight),
      iconButtonTheme: _buildIconButtonTheme(isLight),
      tabBarTheme: _buildTabBarTheme(isLight),
      checkboxTheme: _buildCheckboxTheme(isLight),
      radioTheme: _buildRadioTheme(isLight),
      switchTheme: _buildSwitchTheme(isLight),
      dividerTheme: _buildDividerTheme(isLight),
      chipTheme: _buildChipTheme(isLight),
      bottomNavigationBarTheme: _buildBottomNavigationBarTheme(isLight),
      snackBarTheme: _buildSnackBarTheme(isLight),
      progressIndicatorTheme: _buildProgressIndicatorTheme(isLight),
      tooltipTheme: _buildTooltipTheme(isLight),
    );
  }

  static ColorScheme _buildColorScheme(bool isLight) {
    if (isLight) {
      return const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: AppColors.secondaryDark,
        error: AppColors.error,
        onError: Colors.white,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.backgroundLight,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.divider,
        shadow: AppColors.shadow,
      );
    }

    return const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      onPrimary: Colors.black,
      primaryContainer: AppColors.primary,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.black,
      secondaryContainer: AppColors.secondary,
      onSecondaryContainer: Colors.white,
      error: AppColors.errorDark,
      onError: Colors.black,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      surfaceContainerHighest: AppColors.backgroundDark,
      onSurfaceVariant: AppColors.textSecondaryDark,
      outline: AppColors.dividerDark,
      shadow: AppColors.shadowDark,
    );
  }

  static AppBarTheme _buildAppBarTheme(bool isLight) {
    if (isLight) {
      return AppBarTheme(
        elevation: AppDimens.elevationNone,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: Colors.white),
        toolbarHeight: AppDimens.appBarHeight,
        centerTitle: false,
      );
    }

    return AppBarTheme(
      elevation: AppDimens.elevationNone,
      backgroundColor: AppColors.surfaceDark,
      foregroundColor: AppColors.textPrimaryDark,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: AppTypography.titleLargeDark,
      toolbarHeight: AppDimens.appBarHeight,
      centerTitle: false,
    );
  }

  static CardThemeData _buildCardTheme(bool isLight) {
    return CardThemeData(
      elevation: AppDimens.elevationS,
      color: isLight ? AppColors.cardLight : AppColors.cardDark,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
      ),
    );
  }

  static ListTileThemeData _buildListTileTheme(bool isLight) {
    return ListTileThemeData(
      contentPadding: AppDimens.listTilePadding,
      dense: false,
      horizontalTitleGap: AppDimens.gapS,
      minLeadingWidth: 24,
      tileColor: isLight ? AppColors.surface : AppColors.surfaceDark,
    );
  }

  static DialogThemeData _buildDialogTheme(bool isLight) {
    return DialogThemeData(
      elevation: AppDimens.elevationM,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.dialogBorderRadius),
      ),
      backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
      titleTextStyle: isLight
          ? AppTypography.titleLarge
          : AppTypography.titleLargeDark,
      contentTextStyle: isLight
          ? AppTypography.bodyMedium
          : AppTypography.bodyMediumDark,
    );
  }

  static BottomSheetThemeData _buildBottomSheetTheme(bool isLight) {
    return BottomSheetThemeData(
      elevation: AppDimens.elevationM,
      backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimens.bottomSheetBorderRadius),
          topRight: Radius.circular(AppDimens.bottomSheetBorderRadius),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(bool isLight) {
    if (isLight) {
      return TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        displaySmall: AppTypography.displaySmall,
        headlineLarge: AppTypography.headlineLarge,
        headlineMedium: AppTypography.headlineMedium,
        headlineSmall: AppTypography.headlineSmall,
        titleLarge: AppTypography.titleLarge,
        titleMedium: AppTypography.titleMedium,
        titleSmall: AppTypography.titleSmall,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      );
    }

    return TextTheme(
      displayLarge: AppTypography.displayLargeDark,
      displayMedium: AppTypography.displayMediumDark,
      displaySmall: AppTypography.displaySmallDark,
      headlineLarge: AppTypography.headlineLargeDark,
      headlineMedium: AppTypography.headlineMediumDark,
      headlineSmall: AppTypography.headlineSmall,
      titleLarge: AppTypography.titleLargeDark,
      titleMedium: AppTypography.titleMediumDark,
      titleSmall: AppTypography.titleSmallDark,
      bodyLarge: AppTypography.bodyLargeDark,
      bodyMedium: AppTypography.bodyMediumDark,
      bodySmall: AppTypography.bodySmallDark,
      labelLarge: AppTypography.labelLargeDark,
      labelMedium: AppTypography.labelMediumDark,
      labelSmall: AppTypography.labelSmallDark,
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(bool isLight) {
    return InputDecorationTheme(
      filled: true,
      fillColor: isLight ? AppColors.surface : AppColors.surfaceDark,
      contentPadding: AppDimens.inputPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.divider : AppColors.dividerDark,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.divider : AppColors.dividerDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.primary : AppColors.primaryLight,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.error : AppColors.errorDark,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.error : AppColors.errorDark,
          width: 2,
        ),
      ),
      labelStyle:
          (isLight ? AppTypography.bodyMedium : AppTypography.bodyMediumDark)
              .copyWith(
                color: isLight
                    ? AppColors.textSecondary
                    : AppColors.textSecondaryDark,
              ),
      floatingLabelStyle:
          (isLight ? AppTypography.bodyMedium : AppTypography.bodyMediumDark)
              .copyWith(
                color: isLight ? AppColors.primary : AppColors.primaryLight,
              ),
      hintStyle:
          (isLight ? AppTypography.bodyMedium : AppTypography.bodyMediumDark)
              .copyWith(color: AppColors.opacityHintText),
      errorStyle:
          (isLight ? AppTypography.bodySmall : AppTypography.bodySmallDark)
              .copyWith(color: isLight ? AppColors.error : AppColors.errorDark),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(bool isLight) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppDimens.elevationS,
        padding: AppDimens.buttonPadding,
        foregroundColor: isLight ? Colors.white : Colors.black,
        backgroundColor: isLight ? AppColors.primary : AppColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
        ),
        minimumSize: const Size(88, AppDimens.buttonHeightM),
        textStyle: AppTypography.labelLarge.copyWith(
          color: isLight ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme(bool isLight) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: AppDimens.buttonPadding,
        foregroundColor: isLight ? AppColors.primary : AppColors.primaryLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
        ),
        textStyle: isLight
            ? AppTypography.labelLarge
            : AppTypography.labelLargeDark,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(bool isLight) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: AppDimens.buttonPadding,
        foregroundColor: isLight ? AppColors.primary : AppColors.primaryLight,
        side: BorderSide(
          color: isLight ? AppColors.primary : AppColors.primaryLight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
        ),
        minimumSize: const Size(88, AppDimens.buttonHeightM),
        textStyle: isLight
            ? AppTypography.labelLarge
            : AppTypography.labelLargeDark,
      ),
    );
  }

  static IconButtonThemeData _buildIconButtonTheme(bool isLight) {
    return IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: isLight
            ? AppColors.textPrimary
            : AppColors.textPrimaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusS),
        ),
      ),
    );
  }

  static TabBarThemeData _buildTabBarTheme(bool isLight) {
    return TabBarThemeData(
      labelColor: isLight ? AppColors.primary : AppColors.primaryLight,
      unselectedLabelColor: isLight
          ? AppColors.textSecondary
          : AppColors.textSecondaryDark,
      indicatorColor: isLight ? AppColors.primary : AppColors.primaryLight,
      labelStyle: isLight
          ? AppTypography.labelLarge
          : AppTypography.labelLargeDark,
      unselectedLabelStyle: isLight
          ? AppTypography.labelLarge
          : AppTypography.labelLargeDark,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  static CheckboxThemeData _buildCheckboxTheme(bool isLight) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isLight ? AppColors.primary : AppColors.primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(
        isLight ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusXS),
      ),
      side: BorderSide(
        color: isLight ? AppColors.textSecondary : AppColors.textSecondaryDark,
      ),
    );
  }

  static RadioThemeData _buildRadioTheme(bool isLight) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isLight ? AppColors.primary : AppColors.primaryLight;
        }
        return isLight ? AppColors.textSecondary : AppColors.textSecondaryDark;
      }),
    );
  }

  static SwitchThemeData _buildSwitchTheme(bool isLight) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isLight ? AppColors.primary : AppColors.primaryLight;
        }
        return isLight ? Colors.white : Colors.grey.shade400;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return (isLight ? AppColors.primary : AppColors.primaryLight)
              .withOpacity(AppDimens.opacityMediumHigh);
        }
        return Colors.grey.withOpacity(AppDimens.opacityMedium);
      }),
    );
  }

  static DividerThemeData _buildDividerTheme(bool isLight) {
    return DividerThemeData(
      color: isLight ? AppColors.divider : AppColors.dividerDark,
      space: AppDimens.dividerThickness,
      thickness: AppDimens.dividerThickness,
    );
  }

  static ChipThemeData _buildChipTheme(bool isLight) {
    return ChipThemeData(
      backgroundColor: (isLight ? AppColors.primary : AppColors.primaryLight)
          .withOpacity(AppDimens.opacityLight),
      deleteIconColor: isLight ? AppColors.primary : AppColors.primaryLight,
      labelStyle:
          (isLight ? AppTypography.labelMedium : AppTypography.labelMediumDark)
              .copyWith(
                color: isLight ? AppColors.primary : AppColors.primaryLight,
              ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingS,
        vertical: AppDimens.paddingXS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusS),
      ),
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavigationBarTheme(
    bool isLight,
  ) {
    return BottomNavigationBarThemeData(
      backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
      selectedItemColor: isLight ? AppColors.primary : AppColors.primaryLight,
      unselectedItemColor: isLight
          ? AppColors.textSecondary
          : AppColors.textSecondaryDark,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: isLight
          ? AppTypography.labelSmall
          : AppTypography.labelSmallDark,
      unselectedLabelStyle: isLight
          ? AppTypography.labelSmall
          : AppTypography.labelSmallDark,
      elevation: AppDimens.elevationM,
    );
  }

  static SnackBarThemeData _buildSnackBarTheme(bool isLight) {
    return SnackBarThemeData(
      backgroundColor: isLight
          ? AppColors.textPrimary
          : AppColors.textPrimaryDark,
      contentTextStyle:
          (isLight ? AppTypography.bodyMedium : AppTypography.bodyMediumDark)
              .copyWith(color: isLight ? Colors.white : Colors.black),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
      ),
    );
  }

  static ProgressIndicatorThemeData _buildProgressIndicatorTheme(bool isLight) {
    return ProgressIndicatorThemeData(
      color: isLight ? AppColors.primary : AppColors.primaryLight,
      circularTrackColor: (isLight ? AppColors.primaryLight : AppColors.primary)
          .withOpacity(AppDimens.opacityLight),
      linearTrackColor: (isLight ? AppColors.primaryLight : AppColors.primary)
          .withOpacity(AppDimens.opacityLight),
    );
  }

  static TooltipThemeData _buildTooltipTheme(bool isLight) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: (isLight ? AppColors.textPrimary : AppColors.textPrimaryDark)
            .withOpacity(AppDimens.opacityVeryHigh),
        borderRadius: BorderRadius.circular(AppDimens.radiusS),
      ),
      textStyle:
          (isLight ? AppTypography.bodySmall : AppTypography.bodySmallDark)
              .copyWith(color: isLight ? Colors.white : Colors.black),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingS,
        vertical: AppDimens.paddingXS,
      ),
    );
  }
}

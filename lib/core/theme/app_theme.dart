import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_dimens.dart';
import 'app_typography.dart';

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
      extensions: [_buildSemanticColorExtension(isLight)],
      splashFactory: InkRipple.splashFactory,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }

  static ColorScheme _buildColorScheme(bool isLight) {
    if (isLight) {
      return ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: AppColors.secondaryDark,
        tertiary: AppColors.info,
        onTertiary: Colors.white,
        tertiaryContainer: AppColors.info.withValues(alpha: 0.2),
        onTertiaryContainer: AppColors.info,
        error: AppColors.error,
        onError: Colors.white,
        errorContainer: AppColors.error.withValues(alpha: 0.1),
        onErrorContainer: AppColors.error,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.outline,
        outlineVariant: AppColors.outlineVariant,
        shadow: AppColors.shadow,
        scrim: Colors.black.withValues(alpha: 0.4),
        inverseSurface: AppColors.surfaceDark,
        onInverseSurface: AppColors.textPrimaryDark,
        inversePrimary: AppColors.primaryLight,
        surfaceTint: AppColors.surfaceTint,
        surfaceContainerLowest: AppColors.surfaceContainerLowest,
        surfaceContainerLow: AppColors.surfaceContainerLow,
        surfaceContainer: AppColors.surfaceContainer,
        surfaceContainerHigh: AppColors.surfaceContainerHigh,
        surfaceContainerHighest: AppColors.surfaceContainerHighest,
      );
    }

    return ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryLight,
      onPrimary: Colors.black,
      primaryContainer: AppColors.primary,
      onPrimaryContainer: Colors.white,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.black,
      secondaryContainer: AppColors.secondary,
      onSecondaryContainer: Colors.white,
      tertiary: AppColors.infoDark,
      onTertiary: Colors.black,
      tertiaryContainer: AppColors.infoDark.withValues(alpha: 0.2),
      onTertiaryContainer: AppColors.infoDark,
      error: AppColors.errorDark,
      onError: Colors.black,
      errorContainer: AppColors.errorDark.withValues(alpha: 0.1),
      onErrorContainer: AppColors.errorDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      onSurfaceVariant: AppColors.textSecondaryDark,
      outline: AppColors.outlineDark,
      outlineVariant: AppColors.outlineVariantDark,
      shadow: AppColors.shadowDark,
      scrim: Colors.black.withValues(alpha: 0.6),
      inverseSurface: AppColors.surface,
      onInverseSurface: AppColors.textPrimary,
      inversePrimary: AppColors.primary,
      surfaceTint: AppColors.surfaceTintDark,
      surfaceContainerLowest: AppColors.surfaceContainerLowestDark,
      surfaceContainerLow: AppColors.surfaceContainerLowDark,
      surfaceContainer: AppColors.surfaceContainerDark,
      surfaceContainerHigh: AppColors.surfaceContainerHighDark,
      surfaceContainerHighest: AppColors.surfaceContainerHighestDark,
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
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
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
      iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
      actionsIconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
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
      surfaceTintColor: Colors.transparent,
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }

  static ListTileThemeData _buildListTileTheme(bool isLight) {
    final colorScheme = _buildColorScheme(
      isLight,
    ); // Lấy colorScheme dựa trên isLight

    return ListTileThemeData(
      contentPadding: AppDimens.listTilePadding,
      dense: false,
      horizontalTitleGap: AppDimens.spaceS,
      minLeadingWidth: AppDimens.iconM,
      tileColor: isLight ? AppColors.surface : AppColors.surfaceDark,
      selectedTileColor: isLight
          ? colorScheme.primaryContainer.withValues(
              alpha: AppDimens.opacitySemi,
            ) // Sử dụng opacitySemi từ AppDimens
          : colorScheme.primaryContainer.withValues(
              alpha: AppDimens.opacitySemi,
            ),
      iconColor: isLight ? colorScheme.primary : colorScheme.primary,
      textColor: isLight ? colorScheme.onSurface : colorScheme.onSurface,
      selectedColor: isLight ? colorScheme.primary : colorScheme.primary,
      minVerticalPadding: AppDimens.paddingS,
      visualDensity: VisualDensity.standard, // M3 default
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
      surfaceTintColor: Colors.transparent,
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingM,
      ),
    );
  }

  static BottomSheetThemeData _buildBottomSheetTheme(bool isLight) {
    return BottomSheetThemeData(
      elevation: AppDimens.elevationM,
      backgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
      modalBackgroundColor: isLight ? AppColors.surface : AppColors.surfaceDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimens.bottomSheetBorderRadius),
          topRight: Radius.circular(AppDimens.bottomSheetBorderRadius),
        ),
      ),
      surfaceTintColor: Colors.transparent,
      dragHandleColor: isLight
          ? AppColors.textSecondary.withValues(alpha: 0.4)
          : AppColors.textSecondaryDark.withValues(alpha: 0.4),
      dragHandleSize: const Size(32, 4),
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
      headlineSmall: AppTypography.headlineSmallDark,
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
      fillColor: isLight
          ? AppColors.surfaceContainerLowest
          : AppColors.surfaceContainerLowestDark,
      contentPadding: AppDimens.inputPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.outline : AppColors.outlineDark,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.outline : AppColors.outlineDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        borderSide: BorderSide(
          color: isLight ? AppColors.primary : AppColors.primaryLight,
          width: AppDimens.borderWidthFocused,
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
          width: AppDimens.borderWidthFocused,
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
              .copyWith(
                color:
                    (isLight
                            ? AppColors.textSecondary
                            : AppColors.textSecondaryDark)
                        .withValues(alpha: AppDimens.opacityHintText),
              ),
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
          fontWeight: FontWeight.w500,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
        textStyle:
            (isLight ? AppTypography.labelLarge : AppTypography.labelLargeDark)
                .copyWith(fontWeight: FontWeight.w500),
        minimumSize: const Size(64, AppDimens.buttonHeightM),
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
          width: AppDimens.outlineButtonBorderWidth,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
        ),
        minimumSize: const Size(88, AppDimens.buttonHeightM),
        textStyle:
            (isLight ? AppTypography.labelLarge : AppTypography.labelLargeDark)
                .copyWith(fontWeight: FontWeight.w500),
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
        minimumSize: const Size(AppDimens.iconL, AppDimens.iconL),
        tapTargetSize: MaterialTapTargetSize.padded,
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
          ? AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600)
          : AppTypography.labelLargeDark.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle: isLight
          ? AppTypography.labelLarge
          : AppTypography.labelLargeDark,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.pressed)) {
          return (isLight ? AppColors.primary : AppColors.primaryLight)
              .withValues(alpha: 0.1);
        }
        return Colors.transparent;
      }),
    );
  }

  static CheckboxThemeData _buildCheckboxTheme(bool isLight) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isLight ? AppColors.primary : AppColors.primaryLight;
        }
        if (states.contains(WidgetState.disabled)) {
          return isLight ? AppColors.textDisabled : AppColors.textDisabledDark;
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
        width: 1.5,
      ),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
    );
  }

  static RadioThemeData _buildRadioTheme(bool isLight) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isLight ? AppColors.primary : AppColors.primaryLight;
        }
        if (states.contains(WidgetState.disabled)) {
          return isLight ? AppColors.textDisabled : AppColors.textDisabledDark;
        }
        return isLight ? AppColors.textSecondary : AppColors.textSecondaryDark;
      }),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
    );
  }

  static SwitchThemeData _buildSwitchTheme(bool isLight) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return isLight ? AppColors.primary : AppColors.primaryLight;
        }
        if (states.contains(WidgetState.disabled)) {
          return isLight ? Colors.grey.shade400 : Colors.grey.shade700;
        }
        return isLight ? Colors.white : Colors.grey.shade400;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return (isLight ? AppColors.primary : AppColors.primaryLight)
              .withValues(alpha: AppDimens.opacityMediumHigh);
        }
        if (states.contains(WidgetState.disabled)) {
          return isLight ? Colors.grey.shade300 : Colors.grey.shade800;
        }
        return Colors.grey.withValues(alpha: AppDimens.opacityMedium);
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return null; // No outline for selected state
        }
        if (states.contains(WidgetState.disabled)) {
          return null; // No outline for disabled state
        }
        return Colors.grey.withValues(
          alpha: 0.5,
        ); // Subtle outline for inactive state
      }),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }

  static DividerThemeData _buildDividerTheme(bool isLight) {
    return DividerThemeData(
      color: isLight ? AppColors.divider : AppColors.dividerDark,
      space: AppDimens.dividerThickness,
      thickness: AppDimens.dividerThickness,
      indent: 0,
      endIndent: 0,
    );
  }

  static ChipThemeData _buildChipTheme(bool isLight) {
    return ChipThemeData(
      backgroundColor: (isLight
          ? AppColors.surfaceContainerHighest
          : AppColors.surfaceContainerHighestDark),
      deleteIconColor: isLight ? AppColors.primary : AppColors.primaryLight,
      disabledColor: isLight ? Colors.grey.shade200 : Colors.grey.shade800,
      selectedColor: isLight
          ? AppColors.primary.withValues(alpha: 0.15)
          : AppColors.primaryLight.withValues(alpha: 0.15),
      labelStyle:
          (isLight ? AppTypography.labelMedium : AppTypography.labelMediumDark)
              .copyWith(
                color: isLight
                    ? AppColors.textPrimary
                    : AppColors.textPrimaryDark,
              ),
      secondaryLabelStyle:
          (isLight ? AppTypography.labelMedium : AppTypography.labelMediumDark)
              .copyWith(
                color: isLight
                    ? AppColors.textSecondary
                    : AppColors.textSecondaryDark,
              ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingS,
        vertical: AppDimens.paddingXS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusS),
        side: BorderSide(
          color: isLight
              ? AppColors.outline.withValues(alpha: 0.5)
              : AppColors.outlineDark.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      side: BorderSide(
        color: isLight
            ? AppColors.outline.withValues(alpha: 0.5)
            : AppColors.outlineDark.withValues(alpha: 0.5),
        width: 1,
      ),
      selectedShadowColor: isLight ? AppColors.shadow : AppColors.shadowDark,
      showCheckmark: true,
      checkmarkColor: isLight ? AppColors.primary : AppColors.primaryLight,
      brightness: isLight ? Brightness.light : Brightness.dark,
      elevation: 0,
      pressElevation: 0,
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
      selectedLabelStyle:
          (isLight ? AppTypography.labelSmall : AppTypography.labelSmallDark)
              .copyWith(fontWeight: FontWeight.w500),
      unselectedLabelStyle: isLight
          ? AppTypography.labelSmall
          : AppTypography.labelSmallDark,
      elevation: AppDimens.elevationM,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      enableFeedback: true,
    );
  }

  static SnackBarThemeData _buildSnackBarTheme(bool isLight) {
    return SnackBarThemeData(
      backgroundColor: isLight
          ? AppColors.surfaceContainerHighest
          : AppColors.surfaceContainerHighestDark,
      contentTextStyle:
          (isLight ? AppTypography.bodyMedium : AppTypography.bodyMediumDark)
              .copyWith(
                color: isLight
                    ? AppColors.textPrimary
                    : AppColors.textPrimaryDark,
              ),
      actionTextColor: isLight ? AppColors.primary : AppColors.primaryLight,
      elevation: AppDimens.elevationM,
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
          .withValues(alpha: AppDimens.opacityLight),
      linearTrackColor: (isLight ? AppColors.primaryLight : AppColors.primary)
          .withValues(alpha: AppDimens.opacityLight),
      linearMinHeight: AppDimens.lineProgressHeight,
      refreshBackgroundColor: isLight
          ? AppColors.surfaceContainerLow
          : AppColors.surfaceContainerLowDark,
    );
  }

  static TooltipThemeData _buildTooltipTheme(bool isLight) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: isLight
            ? AppColors.surfaceContainerHighest
            : AppColors.surfaceContainerHighestDark,
        borderRadius: BorderRadius.circular(AppDimens.radiusS),
        boxShadow: [
          BoxShadow(
            color: isLight ? AppColors.shadow : AppColors.shadowDark,
            blurRadius: AppDimens.shadowRadiusS,
            offset: const Offset(0, AppDimens.shadowOffsetS),
          ),
        ],
      ),
      textStyle:
          (isLight ? AppTypography.bodySmall : AppTypography.bodySmallDark)
              .copyWith(
                color: isLight
                    ? AppColors.textPrimary
                    : AppColors.textPrimaryDark,
              ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingS,
        vertical: AppDimens.paddingXS,
      ),
      preferBelow: true,
      verticalOffset: 10,
      showDuration: const Duration(milliseconds: 1500),
    );
  }

  static SemanticColorExtension _buildSemanticColorExtension(bool isLight) {
    return isLight
        ? SemanticColorExtension.light()
        : SemanticColorExtension.dark();
  }

  static ThemeData getThemeByBrightness(Brightness brightness) {
    return brightness == Brightness.light ? lightTheme : darkTheme;
  }

  static ThemeData getTheme(bool isDark) {
    return isDark ? darkTheme : lightTheme;
  }

  static ThemeData createThemeFromSeed({
    required Color seedColor,
    required Brightness brightness,
  }) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    final bool isLight = brightness == Brightness.light;

    final ThemeData baseTheme = isLight ? lightTheme : darkTheme;

    return baseTheme.copyWith(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: baseTheme.appBarTheme.copyWith(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: baseTheme.elevatedButtonTheme.style?.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? colorScheme.primary.withValues(
                    alpha: AppDimens.opacityDisabled,
                  )
                : colorScheme.primary,
          ),
          foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: baseTheme.textButtonTheme.style?.copyWith(
          foregroundColor: WidgetStateProperty.all(colorScheme.primary),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: baseTheme.outlinedButtonTheme.style?.copyWith(
          foregroundColor: WidgetStateProperty.all(colorScheme.primary),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.disabled)
                  ? colorScheme.primary.withValues(
                      alpha: AppDimens.opacityDisabled,
                    )
                  : colorScheme.primary,
              width: AppDimens.outlineButtonBorderWidth,
            ),
          ),
        ),
      ),
      chipTheme: baseTheme.chipTheme.copyWith(
        selectedColor: colorScheme.primary.withValues(alpha: 0.15),
        checkmarkColor: colorScheme.primary,
      ),
      progressIndicatorTheme: baseTheme.progressIndicatorTheme.copyWith(
        color: colorScheme.primary,
      ),
      tabBarTheme: baseTheme.tabBarTheme.copyWith(
        labelColor: colorScheme.primary,
        indicatorColor: colorScheme.primary,
      ),
    );
  }
}

class SemanticColorExtension extends ThemeExtension<SemanticColorExtension> {
  final Color excellentColor;
  final Color goodColor;
  final Color averageColor;
  final Color belowAverageColor;
  final Color poorColor;

  final Color successColor;
  final Color warningColor;
  final Color errorColor;
  final Color infoColor;
  final Color neutralColor;

  final Color disabledColor;
  final Color highlightColor;
  final Color selectedColor;
  final Color unselectedColor;

  final Color newItemColor;
  final Color updatedItemColor;
  final Color deletedItemColor;
  final Color archivedColor;

  final Color masteringColor; // For fully mastered content
  final Color learningColor; // For in-progress learning
  final Color needsReviewColor; // For content that needs review
  final Color notStartedColor; // For content not yet started

  const SemanticColorExtension({
    required this.excellentColor,
    required this.goodColor,
    required this.averageColor,
    required this.belowAverageColor,
    required this.poorColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
    required this.infoColor,
    required this.neutralColor,
    required this.disabledColor,
    required this.highlightColor,
    required this.selectedColor,
    required this.unselectedColor,
    required this.newItemColor,
    required this.updatedItemColor,
    required this.deletedItemColor,
    required this.archivedColor,
    required this.masteringColor,
    required this.learningColor,
    required this.needsReviewColor,
    required this.notStartedColor,
  });

  factory SemanticColorExtension.light() {
    return SemanticColorExtension(
      excellentColor: AppColors.excellent,
      goodColor: AppColors.good,
      averageColor: AppColors.average,
      belowAverageColor: AppColors.warning,
      poorColor: AppColors.poor,

      successColor: AppColors.success,
      warningColor: AppColors.warning,
      errorColor: AppColors.error,
      infoColor: AppColors.info,
      neutralColor: Colors.grey.shade600,

      disabledColor: AppColors.textDisabled,
      highlightColor: AppColors.secondary.withValues(alpha: 0.15),
      selectedColor: AppColors.primary,
      unselectedColor: AppColors.textSecondary,

      newItemColor: AppColors.info,
      updatedItemColor: AppColors.success,
      deletedItemColor: AppColors.error,
      archivedColor: Colors.grey.shade600,

      masteringColor: AppColors.excellent,
      learningColor: AppColors.info,
      needsReviewColor: AppColors.warning,
      notStartedColor: Colors.grey.shade600,
    );
  }

  factory SemanticColorExtension.dark() {
    return SemanticColorExtension(
      excellentColor: AppColors.successDark,
      goodColor: AppColors.infoDark,
      averageColor: AppColors.warningDark,
      belowAverageColor: const Color(0xFFFBBD06),
      poorColor: AppColors.errorDark,

      successColor: AppColors.successDark,
      warningColor: AppColors.warningDark,
      errorColor: AppColors.errorDark,
      infoColor: AppColors.infoDark,
      neutralColor: Colors.grey.shade400,

      disabledColor: AppColors.textDisabledDark,
      highlightColor: AppColors.secondaryLight.withValues(alpha: 0.15),
      selectedColor: AppColors.primaryLight,
      unselectedColor: AppColors.textSecondaryDark,

      newItemColor: AppColors.infoDark,
      updatedItemColor: AppColors.successDark,
      deletedItemColor: AppColors.errorDark,
      archivedColor: Colors.grey.shade400,

      masteringColor: AppColors.successDark,
      learningColor: AppColors.infoDark,
      needsReviewColor: AppColors.warningDark,
      notStartedColor: Colors.grey.shade400,
    );
  }

  @override
  ThemeExtension<SemanticColorExtension> copyWith({
    Color? excellentColor,
    Color? goodColor,
    Color? averageColor,
    Color? belowAverageColor,
    Color? poorColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    Color? neutralColor,
    Color? disabledColor,
    Color? highlightColor,
    Color? selectedColor,
    Color? unselectedColor,
    Color? newItemColor,
    Color? updatedItemColor,
    Color? deletedItemColor,
    Color? archivedColor,
    Color? masteringColor,
    Color? learningColor,
    Color? needsReviewColor,
    Color? notStartedColor,
  }) {
    return SemanticColorExtension(
      excellentColor: excellentColor ?? this.excellentColor,
      goodColor: goodColor ?? this.goodColor,
      averageColor: averageColor ?? this.averageColor,
      belowAverageColor: belowAverageColor ?? this.belowAverageColor,
      poorColor: poorColor ?? this.poorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      infoColor: infoColor ?? this.infoColor,
      neutralColor: neutralColor ?? this.neutralColor,
      disabledColor: disabledColor ?? this.disabledColor,
      highlightColor: highlightColor ?? this.highlightColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      newItemColor: newItemColor ?? this.newItemColor,
      updatedItemColor: updatedItemColor ?? this.updatedItemColor,
      deletedItemColor: deletedItemColor ?? this.deletedItemColor,
      archivedColor: archivedColor ?? this.archivedColor,
      masteringColor: masteringColor ?? this.masteringColor,
      learningColor: learningColor ?? this.learningColor,
      needsReviewColor: needsReviewColor ?? this.needsReviewColor,
      notStartedColor: notStartedColor ?? this.notStartedColor,
    );
  }

  @override
  ThemeExtension<SemanticColorExtension> lerp(
    covariant ThemeExtension<SemanticColorExtension>? other,
    double t,
  ) {
    if (other is! SemanticColorExtension) {
      return this;
    }

    return SemanticColorExtension(
      excellentColor: Color.lerp(excellentColor, other.excellentColor, t)!,
      goodColor: Color.lerp(goodColor, other.goodColor, t)!,
      averageColor: Color.lerp(averageColor, other.averageColor, t)!,
      belowAverageColor: Color.lerp(
        belowAverageColor,
        other.belowAverageColor,
        t,
      )!,
      poorColor: Color.lerp(poorColor, other.poorColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,
      newItemColor: Color.lerp(newItemColor, other.newItemColor, t)!,
      updatedItemColor: Color.lerp(
        updatedItemColor,
        other.updatedItemColor,
        t,
      )!,
      deletedItemColor: Color.lerp(
        deletedItemColor,
        other.deletedItemColor,
        t,
      )!,
      archivedColor: Color.lerp(archivedColor, other.archivedColor, t)!,
      masteringColor: Color.lerp(masteringColor, other.masteringColor, t)!,
      learningColor: Color.lerp(learningColor, other.learningColor, t)!,
      needsReviewColor: Color.lerp(
        needsReviewColor,
        other.needsReviewColor,
        t,
      )!,
      notStartedColor: Color.lerp(notStartedColor, other.notStartedColor, t)!,
    );
  }

  Color getScoreColor(double score, {double maxScore = 100}) {
    final percentage = score / maxScore;

    if (percentage >= 0.9) return excellentColor;
    if (percentage >= 0.7) return goodColor;
    if (percentage >= 0.5) return averageColor;
    if (percentage >= 0.3) return belowAverageColor;
    return poorColor;
  }

  Color getLearningStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'mastered':
      case 'mastering':
      case 'completed':
        return masteringColor;
      case 'learning':
      case 'in progress':
        return learningColor;
      case 'needs review':
      case 'review':
        return needsReviewColor;
      case 'not started':
      default:
        return notStartedColor;
    }
  }
}

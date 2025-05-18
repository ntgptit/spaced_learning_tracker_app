import 'package:flutter/material.dart';

/// App dimensions constants aligned with Material 3
class AppDimens {
  // Padding and margin (Material 3: multiples of 4 or 8)
  static const double paddingXXS = 2.0;
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 40.0;
  static const double paddingXXXL = 48.0;
  static const double paddingSection = 56.0;
  static const double paddingPage = 64.0;

  // Border radius (Material 3: 4, 8, 12, 16, 24)
  static const double radiusXXS = 2.0;
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;
  static const double radiusXXXL = 40.0;
  static const double radiusCircular = 100.0;

  // Theme specific radius
  static const double dialogBorderRadius = radiusL;
  static const double bottomSheetBorderRadius = radiusXL;

  // Icon sizes (Material 3: 18, 24, 36, 48)
  static const double iconXXS = 10.0;
  static const double iconXS = 12.0;
  static const double iconS = 18.0;
  static const double iconM = 24.0;
  static const double iconL = 36.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;

  // Button heights (Material 3: 40, 48, 56)
  static const double buttonHeightXS = 24.0;
  static const double buttonHeightS = 40.0;
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;
  static const double buttonHeightXL = 64.0;

  // Input field heights (Material 3: 56 for filled, 48 for outlined)
  static const double textFieldHeightS = 36.0;
  static const double textFieldHeight = 56.0;
  static const double textFieldHeightL = 64.0;

  // Other heights
  static const double appBarHeight = 64.0;
  static const double tabBarHeight = 48.0;
  static const double bottomNavBarHeight = 80.0;
  static const double listTileHeightS = 48.0;
  static const double listTileHeight = 56.0;
  static const double listTileHeightL = 72.0;
  static const double bottomSheetMinHeight = 120.0;
  static const double bottomSheetHeaderHeight = 56.0;
  static const double badgeHeight = 24.0;
  static const double chipHeight = 32.0;
  static const double snackbarHeight = 48.0;
  static const double fabSize = 56.0;
  static const double fabSizeSmall = 40.0;
  static const double dividerThickness = 1.0;
  static const double thickDividerHeight = 4.0;

  // Widths and thickness
  static const double buttonMinWidth = 64.0;
  static const double dialogMinWidth = 280.0;
  static const double dialogMaxWidth = 400.0;
  static const double menuMaxWidth = 320.0;
  static const double tooltipMinWidth = 40.0;
  static const double outlineButtonBorderWidth = 1.5;
  static const double tabIndicatorThickness = 3.0;
  static const double borderWidthFocused = 2.0;

  // Elevation (Material 3: 0, 1, 3, 6, 8)
  static const double elevationNone = 0.0;
  static const double elevationXS = 1.0;
  static const double elevationS = 3.0;
  static const double elevationM = 6.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;
  static const double elevationXXL = 24.0;

  // Shadows
  static const double shadowRadiusS = 2.0;
  static const double shadowRadiusM = 4.0;
  static const double shadowRadiusL = 8.0;
  static const double shadowOffsetS = 1.0;
  static const double shadowOffsetM = 2.0;

  // Font sizes (Material 3 type scale)
  static const double fontDisplayL = 57.0;
  static const double fontDisplayM = 45.0;
  static const double fontDisplayS = 36.0;
  static const double fontHeadlineL = 32.0;
  static const double fontHeadlineM = 28.0;
  static const double fontHeadlineS = 24.0;
  static const double fontTitleL = 22.0;
  static const double fontTitleM = 16.0;
  static const double fontTitleS = 14.0;
  static const double fontLabelL = 14.0;
  static const double fontLabelM = 12.0;
  static const double fontLabelS = 11.0;
  static const double fontBodyL = 16.0;
  static const double fontBodyM = 14.0;
  static const double fontBodyS = 12.0;
  static const double fontXXS = 8.0;
  static const double fontXS = 10.0;
  static const double fontS = 11.0;
  static const double fontM = 12.0;
  static const double fontL = 14.0;
  static const double fontXL = 16.0;
  static const double fontXXL = 18.0;
  static const double fontXXXL = 20.0;
  static const double fontMicro = 11.0;

  // Spacing and gaps (Material 3: multiples of 4 or 8)
  static const double gapXXS = 2.0;
  static const double gapXS = 4.0;
  static const double gapS = 8.0;
  static const double gapM = 16.0;
  static const double gapL = 24.0;
  static const double gapXL = 32.0;
  static const double gapXXL = 40.0;
  static const double gapXXXL = 48.0;
  static const double gapSection = 56.0;
  static const double gapPage = 64.0;

  // Gap widgets
  static const SizedBox hGapXXS = SizedBox(width: gapXXS);
  static const SizedBox hGapXS = SizedBox(width: gapXS);
  static const SizedBox hGapS = SizedBox(width: gapS);
  static const SizedBox hGapM = SizedBox(width: gapM);
  static const SizedBox hGapL = SizedBox(width: gapL);
  static const SizedBox hGapXL = SizedBox(width: gapXL);
  static const SizedBox hGapXXL = SizedBox(width: gapXXL);
  static const SizedBox vGapXXS = SizedBox(height: gapXXS);
  static const SizedBox vGapXS = SizedBox(height: gapXS);
  static const SizedBox vGapS = SizedBox(height: gapS);
  static const SizedBox vGapM = SizedBox(height: gapM);
  static const SizedBox vGapL = SizedBox(height: gapL);
  static const SizedBox vGapXL = SizedBox(height: gapXL);
  static const SizedBox vGapXXL = SizedBox(height: gapXXL);

  // Grid
  static const double gridSpacingXS = 2.0;
  static const double gridSpacingS = 4.0;
  static const double gridSpacingM = 8.0;
  static const double gridSpacingL = 16.0;
  static const double gridItemMinWidth = 120.0;
  static const double gridItemMaxWidth = 180.0;
  static const double gridGutter = 16.0;

  // Grid column counts for different screen sizes
  static const int gridColumnCountSmall = 2;
  static const int gridColumnCountMedium = 4;
  static const int gridColumnCountLarge = 6;
  static const int gridColumnCountXLarge = 8;

  // Avatar and thumbnail
  static const double avatarSizeXS = 24.0;
  static const double avatarSizeS = 32.0;
  static const double avatarSizeM = 40.0;
  static const double avatarSizeL = 56.0;
  static const double avatarSizeXL = 64.0;
  static const double avatarSizeXXL = 96.0;
  static const double thumbnailSizeS = 80.0;
  static const double thumbnailSizeM = 120.0;
  static const double thumbnailSizeL = 160.0;

  // Durations (Material 3: 100, 200, 300, 500)
  static const int durationXXS = 50;
  static const int durationXS = 100;
  static const int durationS = 200;
  static const int durationM = 300;
  static const int durationL = 500;
  static const int durationXL = 800;
  static const int durationFade = 250;
  static const int durationSlide = 400;

  // Miscellaneous UI elements
  static const double moduleIndicatorSize = 36.0;
  static const double circularProgressSize = 24.0;
  static const double circularProgressSizeL = 48.0;
  static const double lineProgressHeight = 4.0;
  static const double lineProgressHeightL = 8.0;
  static const double badgeIconPadding = 2.0;
  static const double shimmerHeight = 16.0;
  static const double touchTargetMinSize = 48.0;

  // Layout
  static const double maxContentWidth = 1200.0;
  static const double sideMenuWidth = 280.0;
  static const double compactSideMenuWidth = 80.0;
  static const double bannerHeight = 200.0;
  static const double cardMinHeight = 80.0;

  // Breakpoints (Material 3: 360, 600, 840, 1200)
  static const double breakpointXS = 360.0;
  static const double breakpointS = 600.0;
  static const double breakpointM = 840.0;
  static const double breakpointL = 1200.0;
  static const double breakpointXL = 1440.0;

  // Safe area and insets
  static const double keyboardInset = 80.0;
  static const double safeAreaTop = 44.0;
  static const double safeAreaBottom = 34.0;

  // Opacities (Material 3)
  static const double opacityFull = 1.0;
  static const double opacityTextSubtle = 0.9;
  static const double opacityVeryHigh = 0.8;
  static const double opacityHigh = 0.7;
  static const double opacityUnselected = 0.6;
  static const double opacityMediumHigh = 0.5;
  static const double opacitySemi = 0.2;
  static const double opacityMedium = 0.12;
  static const double opacityLight = 0.04;
  static const double opacityDisabled = 0.38;
  static const double opacityNone = 0.0;
  static const double opacityDisabledText = opacityDisabled;
  static const double opacityHintText = opacityHigh;
  static const double opacityDisabledOutline = opacityMedium;

  // Responsive scaling
  static const double scaleFactorSmall = 0.85;
  static const double scaleFactorLarge = 1.15;

  // Padding presets
  static const EdgeInsets screenPadding = EdgeInsets.all(paddingM);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );
  static const EdgeInsets dialogPadding = EdgeInsets.all(paddingL);
  static const EdgeInsets listTilePadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );

  // Content insets presets
  static const EdgeInsets contentInsetRegular = EdgeInsets.symmetric(
    horizontal: paddingL,
    vertical: paddingM,
  );
  static const EdgeInsets contentInsetCompact = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );
  static const EdgeInsets contentInsetTight = EdgeInsets.all(paddingS);

  // SPACING & GAPS
  static const double spaceXXS = 2.0;
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 12.0;
  static const double spaceL = 16.0;
  static const double spaceXL = 24.0;
  static const double spaceXXL = 32.0;
  static const double spaceXXXL = 48.0;
  static const double spaceSectionGap = 40.0;
  static const double spacePageGap = 64.0;

  // Aspect ratios
  static const double aspectRatio21x9 = 21 / 9;
  static const double aspectRatio16x9 = 16 / 9;
  static const double aspectRatio4x3 = 4 / 3;
  static const double aspectRatio1x1 = 1 / 1;
  static const double aspectRatio3x4 = 3 / 4;
  static const double aspectRatio9x16 = 9 / 16;

  // Private constructor to prevent instantiation
  AppDimens._();
}

/// Extension methods for easily using responsive dimensions with BuildContext
extension BuildContextDimensExtension on BuildContext {
  // Responsive dimensions based on screen size
  double get responsiveSpacing {
    final width = MediaQuery.of(this).size.width;
    if (width < AppDimens.breakpointS) return AppDimens.spaceS;
    if (width < AppDimens.breakpointM) return AppDimens.spaceM;
    return AppDimens.spaceL;
  }

  // Responsive padding based on screen size
  EdgeInsets get responsivePadding {
    final width = MediaQuery.of(this).size.width;
    if (width < AppDimens.breakpointS) {
      return const EdgeInsets.all(AppDimens.paddingS);
    }
    if (width < AppDimens.breakpointM) {
      return const EdgeInsets.all(AppDimens.paddingM);
    }
    return const EdgeInsets.all(AppDimens.paddingL);
  }

  // Get dimensions scaled by device pixel ratio for pixel-perfect UI
  double dp(double size) => size * MediaQuery.of(this).devicePixelRatio;

  // Get screen width as double
  double get screenWidth => MediaQuery.of(this).size.width;

  // Get screen height as double
  double get screenHeight => MediaQuery.of(this).size.height;

  // Get screen density
  double get density => MediaQuery.of(this).devicePixelRatio;

  // Check if screen is at different breakpoints
  bool get isSmallScreen => screenWidth < AppDimens.breakpointS;

  bool get isMediumScreen =>
      screenWidth >= AppDimens.breakpointS &&
      screenWidth < AppDimens.breakpointM;

  bool get isLargeScreen =>
      screenWidth >= AppDimens.breakpointM &&
      screenWidth < AppDimens.breakpointL;

  bool get isXLargeScreen => screenWidth >= AppDimens.breakpointL;

  // Get grid column count based on screen size
  int get gridColumnCount {
    if (isSmallScreen) return AppDimens.gridColumnCountSmall;
    if (isMediumScreen) return AppDimens.gridColumnCountMedium;
    if (isLargeScreen) return AppDimens.gridColumnCountLarge;
    return AppDimens.gridColumnCountXLarge;
  }
}

/// Extension for creating responsive dimensions as percentage of screen size
extension ResponsiveSizeExtension on num {
  // Get % of screen width
  double sw(BuildContext context) =>
      this * MediaQuery.of(context).size.width / 100;

  // Get % of screen height
  double sh(BuildContext context) =>
      this * MediaQuery.of(context).size.height / 100;

  // Responsive value based on design width (default 375.0)
  double w(BuildContext context, {double designWidth = 375.0}) =>
      this * MediaQuery.of(context).size.width / designWidth;

  // Responsive value based on design height (default 812.0)
  double h(BuildContext context, {double designHeight = 812.0}) =>
      this * MediaQuery.of(context).size.height / designHeight;
}

/// Helper class for creating responsive dimensions
class ResponsiveDimensions {
  // Scale dimensions based on screen size
  static double scale(double size, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointS) {
      return size * AppDimens.scaleFactorSmall;
    } else if (width > AppDimens.breakpointL) {
      return size * AppDimens.scaleFactorLarge;
    }
    return size;
  }

  // Get screen-size appropriate padding
  static EdgeInsets getPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointS) {
      return const EdgeInsets.all(AppDimens.paddingS);
    } else if (width < AppDimens.breakpointM) {
      return const EdgeInsets.all(AppDimens.paddingM);
    }
    return const EdgeInsets.all(AppDimens.paddingL);
  }

  // Convert design dimensions to current screen dimensions
  static double fromDesign(
    double value,
    BuildContext context, {
    double designWidth = 375.0,
  }) {
    final currentWidth = MediaQuery.of(context).size.width;
    return value * currentWidth / designWidth;
  }

  // Get appropriate icon size for screen size
  static double getAdaptiveIconSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointS) {
      return AppDimens.iconS;
    } else if (width < AppDimens.breakpointM) {
      return AppDimens.iconM;
    }
    return AppDimens.iconL;
  }

  // Get appropriate avatar size for screen size
  static double getAdaptiveAvatarSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointS) {
      return AppDimens.avatarSizeS;
    } else if (width < AppDimens.breakpointM) {
      return AppDimens.avatarSizeM;
    }
    return AppDimens.avatarSizeL;
  }

  // Get appropriate text size scale factor for screen size
  static double getTextScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointS) {
      return 0.9;
    } else if (width < AppDimens.breakpointM) {
      return 1.0;
    } else if (width < AppDimens.breakpointL) {
      return 1.1;
    }
    return 1.2;
  }
}

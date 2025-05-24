import 'package:flutter/material.dart';

class AppDimens {
  static const double paddingNone = 0.0;
  static const double paddingXXS = 2.0;
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 40.0;
  static const double paddingXXXL = 48.0;
  static const double paddingSection = 56.0; // For larger section spacing
  static const double paddingPage = 64.0; // For overall page padding

  static const double radiusNone = 0.0;
  static const double radiusXXS = 2.0;
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0; // Common for cards, dialogs
  static const double radiusL = 16.0; // Common for buttons, larger elements
  static const double radiusXL = 24.0; // For larger surfaces like bottom sheets
  static const double radiusXXL =
      28.0; // M3 specific for some larger components
  static const double radiusXXXL = 32.0; // For very large rounded areas
  static const double radiusCircular = 1000.0; // Effectively circular

  static const double dialogBorderRadius =
      radiusL; // Consistent with M3 dialogs (often 28, but 16 is also used)
  static const double bottomSheetBorderRadius =
      radiusXL; // M3 often uses 28 for top corners

  static const double iconXXS = 10.0;
  static const double iconXS = 12.0;
  static const double iconS = 18.0;
  static const double iconM = 24.0; // Standard icon size
  static const double iconL = 36.0;
  static const double iconXL = 48.0;
  static const double iconXXL = 64.0;

  static const double buttonHeightXS = 32.0; // For very small/compact buttons
  static const double buttonHeightS = 40.0; // M3 standard button height
  static const double buttonHeightM = 48.0;
  static const double buttonHeightL = 56.0;
  static const double buttonHeightXL = 64.0;

  static const double textFieldHeightS = 48.0; // Outlined text field height
  static const double textFieldHeight = 56.0; // Filled text field height
  static const double textFieldHeightL = 64.0;

  static const double appBarHeight = 64.0; // M3 Top App Bar height
  static const double tabBarHeight = 48.0;
  static const double bottomNavBarHeight = 80.0; // M3 Navigation Bar height
  static const double listTileHeightS = 48.0;
  static const double listTileHeight = 56.0; // M3 ListTile height
  static const double listTileHeightL = 72.0;
  static const double bottomSheetMinHeight = 120.0;
  static const double bottomSheetHeaderHeight = 56.0;
  static const double badgeHeight = 24.0;
  static const double chipHeight = 32.0; // M3 Chip height
  static const double snackbarHeight = 48.0;
  static const double fabSize = 56.0; // M3 FAB size
  static const double fabSizeSmall = 40.0; // M3 Small FAB size
  static const double fabSizeLarge = 96.0; // M3 Large FAB size
  static const double dividerThickness = 1.0;
  static const double thickDividerHeight = 4.0;

  static const double buttonMinWidth = 64.0;
  static const double dialogMinWidth = 280.0;
  static const double dialogMaxWidth = 560.0; // M3 guidance for dialog width
  static const double menuMinWidth = 112.0; // M3 menu min width
  static const double menuMaxWidth = 280.0; // M3 menu max width
  static const double tooltipMinWidth = 40.0;
  static const double outlineButtonBorderWidth =
      1.0; // M3 OutlinedButton border width
  static const double tabIndicatorThickness = 2.0; // M3 Tab indicator thickness
  static const double borderWidthFocused = 2.0;

  static const double elevationNone = 0.0; // Level 0
  static const double elevationXS = 1.0; // Level 1
  static const double elevationS = 3.0; // Level 2
  static const double elevationM = 6.0; // Level 3
  static const double elevationL = 8.0; // Level 4
  static const double elevationXL = 12.0; // Level 5
  static const double elevationXXL =
      16.0; // Higher, for pronounced shadows if needed
  static const double elevationXXXL = 24.0; // For very distinct elements

  static const double shadowRadiusS = 2.0;
  static const double shadowRadiusM = 4.0;
  static const double shadowRadiusL = 8.0;
  static const double shadowOffsetS = 1.0;
  static const double shadowOffsetM = 2.0;

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

  static const double fontXXS = 8.0; // For very small text, captions
  static const double fontXS = 10.0;
  static const double fontS = 11.0; // Similar to labelSmall
  static const double fontM = 12.0; // Similar to labelMedium or bodySmall
  static const double fontL = 14.0; // Similar to labelLarge or bodyMedium
  static const double fontXL = 16.0; // Similar to titleMedium or bodyLarge
  static const double fontXXL = 18.0;
  static const double fontXXXL = 20.0;
  static const double fontMicro = 10.0; // Renamed from 11 for clarity

  static const double spaceXXS = 2.0;
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 12.0; // Added for finer control
  static const double spaceL = 16.0;
  static const double spaceXL = 24.0;
  static const double spaceXXL = 32.0;
  static const double spaceXXXL = 40.0; // Adjusted for consistency
  static const double spaceXXXXL = 48.0; // New for larger spacing
  static const double spaceSection = 56.0; // Renamed from gapSection
  static const double spacePage = 64.0; // Renamed from gapPage

  static const SizedBox hSpaceXXS = SizedBox(width: spaceXXS);
  static const SizedBox hSpaceXS = SizedBox(width: spaceXS);
  static const SizedBox hSpaceS = SizedBox(width: spaceS);
  static const SizedBox hSpaceM = SizedBox(width: spaceM);
  static const SizedBox hSpaceL = SizedBox(width: spaceL);
  static const SizedBox hSpaceXL = SizedBox(width: spaceXL);
  static const SizedBox hSpaceXXL = SizedBox(width: spaceXXL);
  static const SizedBox hSpaceXXXL = SizedBox(width: spaceXXXL);
  static const SizedBox hSpaceXXXXL = SizedBox(width: spaceXXXXL);

  static const SizedBox vSpaceXXS = SizedBox(height: spaceXXS);
  static const SizedBox vSpaceXS = SizedBox(height: spaceXS);
  static const SizedBox vSpaceS = SizedBox(height: spaceS);
  static const SizedBox vSpaceM = SizedBox(height: spaceM);
  static const SizedBox vSpaceL = SizedBox(height: spaceL);
  static const SizedBox vSpaceXL = SizedBox(height: spaceXL);
  static const SizedBox vSpaceXXL = SizedBox(height: spaceXXL);
  static const SizedBox vSpaceXXXL = SizedBox(height: spaceXXXL);
  static const SizedBox vSpaceXXXXL = SizedBox(height: spaceXXXXL);

  static const double gridSpacingXS = 2.0;
  static const double gridSpacingS = 4.0;
  static const double gridSpacingM = 8.0;
  static const double gridSpacingL = 16.0;
  static const double gridItemMinWidth = 120.0;
  static const double gridItemMaxWidth = 200.0; // Increased max width
  static const double gridGutter = 16.0; // Spacing between columns

  static const int gridColumnCountCompact = 2; // For very small screens
  static const int gridColumnCountSmall = 2; // M3: 4 columns for small handset
  static const int gridColumnCountMedium =
      3; // M3: 8 columns for large handset/small tablet
  static const int gridColumnCountLarge = 4; // M3: 12 columns for tablet
  static const int gridColumnCountXLarge =
      6; // For larger tablets/small desktops

  static const double avatarSizeXXS = 16.0; // New smaller avatar
  static const double avatarSizeXS = 24.0;
  static const double avatarSizeS = 32.0;
  static const double avatarSizeM = 40.0; // M3: Common size
  static const double avatarSizeL = 56.0;
  static const double avatarSizeXL = 64.0;
  static const double avatarSizeXXL = 96.0;
  static const double thumbnailSizeS = 60.0; // Adjusted
  static const double thumbnailSizeM = 100.0; // Adjusted
  static const double thumbnailSizeL = 140.0; // Adjusted
  static const double thumbnailSizeXL = 180.0; // New larger thumbnail

  static const int durationShort1 = 50;
  static const int durationShort2 = 100;
  static const int durationShort3 = 150;
  static const int durationShort4 = 200;

  static const int durationMedium1 = 250;
  static const int durationMedium2 = 300;
  static const int durationMedium3 = 350;
  static const int durationMedium4 = 400;

  static const int durationLong1 = 450;
  static const int durationLong2 = 500;
  static const int durationLong3 = 550;
  static const int durationLong4 = 600;

  static const int durationXXS = durationShort1; // 50
  static const int durationXS = durationShort2; // 100
  static const int durationS = durationShort4; // 200
  static const int durationM = durationMedium2; // 300
  static const int durationL = durationLong2; // 500
  static const int durationXL = durationLong4 + 200; // 800

  static const int durationFade = durationMedium1; // 250
  static const int durationSlide = durationMedium4; // 400
  static const int durationExpand = durationMedium2; // 300
  static const int durationFocus = durationShort3; // 150
  static const int durationTooltip =
      durationLong2; // 500 (how long it stays, not animation)

  static const double moduleIndicatorSize = 36.0;
  static const double circularProgressSizeS =
      20.0; // M3 progress indicator small
  static const double circularProgressSize = 24.0; // Common size
  static const double circularProgressSizeM =
      36.0; // M3 progress indicator medium
  static const double circularProgressSizeL = 48.0;
  static const double lineProgressHeight =
      4.0; // M3 linear progress indicator height
  static const double lineProgressHeightL = 8.0;
  static const double badgeIconPadding = 2.0;
  static const double shimmerHeight = 16.0;
  static const double touchTargetMinSize = 48.0; // M3 minimum touch target size
  static const double switchTrackHeight = 16.0; // M3 switch track height
  static const double switchTrackWidth = 36.0; // M3 switch track width
  static const double switchThumbSize = 20.0; // M3 switch thumb size

  static const double maxContentWidthS = 600.0; // For mobile-focused content
  static const double maxContentWidthM = 840.0; // For tablet-focused content
  static const double maxContentWidthL = 1200.0; // For desktop-focused content
  static const double maxContentWidth = maxContentWidthM; // Default max width

  static const double sideMenuWidth = 256.0; // M3 Nav Drawer width (modal)
  static const double compactSideMenuWidth = 80.0;
  static const double bannerHeightS = 120.0;
  static const double bannerHeightM = 160.0;
  static const double bannerHeight = bannerHeightM; // Default banner height
  static const double bannerHeightL = 200.0;
  static const double cardMinHeight = 80.0;
  static const double navigationRailWidth = 80.0; // M3 Navigation Rail width

  static const double breakpointCompact = 600.0;
  static const double breakpointMedium = 840.0;
  static const double breakpointExpanded =
      1240.0; // M3 guideline for large tablet/small desktop
  static const double breakpointLarge = 1440.0; // Common desktop breakpoint
  static const double breakpointXLarge = 1600.0; // Larger desktop
  static const double breakpointXXLarge = 1920.0; // Full HD

  static const double breakpointXS = breakpointCompact; // < 600dp
  static const double breakpointS = breakpointMedium; // 600dp - 839dp
  static const double breakpointM = breakpointExpanded; // >= 840dp

  static const double keyboardInset = 80.0; // Approximate
  static const double safeAreaTop = 44.0; // iOS typical
  static const double safeAreaBottom = 34.0; // iOS typical with home indicator

  static const double opacityFull = 1.0;
  static const double opacityVeryHigh = 0.87; // High-emphasis text
  static const double opacityHigh = 0.60; // Medium-emphasis text, icons
  static const double opacityMedium = 0.38; // Disabled content
  static const double opacityLow =
      0.12; // Hover, focus, pressed states overlays
  static const double opacityVeryLow = 0.08; // Dragged states overlays
  static const double opacityNone = 0.0;

  static const double opacityTextSubtle = opacityHigh;
  static const double opacityUnselected = opacityHigh;
  static const double opacityMediumHigh = 0.75; // Custom
  static const double opacitySemi = 0.5; // Custom
  static const double opacityLight = opacityLow;
  static const double opacityDisabled = opacityMedium;
  static const double opacityDisabledText = opacityDisabled;
  static const double opacityHintText = opacityHigh;
  static const double opacityDisabledOutline = opacityDisabled;

  static const double scaleFactorSmall = 0.85;
  static const double scaleFactorLarge = 1.15;

  static const EdgeInsets screenPadding = EdgeInsets.all(paddingM);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: paddingL,
    vertical: paddingS + 2,
  ); // M3 button padding is often H:24, V:10
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingL - 2,
  ); // M3 text field content padding
  static const EdgeInsets dialogPadding = EdgeInsets.all(
    paddingL,
  ); // M3 dialog padding
  static const EdgeInsets listTilePadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );

  static const EdgeInsets contentInsetRegular = EdgeInsets.symmetric(
    horizontal: paddingL,
    vertical: paddingM,
  );
  static const EdgeInsets contentInsetCompact = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );
  static const EdgeInsets contentInsetTight = EdgeInsets.all(paddingS);

  static const double aspectRatio21x9 = 21 / 9;
  static const double aspectRatio16x9 = 16 / 9;
  static const double aspectRatio3x2 = 3 / 2;
  static const double aspectRatio4x3 = 4 / 3;
  static const double aspectRatio1x1 = 1 / 1;
  static const double aspectRatio3x4 = 3 / 4;
  static const double aspectRatio2x3 = 2 / 3;
  static const double aspectRatio9x16 = 9 / 16;

  static const double letterSpacingDisplayLarge = -0.25;
  static const double letterSpacingDisplayMedium = 0;
  static const double letterSpacingDisplaySmall = 0;
  static const double letterSpacingHeadlineLarge = 0;
  static const double letterSpacingHeadlineMedium = 0;
  static const double letterSpacingHeadlineSmall = 0;
  static const double letterSpacingTitleLarge = 0;
  static const double letterSpacingTitleMedium = 0.15;
  static const double letterSpacingTitleSmall = 0.1;
  static const double letterSpacingLabelLarge = 0.1;
  static const double letterSpacingLabelMedium = 0.5;
  static const double letterSpacingLabelSmall = 0.5;
  static const double letterSpacingBodyLarge =
      0.5; // Or 0.15 for tighter tracking
  static const double letterSpacingBodyMedium = 0.25;
  static const double letterSpacingBodySmall = 0.4;

  AppDimens._();
}

extension BuildContextDimensExtension on BuildContext {
  double get responsiveSpacing {
    final width = MediaQuery.of(this).size.width;
    if (width < AppDimens.breakpointCompact) return AppDimens.spaceS;
    if (width < AppDimens.breakpointMedium) return AppDimens.spaceM;
    return AppDimens.spaceL;
  }

  EdgeInsets get responsivePadding {
    final width = MediaQuery.of(this).size.width;
    if (width < AppDimens.breakpointCompact) {
      return const EdgeInsets.all(AppDimens.paddingS);
    }
    if (width < AppDimens.breakpointMedium) {
      return const EdgeInsets.all(AppDimens.paddingM);
    }
    return const EdgeInsets.all(AppDimens.paddingL);
  }

  double dp(double size) => size * MediaQuery.of(this).devicePixelRatio;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get density => MediaQuery.of(this).devicePixelRatio;

  bool get isCompactScreen =>
      screenWidth < AppDimens.breakpointCompact; // < 600dp
  bool get isMediumScreen =>
      screenWidth >= AppDimens.breakpointCompact &&
      screenWidth < AppDimens.breakpointMedium; // 600dp - 839dp
  bool get isExpandedScreen =>
      screenWidth >= AppDimens.breakpointMedium; // >= 840dp

  bool get isSmallScreen => isCompactScreen;

  bool get isLargeTabletScreen =>
      screenWidth >= AppDimens.breakpointExpanded &&
      screenWidth <
          AppDimens.breakpointLarge; // Example, if you need more distinctions
  bool get isDesktopScreen => screenWidth >= AppDimens.breakpointLarge;

  int get gridColumnCount {
    if (isCompactScreen) return 4; // Small handsets often use 4 columns
    if (isMediumScreen) return 8; // Large handsets/small tablets
    return 12; // Large tablets and desktops
  }
}

extension ResponsiveSizeExtension on num {
  double sw(BuildContext context) =>
      this * MediaQuery.of(context).size.width / 100;

  double sh(BuildContext context) =>
      this * MediaQuery.of(context).size.height / 100;

  double w(BuildContext context, {double designWidth = 375.0}) =>
      this * MediaQuery.of(context).size.width / designWidth;

  double h(BuildContext context, {double designHeight = 812.0}) =>
      this * MediaQuery.of(context).size.height / designHeight;
}

class ResponsiveDimensions {
  static double scale(double size, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointCompact) {
      return size * AppDimens.scaleFactorSmall;
    }
    if (width >= AppDimens.breakpointExpanded) {
      return size * AppDimens.scaleFactorLarge;
    }
    return size; // Medium devices
  }

  static EdgeInsets getPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointCompact) {
      return const EdgeInsets.all(AppDimens.paddingS);
    }
    if (width < AppDimens.breakpointMedium) {
      return const EdgeInsets.all(AppDimens.paddingM);
    }
    return const EdgeInsets.all(AppDimens.paddingL);
  }

  static double fromDesign(
    double value,
    BuildContext context, {
    double designWidth = 375.0, // Common mobile design width
  }) {
    final currentWidth = MediaQuery.of(context).size.width;
    return value * currentWidth / designWidth;
  }

  static double getAdaptiveIconSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointCompact) {
      return AppDimens.iconS;
    }
    if (width < AppDimens.breakpointMedium) {
      return AppDimens.iconM;
    }
    return AppDimens.iconL;
  }

  static double getAdaptiveAvatarSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointCompact) {
      return AppDimens.avatarSizeM; // M3 suggests 40dp as a common avatar size
    }
    if (width < AppDimens.breakpointMedium) {
      return AppDimens.avatarSizeL;
    }
    return AppDimens.avatarSizeXL;
  }

  static double getTextScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppDimens.breakpointCompact) {
      return 0.9; // Slightly smaller for compact screens
    }
    if (width >= AppDimens.breakpointExpanded) {
      return 1.1; // Slightly larger for expanded screens
    }
    return 1.0; // Default for medium screens
  }
}

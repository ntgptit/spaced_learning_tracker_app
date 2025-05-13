import 'package:flutter/material.dart';

/// App dimensions constants
/// All dimensions are defined here to ensure consistency across the app
class AppDimens {
  // Padding and margin
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  // Border radius
  static const double radiusXS = 2.0;
  static const double radiusS = 4.0;
  static const double radiusM = 8.0;
  static const double radiusL = 12.0;
  static const double radiusXL = 16.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircular = 100.0;

  // Text sizes
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;
  static const double fontSizeTitle = 22.0;
  static const double fontSizeHeadline = 24.0;
  static const double fontSizeDisplay = 28.0;

  // Icon sizes
  static const double iconSizeXS = 12.0;
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 20.0;
  static const double iconSizeL = 24.0;
  static const double iconSizeXL = 32.0;
  static const double iconSizeXXL = 48.0;

  // Button heights
  static const double buttonHeightS = 32.0;
  static const double buttonHeightM = 40.0;
  static const double buttonHeightL = 48.0;
  static const double buttonHeightXL = 56.0;

  // Input field heights
  static const double inputHeightS = 32.0;
  static const double inputHeightM = 40.0;
  static const double inputHeightL = 48.0;
  static const double inputHeightXL = 56.0;

  // Card elevation
  static const double elevationXS = 1.0;
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 16.0;

  // App bar height
  static const double appBarHeight = 56.0;
  static const double appBarHeightLarge = 128.0;

  // Bottom navigation bar
  static const double bottomNavBarHeight = 56.0;
  static const double bottomActionBarHeight = 64.0;

  // Divider
  static const double dividerHeight = 1.0;
  static const double dividerHeightThick = 2.0;

  // Avatar sizes
  static const double avatarSizeS = 24.0;
  static const double avatarSizeM = 40.0;
  static const double avatarSizeL = 56.0;
  static const double avatarSizeXL = 80.0;

  // Tab bar
  static const double tabBarHeight = 48.0;

  // Snackbar
  static const double snackbarHeight = 48.0;

  // Dialog
  static const double dialogWidth = 280.0;
  static const double dialogWidthLarge = 360.0;
  static const double dialogBorderRadius = 12.0;

  // Bottom sheet
  static const double bottomSheetBorderRadius = 16.0;

  // Loading indicator
  static const double loadingIndicatorSize = 40.0;
  static const double loadingIndicatorSizeSmall = 24.0;

  // Screen padding
  static const EdgeInsets screenPadding = EdgeInsets.all(paddingM);
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(horizontal: paddingM);
  static const EdgeInsets screenPaddingVertical = EdgeInsets.symmetric(vertical: paddingM);

  // Card padding
  static const EdgeInsets cardPadding = EdgeInsets.all(paddingM);
  static const EdgeInsets cardContentPadding = EdgeInsets.all(paddingM);

  // List tile padding
  static const EdgeInsets listTilePadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );

  // Button padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );

  // Input padding
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: paddingM,
    vertical: paddingS,
  );

  // Dialog padding
  static const EdgeInsets dialogPadding = EdgeInsets.all(paddingL);
  static const EdgeInsets dialogContentPadding = EdgeInsets.all(paddingM);

  // Gap between items
  static const double gapXS = 4.0;
  static const double gapS = 8.0;
  static const double gapM = 16.0;
  static const double gapL = 24.0;
  static const double gapXL = 32.0;

  // Gap widget for spacing - Horizontal
  static const SizedBox hGapXS = SizedBox(width: gapXS);
  static const SizedBox hGapS = SizedBox(width: gapS);
  static const SizedBox hGapM = SizedBox(width: gapM);
  static const SizedBox hGapL = SizedBox(width: gapL);
  static const SizedBox hGapXL = SizedBox(width: gapXL);

  // Gap widget for spacing - Vertical
  static const SizedBox vGapXS = SizedBox(height: gapXS);
  static const SizedBox vGapS = SizedBox(height: gapS);
  static const SizedBox vGapM = SizedBox(height: gapM);
  static const SizedBox vGapL = SizedBox(height: gapL);
  static const SizedBox vGapXL = SizedBox(height: gapXL);
}
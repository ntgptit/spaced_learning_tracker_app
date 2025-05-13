import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_assets.dart';
import 'package:slt_app/core/constants/app_strings.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';

/// Offline state widget
/// Displays offline state information with refresh button
class SltOfflineStateWidget extends StatelessWidget {
  /// Offline state message to display
  final String message;

  /// Title of the offline state
  final String title;

  /// Icon to display
  final IconData icon;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double iconSize;

  /// Refresh callback function
  final VoidCallback? onRefresh;

  /// Refresh button text
  final String refreshText;

  /// Whether to use an image instead of an icon
  final bool useImage;

  /// Image path to use if useImage is true
  final String imagePath;

  /// Image width
  final double imageWidth;

  /// Image height
  final double imageHeight;

  const SltOfflineStateWidget({
    Key? key,
    this.message = AppStrings.errorStateNetworkDescription,
    this.title = AppStrings.errorStateNetworkTitle,
    this.icon = Icons.wifi_off_outlined,
    this.iconColor,
    this.iconSize = 64.0,
    this.onRefresh,
    this.refreshText = AppStrings.errorStateNetworkButtonText,
    this.useImage = false,
    this.imagePath = AppAssets.noInternetState,
    this.imageWidth = 150.0,
    this.imageHeight = 150.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppDimens.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (useImage) ...[
              Image.asset(
                imagePath,
                width: imageWidth,
                height: imageHeight,
              ),
            ] else ...[
              Icon(
                icon,
                size: iconSize,
                color: iconColor ??
                    theme.colorScheme.primary.withValues(alpha: 0.7),
              ),
            ],
            AppDimens.vGapL,
            Text(
              title,
              style: theme.textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            AppDimens.vGapM,
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            AppDimens.vGapXL,
            if (onRefresh != null) ...[
              SltPrimaryButton(
                text: refreshText,
                onPressed: onRefresh,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_assets.dart';
import 'package:slt_app/core/constants/app_strings.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';

/// Unauthorized state widget
/// Displays unauthorized state information with action button
class SltUnauthorizedStateWidget extends StatelessWidget {
  /// Unauthorized state message to display
  final String message;

  /// Title of the unauthorized state
  final String title;

  /// Icon to display
  final IconData icon;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double iconSize;

  /// Action callback function
  final VoidCallback? onAction;

  /// Action button text
  final String actionText;

  /// Whether to use an image instead of an icon
  final bool useImage;

  /// Image path to use if useImage is true
  final String imagePath;

  /// Image width
  final double imageWidth;

  /// Image height
  final double imageHeight;

  const SltUnauthorizedStateWidget({
    Key? key,
    this.message = AppStrings.unauthorizedStateDescription,
    this.title = AppStrings.unauthorizedStateTitle,
    this.icon = Icons.lock_outline,
    this.iconColor,
    this.iconSize = 64.0,
    this.onAction,
    this.actionText = AppStrings.unauthorizedStateButtonText,
    this.useImage = false,
    this.imagePath = AppAssets.unauthorizedState,
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
                color: iconColor ?? theme.colorScheme.error,
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
            if (onAction != null) ...[
              SltPrimaryButton(
                text: actionText,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

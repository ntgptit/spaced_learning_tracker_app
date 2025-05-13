import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_assets.dart';
import 'package:slt_app/core/constants/app_strings.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';

/// Error state widget
/// Displays error information with optional retry button
class SltErrorStateWidget extends StatelessWidget {
  /// Error message to display
  final String message;

  /// Title of the error
  final String? title;

  /// Icon to display
  final IconData icon;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double iconSize;

  /// Retry callback function
  final VoidCallback? onRetry;

  /// Retry button text
  final String retryText;

  /// Whether to use an image instead of an icon
  final bool useImage;

  /// Image path to use if useImage is true
  final String imagePath;

  /// Image width
  final double imageWidth;

  /// Image height
  final double imageHeight;

  /// Custom action callback
  final VoidCallback? onCustomAction;

  /// Custom action text
  final String? customActionText;

  const SltErrorStateWidget({
    Key? key,
    this.message = AppStrings.errorStateDescription,
    this.title = AppStrings.errorStateTitle,
    this.icon = Icons.error_outline,
    this.iconColor,
    this.iconSize = 64.0,
    this.onRetry,
    this.retryText = AppStrings.errorStateButtonText,
    this.useImage = false,
    this.imagePath = AppAssets.errorState,
    this.imageWidth = 150.0,
    this.imageHeight = 150.0,
    this.onCustomAction,
    this.customActionText,
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
            if (title != null) ...[
              Text(
                title!,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              AppDimens.vGapM,
            ],
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            AppDimens.vGapXL,
            if (onRetry != null) ...[
              SltPrimaryButton(
                text: retryText,
                onPressed: onRetry,
              ),
            ],
            if (onCustomAction != null && customActionText != null) ...[
              AppDimens.vGapM,
              TextButton(
                onPressed: onCustomAction,
                child: Text(customActionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

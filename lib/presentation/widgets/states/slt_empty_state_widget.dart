import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_assets.dart';
import 'package:slt_app/core/constants/app_strings.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';

/// Empty state widget
/// Displays empty state information with optional action button
class SltEmptyStateWidget extends StatelessWidget {
  /// Empty state message to display
  final String message;

  /// Title of the empty state
  final String? title;

  /// Icon to display
  final IconData icon;

  /// Icon color
  final Color? iconColor;

  /// Icon size
  final double iconSize;

  /// Action callback function
  final VoidCallback? onAction;

  /// Action button text
  final String? actionText;

  /// Whether to use an image instead of an icon
  final bool useImage;

  /// Image path to use if useImage is true
  final String imagePath;

  /// Image width
  final double imageWidth;

  /// Image height
  final double imageHeight;

  /// Whether to add extra padding at the bottom (useful when in a list)
  final bool addBottomPadding;

  const SltEmptyStateWidget({
    Key? key,
    this.message = AppStrings.emptyStateDescription,
    this.title = AppStrings.emptyStateTitle,
    this.icon = Icons.inbox_outlined,
    this.iconColor,
    this.iconSize = 64.0,
    this.onAction,
    this.actionText,
    this.useImage = false,
    this.imagePath = AppAssets.emptyState,
    this.imageWidth = 150.0,
    this.imageHeight = 150.0,
    this.addBottomPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppDimens.screenPadding.add(
          EdgeInsets.only(bottom: addBottomPadding ? AppDimens.paddingXL : 0),
        ),
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
            if (onAction != null && actionText != null) ...[
              AppDimens.vGapXL,
              SltPrimaryButton(
                text: actionText!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

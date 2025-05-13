import 'package:flutter/material.dart';

import '../../../core/theme/app_dimens.dart';

/// Loading state widget
/// Displays a loading spinner and optional message
class SltLoadingStateWidget extends StatelessWidget {
  /// Message to display below the spinner (optional)
  final String? message;

  /// Whether to show the loading indicator with an opaque background
  final bool isOpaque;

  /// Loading indicator size
  final double size;

  /// Loading indicator color
  final Color? color;

  /// Loading indicator stroke width
  final double strokeWidth;

  /// Whether to disable interaction with widgets behind the loading state
  final bool disableInteraction;

  const SltLoadingStateWidget({
    Key? key,
    this.message,
    this.isOpaque = false,
    this.size = AppDimens.loadingIndicatorSize,
    this.color,
    this.strokeWidth = 4.0,
    this.disableInteraction = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final loadingIndicator = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            strokeWidth: strokeWidth,
            color: color ?? theme.colorScheme.primary,
          ),
          if (message != null) ...[
            AppDimens.vGapL,
            Text(
              message!,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );

    if (isOpaque) {
      return Material(
        color: theme.colorScheme.surface,
        child: loadingIndicator,
      );
    }

    if (disableInteraction) {
      return AbsorbPointer(
        child: loadingIndicator,
      );
    }

    return loadingIndicator;
  }
}

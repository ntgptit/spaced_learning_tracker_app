// lib/presentation/widgets/common/state/sl_loading_state_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

/// Types of loading animations available
enum LoadingIndicatorType {
  circular,
  pulse,
  threeBounce,
  wave,
  fadingCircle,
  circularProgress,
}

/// Size options for loading indicators
enum SlLoadingSize { small, medium, large }

/// A widget that displays different types of loading indicators with optional message
/// and fullscreen overlay capabilities. Can be used both as a standalone loading indicator
/// or as a full loading state widget.
class SlLoadingStateWidget extends ConsumerWidget {
  /// Optional message to display below the loading indicator
  final String? message;

  /// Type of loading animation to display
  final LoadingIndicatorType type;

  /// Size of the loading indicator
  final SlLoadingSize size;

  /// Custom color for the loading indicator
  final Color? color;

  /// Whether to display as a fullscreen overlay
  final bool fullScreen;

  /// Optional background widget for fullscreen mode
  final Widget? backgroundWidget;

  /// Whether the loading state can be dismissed
  final bool dismissible;

  /// Callback when dismissed (only used if dismissible is true)
  final VoidCallback? onDismiss;

  const SlLoadingStateWidget({
    super.key,
    this.message,
    this.type = LoadingIndicatorType.threeBounce,
    this.size = SlLoadingSize.medium,
    this.color,
    this.fullScreen = false,
    this.backgroundWidget,
    this.dismissible = false,
    this.onDismiss,
  });

  /// Factory constructor for full-screen loading overlay
  factory SlLoadingStateWidget.fullScreen({
    String? message,
    Color? color,
    LoadingIndicatorType type = LoadingIndicatorType.fadingCircle,
    Widget? background,
    bool dismissible = false,
    VoidCallback? onDismiss,
  }) {
    return SlLoadingStateWidget(
      message: message,
      type: type,
      size: SlLoadingSize.large,
      color: color,
      fullScreen: true,
      backgroundWidget: background,
      dismissible: dismissible,
      onDismiss: onDismiss,
    );
  }

  /// Factory constructor for small loading indicator
  factory SlLoadingStateWidget.small({
    Color? color,
    LoadingIndicatorType type = LoadingIndicatorType.threeBounce,
  }) {
    return SlLoadingStateWidget(
      size: SlLoadingSize.small,
      type: type,
      color: color,
    );
  }

  /// Factory constructor for loading indicator with a message
  factory SlLoadingStateWidget.withMessage(
    String message, {
    LoadingIndicatorType type = LoadingIndicatorType.threeBounce,
    Color? color,
  }) {
    return SlLoadingStateWidget(message: message, type: type, color: color);
  }

  /// Get the size value based on the selected size enum
  double _getSizeValue() {
    switch (size) {
      case SlLoadingSize.small:
        return AppDimens.circularProgressSize;
      case SlLoadingSize.medium:
        return AppDimens.circularProgressSizeL;
      case SlLoadingSize.large:
        return AppDimens.iconXXL;
    }
  }

  /// Build the appropriate loading indicator based on the type
  Widget _buildLoadingIndicator(double indicatorSize, Color indicatorColor) {
    switch (type) {
      case LoadingIndicatorType.circular:
        return SpinKitCircle(color: indicatorColor, size: indicatorSize);
      case LoadingIndicatorType.pulse:
        return SpinKitPulse(color: indicatorColor, size: indicatorSize);
      case LoadingIndicatorType.threeBounce:
        return FittedBox(
          child: SpinKitThreeBounce(
            color: indicatorColor,
            size: indicatorSize * 0.7,
          ),
        );
      case LoadingIndicatorType.wave:
        return SpinKitWave(color: indicatorColor, size: indicatorSize * 0.8);
      case LoadingIndicatorType.fadingCircle:
        return SpinKitFadingCircle(color: indicatorColor, size: indicatorSize);
      case LoadingIndicatorType.circularProgress:
        return SizedBox(
          width: indicatorSize,
          height: indicatorSize,
          child: CircularProgressIndicator(
            strokeWidth: indicatorSize / 10,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final indicatorColor = color ?? colorScheme.primary;
    final double actualIndicatorSize = _getSizeValue();

    // Create the loading indicator
    final Widget loadingIndicator = _buildLoadingIndicator(
      actualIndicatorSize,
      indicatorColor,
    );

    // Create the main content with loading indicator and optional message
    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: actualIndicatorSize,
          height: actualIndicatorSize,
          child: loadingIndicator,
        ),
        if (message != null) ...[
          const SizedBox(height: AppDimens.spaceM),
          Text(
            message!,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    // Return centered content if not fullscreen
    if (!fullScreen) {
      return Center(child: content);
    }

    // Return fullscreen overlay with content and optional dismiss button
    return Stack(
      children: [
        // Background
        backgroundWidget ??
            Container(
              color: colorScheme.surface.withOpacity(AppDimens.opacityHigh),
            ),
        // Centered loading content
        Center(child: content),
        // Optional dismiss button
        if (dismissible && onDismiss != null)
          Positioned(
            top: AppDimens.paddingXL,
            right: AppDimens.paddingL,
            child: IconButton(
              icon: Icon(Icons.close, color: colorScheme.onSurface),
              onPressed: onDismiss,
              tooltip: 'Dismiss',
            ),
          ),
      ],
    );
  }
}

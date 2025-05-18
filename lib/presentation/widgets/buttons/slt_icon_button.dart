import 'package:flutter/material.dart';

import '../../../core/theme/app_dimens.dart';

/// Icon button widget
/// A button that displays only an icon
class SltIconButton extends StatelessWidget {
  /// Icon data to display
  final IconData icon;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Icon size
  final double iconSize;

  /// Icon color
  final Color? iconColor;

  /// Button background color
  final Color? backgroundColor;

  /// Border radius
  final double borderRadius;

  /// Padding inside the button
  final EdgeInsetsGeometry padding;

  /// Whether the button is a loading state
  final bool isLoading;

  /// Whether the button is enabled
  final bool isEnabled;

  /// Tooltip text
  final String? tooltip;

  /// Visual density of the button
  final VisualDensity visualDensity;

  const SltIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconSize = AppDimens.iconM,
    this.iconColor,
    this.backgroundColor,
    this.borderRadius = AppDimens.radiusS,
    this.padding = const EdgeInsets.all(AppDimens.paddingS),
    this.isLoading = false,
    this.isEnabled = true,
    this.tooltip,
    this.visualDensity = VisualDensity.compact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonBackground = backgroundColor ?? Colors.transparent;
    final buttonForeground = iconColor ?? theme.colorScheme.primary;

    final buttonStyle = IconButton.styleFrom(
      foregroundColor: buttonForeground,
      backgroundColor: buttonBackground,
      highlightColor: buttonForeground.withValues(alpha: 0.1),
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    final buttonContent = isLoading
        ? _buildLoadingContent(context)
        : Icon(icon, size: iconSize, color: buttonForeground);

    return IconButton(
      icon: buttonContent,
      onPressed: (isEnabled && !isLoading) ? onPressed : null,
      tooltip: tooltip,
      style: buttonStyle,
      visualDensity: visualDensity,
    );
  }

  /// Build loading indicator
  Widget _buildLoadingContent(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: iconSize * 0.8,
      width: iconSize * 0.8,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          iconColor ?? theme.colorScheme.primary,
        ),
      ),
    );
  }
}

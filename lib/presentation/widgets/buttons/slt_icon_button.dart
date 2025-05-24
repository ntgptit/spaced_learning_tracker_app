import 'package:flutter/material.dart';

import '../../../core/theme/app_dimens.dart';

class SltIconButton extends StatelessWidget {
  final IconData icon;

  final VoidCallback? onPressed;

  final double iconSize;

  final Color? iconColor;

  final Color? backgroundColor;

  final double borderRadius;

  final EdgeInsetsGeometry padding;

  final bool isLoading;

  final bool isEnabled;

  final String? tooltip;

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

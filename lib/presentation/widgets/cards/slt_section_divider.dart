import 'package:flutter/material.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltSectionDivider extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onActionPressed;
  final String? actionText;
  final IconData? actionIcon;

  const SltSectionDivider({
    super.key,
    required this.title,
    this.icon,
    this.color,
    this.onActionPressed,
    this.actionText,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveColor = color ?? theme.colorScheme.primary;

    return Column(
      children: [
        Container(
          height: AppDimens.dividerThickness,
          color: colorScheme.surfaceContainerHighest,
          margin: const EdgeInsets.symmetric(vertical: AppDimens.spaceM),
        ),

        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: effectiveColor, size: AppDimens.iconM),
              const SizedBox(width: AppDimens.spaceS),
            ],
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: effectiveColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),

            if (onActionPressed != null &&
                (actionText != null || actionIcon != null)) ...[
              TextButton.icon(
                onPressed: onActionPressed,
                icon: Icon(
                  actionIcon ?? Icons.arrow_forward,
                  size: AppDimens.iconS,
                ),
                label: actionText != null
                    ? Text(actionText!)
                    : const SizedBox.shrink(),
                style: TextButton.styleFrom(
                  foregroundColor: effectiveColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.paddingS,
                    vertical: AppDimens.paddingXS,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

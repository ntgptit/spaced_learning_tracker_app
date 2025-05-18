// lib/presentation/widgets/cards/slt_stat_card.dart
import 'package:flutter/material.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;
  final Color? backgroundColor;
  final bool elevated;
  final VoidCallback? onTap;
  final Widget? customContent;
  final double borderRadius;

  const SltStatCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.backgroundColor,
    this.elevated = true,
    this.onTap,
    this.customContent,
    this.borderRadius = AppDimens.radiusM,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveIconColor = iconColor ?? colorScheme.primary;
    final effectiveValueColor = valueColor ?? colorScheme.onSurface;
    final effectiveBackgroundColor =
        backgroundColor ??
        (elevated ? colorScheme.surface : colorScheme.surfaceContainerLow);

    return Card(
      elevation: elevated ? AppDimens.elevationS : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: elevated
            ? BorderSide.none
            : BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
                width: 1,
              ),
      ),
      color: effectiveBackgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingM),
          child:
              customContent ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          size: AppDimens.iconM,
                          color: effectiveIconColor,
                        ),
                        const SizedBox(width: AppDimens.spaceS),
                      ],
                      Expanded(
                        child: Text(
                          title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  Text(
                    value,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: effectiveValueColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppDimens.spaceXS),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
        ),
      ),
    );
  }
} // Stat card placeholder

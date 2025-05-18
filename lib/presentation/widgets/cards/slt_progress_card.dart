// lib/presentation/widgets/cards/slt_progress_card.dart
import 'package:flutter/material.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltProgressCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double progress;
  final VoidCallback? onTap;
  final Color? progressColor;
  final Color? backgroundColor;
  final IconData? leadingIcon;
  final Widget? trailing;
  final bool elevated;
  final double borderRadius;

  const SltProgressCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.progress,
    this.onTap,
    this.progressColor,
    this.backgroundColor,
    this.leadingIcon,
    this.trailing,
    this.elevated = true,
    this.borderRadius = AppDimens.radiusM,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveProgressColor = progressColor ?? colorScheme.primary;
    final effectiveBackgroundColor =
        backgroundColor ??
        (elevated ? colorScheme.surface : colorScheme.surfaceContainerLow);

    // Format progress as percentage
    final progressPercent = (progress * 100).toInt();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimens.paddingM),
              child: Row(
                children: [
                  if (leadingIcon != null) ...[
                    Icon(
                      leadingIcon,
                      size: AppDimens.iconM,
                      color: effectiveProgressColor,
                    ),
                    const SizedBox(width: AppDimens.spaceM),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: AppDimens.spaceXS),
                          Text(
                            subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimens.spaceS),
                  trailing ??
                      Text(
                        '$progressPercent%',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: effectiveProgressColor,
                        ),
                      ),
                ],
              ),
            ),
            // Progress indicator
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: effectiveProgressColor.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(effectiveProgressColor),
              minHeight: AppDimens.lineProgressHeight,
            ),
          ],
        ),
      ),
    );
  }
}

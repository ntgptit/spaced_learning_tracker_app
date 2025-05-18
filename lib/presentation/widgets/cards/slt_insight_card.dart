// lib/presentation/widgets/cards/slt_insight_card.dart
import 'package:flutter/material.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltInsightCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color? accentColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool elevated;
  final double borderRadius;

  const SltInsightCard({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.accentColor,
    this.backgroundColor,
    this.onTap,
    this.elevated = true,
    this.borderRadius = AppDimens.radiusM,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveAccentColor = accentColor ?? colorScheme.primary;
    final effectiveBackgroundColor =
        backgroundColor ??
        (elevated ? colorScheme.surface : colorScheme.surfaceContainerLow);

    return Card(
      elevation: elevated ? AppDimens.elevationS : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: elevated
            ? BorderSide.none
            : BorderSide(color: colorScheme.outline.withOpacity(0.5), width: 1),
      ),
      color: effectiveBackgroundColor,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: effectiveAccentColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: effectiveAccentColor,
                  size: AppDimens.iconM,
                ),
              ),
              const SizedBox(width: AppDimens.spaceM),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: effectiveAccentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceXS),
                    Text(
                      message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

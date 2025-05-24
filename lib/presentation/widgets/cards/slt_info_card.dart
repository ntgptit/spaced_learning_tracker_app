// lib/presentation/widgets/cards/slt_info_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/theme/app_typography.dart';

class SltInfoCard extends ConsumerWidget {
  final IconData? icon;
  final String title;
  final String? subtitle;
  final Widget? content;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;

  const SltInfoCard({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.content,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.padding,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveIconColor = iconColor ?? colorScheme.primary;
    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainerLow;
    final effectivePadding =
        padding ?? const EdgeInsets.all(AppDimens.paddingL);
    final effectiveBorderRadiusGeometry =
        borderRadius ?? BorderRadius.circular(AppDimens.radiusM);
    final effectiveElevation = elevation ?? AppDimens.elevationS;

    BorderRadius? inkWellBorderRadius;
    if (effectiveBorderRadiusGeometry is BorderRadius) {
      inkWellBorderRadius = effectiveBorderRadiusGeometry;
    } else {
      inkWellBorderRadius = effectiveBorderRadiusGeometry as BorderRadius?;
    }

    final Widget cardInnerContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: AppDimens.paddingM),
                child: Icon(
                  icon,
                  color: effectiveIconColor,
                  size: AppDimens.iconL,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.titleLarge.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: AppDimens.paddingXS),
                      child: Text(
                        subtitle!,
                        style: AppTypography.bodyMedium.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (content != null)
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.paddingM),
            child: content,
          ),
      ],
    );

    Widget cardDisplayContent;

    if (onTap != null) {
      cardDisplayContent = InkWell(
        onTap: onTap,
        borderRadius: inkWellBorderRadius, // Corrected
        child: Padding(padding: effectivePadding, child: cardInnerContent),
      );
    } else {
      cardDisplayContent = Padding(
        padding: effectivePadding,
        child: cardInnerContent,
      );
    }

    return Card(
      elevation: effectiveElevation,
      color: effectiveBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadiusGeometry,
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: cardDisplayContent,
    );
  }
}

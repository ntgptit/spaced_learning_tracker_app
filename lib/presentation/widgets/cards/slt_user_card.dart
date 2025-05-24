import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/theme/app_typography.dart';

import '../media/slt_avatar_image.dart';

class SltUserCard extends ConsumerWidget {
  final String userName;
  final String? userSubtitle;
  final String? avatarUrl;
  final IconData? placeholderIcon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? backgroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const SltUserCard({
    super.key,
    required this.userName,
    this.userSubtitle,
    this.avatarUrl,
    this.placeholderIcon = Icons.person_outline,
    this.onTap,
    this.trailing,
    this.backgroundColor,
    this.elevation,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainerLow;
    final effectiveElevation = elevation ?? AppDimens.elevationNone;
    final effectivePadding =
        padding ?? const EdgeInsets.all(AppDimens.paddingM);
    final effectiveBorderRadiusGeometry =
        borderRadius ?? BorderRadius.circular(AppDimens.radiusM);

    BorderRadius? inkWellBorderRadius;
    if (effectiveBorderRadiusGeometry is BorderRadius) {
      inkWellBorderRadius = effectiveBorderRadiusGeometry;
    } else {
      inkWellBorderRadius = effectiveBorderRadiusGeometry as BorderRadius?;
    }

    final Widget cardInnerContent = Row(
      children: [
        SltAvatarImage(
          imageUrl: avatarUrl,
          radius: AppDimens.avatarSizeM / 2,
          backgroundColor: colorScheme.primaryContainer,
          iconColor: colorScheme.onPrimaryContainer,
        ),
        const SizedBox(width: AppDimens.paddingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName,
                style: AppTypography.titleMedium.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (userSubtitle != null && userSubtitle!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppDimens.paddingXXS),
                  child: Text(
                    userSubtitle!,
                    style: AppTypography.bodySmall.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
        if (trailing != null)
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.paddingS),
            child: trailing,
          ),
      ],
    );

    final cardShape = RoundedRectangleBorder(
      borderRadius: effectiveBorderRadiusGeometry,
      side: BorderSide(
        color: colorScheme.outlineVariant.withOpacity(0.3),
        width: 0.5,
      ),
    );

    if (onTap != null) {
      return Card(
        elevation: effectiveElevation,
        color: effectiveBackgroundColor,
        shape: cardShape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: inkWellBorderRadius, // Corrected
          child: Padding(padding: effectivePadding, child: cardInnerContent),
        ),
      );
    }

    return Card(
      elevation: effectiveElevation,
      color: effectiveBackgroundColor,
      shape: cardShape,
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: effectivePadding, child: cardInnerContent),
    );
  }
}

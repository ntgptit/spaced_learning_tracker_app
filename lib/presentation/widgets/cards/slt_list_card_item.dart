import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/theme/app_typography.dart';

class SltListCardItem extends ConsumerWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool enabled;
  final Color? backgroundColor; // Card background
  final Color? selectedBackgroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const SltListCardItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.enabled = true,
    this.backgroundColor,
    this.selectedBackgroundColor,
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
    final effectiveSelectedBackgroundColor =
        selectedBackgroundColor ??
        colorScheme.primaryContainer.withValues(alpha: 0.2);
    final effectiveElevation =
        elevation ??
        (isSelected ? AppDimens.elevationXS : AppDimens.elevationNone);
    final effectivePadding =
        padding ??
        const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingM,
          vertical: AppDimens.paddingS,
        );
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppDimens.radiusM);

    final titleStyle = AppTypography.titleMedium.copyWith(
      color: enabled
          ? (isSelected ? colorScheme.primary : colorScheme.onSurface)
          : colorScheme.onSurface.withValues(
              alpha: AppDimens.opacityDisabledText,
            ),
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
    );
    final subtitleStyle = AppTypography.bodyMedium.copyWith(
      color: enabled
          ? colorScheme.onSurfaceVariant
          : colorScheme.onSurfaceVariant.withValues(
              alpha: AppDimens.opacityDisabledText,
            ),
    );

    return Card(
      elevation: effectiveElevation,
      color: isSelected
          ? effectiveSelectedBackgroundColor
          : effectiveBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
        side: BorderSide(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.5)
              : colorScheme.outlineVariant.withValues(alpha: 0.3),
          width: isSelected ? 1.0 : 0.5,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: AppDimens.paddingXS / 2),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        child: Padding(
          padding: effectivePadding,
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppDimens.paddingM),
                  child: IconTheme(
                    data: IconThemeData(
                      color: enabled
                          ? (isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant)
                          : colorScheme.onSurfaceVariant.withValues(
                              alpha: AppDimens.opacityDisabledText,
                            ),
                      size: AppDimens.iconL, // Consistent icon size
                    ),
                    child: leading!,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: titleStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null && subtitle!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimens.paddingXXS,
                        ),
                        child: Text(
                          subtitle!,
                          style: subtitleStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: AppDimens.paddingM),
                  child: IconTheme(
                    data: IconThemeData(
                      color: enabled
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurfaceVariant.withValues(
                              alpha: AppDimens.opacityDisabledText,
                            ),
                      size: AppDimens.iconM, // Consistent icon size
                    ),
                    child: trailing!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

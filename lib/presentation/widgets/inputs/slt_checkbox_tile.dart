import 'package:flutter/material.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

enum SltCheckboxTileSize { small, medium, large }

class SltCheckboxTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final IconData? leadingIcon;
  final Widget? leading;
  final bool isThreeLine;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final Color? activeColor;
  final Color? checkColor;
  final bool enabled;
  final SltCheckboxTileSize size;
  final bool autofocus;
  final Color? tileColor;
  final Color? selectedTileColor;
  final ShapeBorder? shape;

  const SltCheckboxTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.leadingIcon,
    this.leading,
    this.isThreeLine = false,
    this.dense = false,
    this.contentPadding,
    this.activeColor,
    this.checkColor,
    this.enabled = true,
    this.size = SltCheckboxTileSize.medium,
    this.autofocus = false,
    this.tileColor,
    this.selectedTileColor,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveActiveColor = activeColor ?? colorScheme.primary;
    final effectiveCheckColor = checkColor ?? colorScheme.onPrimary;

    final Widget? effectiveLeading =
        leading ??
        (leadingIcon != null
            ? Icon(
                leadingIcon,
                color: value && enabled
                    ? effectiveActiveColor
                    : colorScheme.onSurfaceVariant,
                size: _getIconSize(),
              )
            : null);

    return CheckboxListTile(
      title: Text(title, style: _getTitleStyle(theme, colorScheme)),
      subtitle: subtitle != null
          ? Text(subtitle!, style: _getSubtitleStyle(theme, colorScheme))
          : null,
      value: value,
      onChanged: enabled ? onChanged : null,
      secondary: effectiveLeading,
      isThreeLine: isThreeLine,
      dense: dense || size == SltCheckboxTileSize.small,
      contentPadding: contentPadding ?? _getContentPadding(),
      activeColor: effectiveActiveColor,
      checkColor: effectiveCheckColor,
      autofocus: autofocus,
      tileColor: tileColor,
      selectedTileColor: selectedTileColor,
      shape:
          shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
          ),
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }

  TextStyle? _getTitleStyle(ThemeData theme, ColorScheme colorScheme) {
    final color = enabled
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: AppDimens.opacityDisabled);

    switch (size) {
      case SltCheckboxTileSize.small:
        return theme.textTheme.bodyMedium?.copyWith(color: color);
      case SltCheckboxTileSize.large:
        return theme.textTheme.titleMedium?.copyWith(color: color);
      case SltCheckboxTileSize.medium:
        return theme.textTheme.bodyLarge?.copyWith(color: color);
    }
  }

  TextStyle? _getSubtitleStyle(ThemeData theme, ColorScheme colorScheme) {
    final color = enabled
        ? colorScheme.onSurfaceVariant
        : colorScheme.onSurfaceVariant.withValues(
            alpha: AppDimens.opacityDisabled,
          );

    switch (size) {
      case SltCheckboxTileSize.small:
        return theme.textTheme.bodySmall?.copyWith(color: color);
      case SltCheckboxTileSize.large:
        return theme.textTheme.bodyMedium?.copyWith(color: color);
      case SltCheckboxTileSize.medium:
        return theme.textTheme.bodySmall?.copyWith(color: color);
    }
  }

  double _getIconSize() {
    switch (size) {
      case SltCheckboxTileSize.small:
        return AppDimens.iconS;
      case SltCheckboxTileSize.large:
        return AppDimens.iconL;
      case SltCheckboxTileSize.medium:
        return AppDimens.iconM;
    }
  }

  EdgeInsetsGeometry _getContentPadding() {
    switch (size) {
      case SltCheckboxTileSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingS,
          vertical: AppDimens.paddingXS,
        );
      case SltCheckboxTileSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingL,
          vertical: AppDimens.paddingM,
        );
      case SltCheckboxTileSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingM,
          vertical: AppDimens.paddingS,
        );
    }
  }
}

// lib/presentation/widgets/common/button/slt_button_base.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

part 'slt_button_base.g.dart';

enum SlttButtonVariant { filled, tonal, outlined, text }

enum SlttButtonSize { small, medium, large }

@riverpod
class ButtonState extends _$ButtonState {
  @override
  bool build({String id = 'default'}) => false;

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}

class SlttButtonBase extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? loadingId;
  final bool isFullWidth;
  final SlttButtonSize size;
  final SlttButtonVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final BorderSide? borderSide;

  const SlttButtonBase({
    super.key,
    required this.text,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.loadingId,
    this.isFullWidth = false,
    this.size = SlttButtonSize.medium,
    this.variant = SlttButtonVariant.filled,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.borderSide,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLoading = loadingId != null
        ? ref.watch(buttonStateProvider(id: loadingId!))
        : false;

    // Determine button style based on variant
    final ButtonStyle buttonStyle = _getButtonStyle(theme, colorScheme);

    // Get effective size parameters
    final (effectiveHeight, effectiveIconSize) = _getSizeParameters();
    final effectivePadding = padding ?? _getDefaultPadding();

    // Build button
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: isLoading || onPressed == null ? null : onPressed,
        style: buttonStyle,
        child: Padding(
          padding: effectivePadding,
          child: Row(
            mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null && !isLoading) ...[
                Icon(prefixIcon, size: effectiveIconSize),
                const SizedBox(width: AppDimens.spaceS),
              ],
              if (isLoading) ...[
                SizedBox(
                  width: effectiveIconSize,
                  height: effectiveIconSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getProgressColor(colorScheme),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimens.spaceS),
              ],
              Flexible(
                child: Text(
                  text,
                  style: _getTextStyle(theme),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              if (suffixIcon != null && !isLoading) ...[
                const SizedBox(width: AppDimens.spaceS),
                Icon(suffixIcon, size: effectiveIconSize),
              ],
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme, ColorScheme colorScheme) {
    final effectiveElevation = elevation ?? _getDefaultElevation();
    final effectiveBorderRadius = borderRadius ?? _getDefaultBorderRadius();

    // Xác định màu chữ mặc định dựa trên loại button
    final defaultForegroundColor = variant == SlttButtonVariant.filled
        ? Colors
              .white // Luôn sử dụng màu trắng cho filled button
        : (variant == SlttButtonVariant.tonal
              ? colorScheme.onSecondaryContainer
              : colorScheme.primary);

    switch (variant) {
      case SlttButtonVariant.filled:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary,
          foregroundColor: foregroundColor ?? defaultForegroundColor,
          elevation: effectiveElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          padding: EdgeInsets.zero,
          disabledBackgroundColor: colorScheme.primary.withOpacity(0.38),
          disabledForegroundColor: Colors.white.withOpacity(0.38),
        );

      case SlttButtonVariant.tonal:
        return ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.secondaryContainer,
          foregroundColor: foregroundColor ?? colorScheme.onSecondaryContainer,
          elevation: effectiveElevation / 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          padding: EdgeInsets.zero,
        );

      case SlttButtonVariant.outlined:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: foregroundColor ?? colorScheme.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            side:
                borderSide ??
                BorderSide(
                  color: colorScheme.outline,
                  width: AppDimens.outlineButtonBorderWidth,
                ),
          ),
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
        );

      case SlttButtonVariant.text:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: foregroundColor ?? colorScheme.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
          ),
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
        );
    }
  }

  (double, double) _getSizeParameters() {
    switch (size) {
      case SlttButtonSize.small:
        return (AppDimens.buttonHeightS, AppDimens.iconS);
      case SlttButtonSize.medium:
        return (AppDimens.buttonHeightM, AppDimens.iconM);
      case SlttButtonSize.large:
        return (AppDimens.buttonHeightL, AppDimens.iconL);
    }
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    switch (size) {
      case SlttButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingM,
          vertical: AppDimens.paddingXS,
        );
      case SlttButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingL,
          vertical: AppDimens.paddingS,
        );
      case SlttButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingXL,
          vertical: AppDimens.paddingM,
        );
    }
  }

  double _getDefaultElevation() {
    switch (variant) {
      case SlttButtonVariant.filled:
        return AppDimens.elevationS;
      case SlttButtonVariant.tonal:
        return AppDimens.elevationXS;
      case SlttButtonVariant.outlined:
      case SlttButtonVariant.text:
        return 0;
    }
  }

  double _getDefaultBorderRadius() => AppDimens.radiusM;

  TextStyle? _getTextStyle(ThemeData theme) {
    final baseStyle = switch (size) {
      SlttButtonSize.small => theme.textTheme.labelMedium,
      SlttButtonSize.medium => theme.textTheme.labelLarge,
      SlttButtonSize.large => theme.textTheme.titleMedium,
    };

    // Nếu là button filled, đảm bảo chữ luôn là trắng
    if (variant == SlttButtonVariant.filled) {
      return baseStyle?.copyWith(
        color: foregroundColor ?? Colors.white,
        fontWeight: FontWeight.w500,
      );
    }

    return baseStyle;
  }

  Color _getProgressColor(ColorScheme colorScheme) {
    switch (variant) {
      case SlttButtonVariant.filled:
        return Colors.white; // Luôn dùng màu trắng cho loading indicator
      case SlttButtonVariant.tonal:
        return colorScheme.onSecondaryContainer;
      case SlttButtonVariant.outlined:
      case SlttButtonVariant.text:
        return colorScheme.primary;
    }
  }
}

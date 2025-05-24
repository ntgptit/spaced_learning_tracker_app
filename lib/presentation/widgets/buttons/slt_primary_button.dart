import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_button_base.dart';

class SltPrimaryButton extends ConsumerWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? loadingId;
  final bool isFullWidth;
  final SltButtonSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? borderRadius;

  const SltPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.loadingId,
    this.isFullWidth = false,
    this.size = SltButtonSize.medium,
    this.backgroundColor,
    this.foregroundColor = Colors.white, // Mặc định màu chữ là trắng
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final effectiveForegroundColor = foregroundColor ?? Colors.white;

    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.primary;

    return SltButtonBase(
      text: text,
      onPressed: onPressed,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      loadingId: loadingId,
      isFullWidth: isFullWidth,
      size: size,
      variant: SltButtonVariant.filled,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: elevation,
      borderRadius: borderRadius,
    );
  }
}

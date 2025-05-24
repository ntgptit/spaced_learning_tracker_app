import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'slt_button_base.dart';

part 'slt_progress_button.g.dart';

@riverpod
class ProgressButtonState extends _$ProgressButtonState {
  @override
  bool build({String id = 'default'}) => false;

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}

class SltProgressButton extends ConsumerWidget {
  final String text;

  final Future<void> Function()? onPressed;

  final String loadingId;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isFullWidth;
  final SltButtonSize size;
  final SltButtonVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? borderRadius;

  const SltProgressButton({
    super.key,
    required this.text,
    required this.loadingId,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.isFullWidth = false,
    this.size = SltButtonSize.medium,
    this.variant = SltButtonVariant.filled,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(progressButtonStateProvider(id: loadingId));

    return SltButtonBase(
      text: text,
      loadingId: loadingId,
      onPressed: onPressed == null
          ? null
          : () async {
              if (isLoading) return; // Prevent multiple calls

              final notifier = ref.read(
                progressButtonStateProvider(id: loadingId).notifier,
              );
              try {
                if (!ref.exists(progressButtonStateProvider(id: loadingId))) {
                  return;
                }
                notifier.setLoading(true);

                await onPressed!();
              } catch (e) {
                rethrow;
              } finally {
                if (ref.exists(progressButtonStateProvider(id: loadingId))) {
                  notifier.setLoading(false);
                }
              }
            },
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      isFullWidth: isFullWidth,
      size: size,
      variant: variant,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      borderRadius: borderRadius,
    );
  }
}

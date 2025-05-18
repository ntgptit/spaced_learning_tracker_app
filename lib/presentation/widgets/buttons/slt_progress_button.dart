// lib/presentation/widgets/common/button/slt_progress_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'slt_button_base.dart'; // Ensure this path points to your SlttButtonBase file
// which includes the @riverpod ButtonState provider.

class SltProgressButton extends ConsumerWidget {
  final String text;

  /// Asynchronous function executed on press.
  /// SltProgressButton automatically manages loading state for the `loadingId`.
  final Future<void> Function()? onPressed;

  /// Unique ID to link with `buttonStateProvider` (defined in SlttButtonBase)
  /// for loading state management.
  final String loadingId;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isFullWidth;
  final SlttButtonSize size;
  final SlttButtonVariant variant;
  final Color? backgroundColor;
  final Color? foregroundColor;

  // You can add other SlttButtonBase props here if needed,
  // e.g., borderRadius, padding, elevation, borderSide

  const SltProgressButton({
    super.key,
    required this.text,
    required this.loadingId,
    this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.isFullWidth = false,
    this.size = SlttButtonSize.medium,
    this.variant = SlttButtonVariant.filled,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SlttButtonBase automatically tracks the loading state from buttonStateProvider
    // (which is an annotated Riverpod provider) via the passed loadingId.

    return SlttButtonBase(
      text: text,
      loadingId: loadingId,
      onPressed: onPressed == null
          ? null
          : () async {
              // If onPressed is provided, SltProgressButton manages the loading state.
              final notifier = ref.read(
                buttonStateProvider(id: loadingId).notifier,
              );
              try {
                // Check if the widget is still mounted (provider exists) before updating state.
                if (!ref.exists(buttonStateProvider(id: loadingId))) return;
                notifier.setLoading(true);

                await onPressed!();
              } catch (e) {
                // Optionally log the error or handle it based on your app's needs.
                // For example: debugPrint("Error in SltProgressButton: $e");
                rethrow; // Rethrow to allow the caller to handle it if necessary.
              } finally {
                // Ensure setLoading(false) is called, even if an error occurred
                // or if the widget was disposed during the async operation.
                if (ref.exists(buttonStateProvider(id: loadingId))) {
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
      // Pass through other SlttButtonBase props if you added them.
    );
  }
}

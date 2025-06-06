// lib/presentation/widgets/buttons/slt_toggle_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

import '../../providers/common_button_provider.dart';

class SltToggleButton extends ConsumerWidget {
  final String toggleId;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final IconData? icon;
  final Color? activeColor;
  final Color? inactiveColor;
  final bool isDisabled;

  const SltToggleButton({
    super.key,
    required this.toggleId,
    this.initialValue = false,
    this.onChanged,
    this.label,
    this.icon,
    this.activeColor,
    this.inactiveColor,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Initialize the toggle state if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(commonButtonStateProvider.notifier);
      if (!notifier.getButtonState(toggleId).isToggled && initialValue) {
        notifier.setToggle(toggleId, initialValue);
      }
    });

    final value = ref.watch(buttonIsToggledProvider(toggleId));

    final effectiveActiveColor = activeColor ?? colorScheme.primary;
    final effectiveInactiveColor =
        inactiveColor ?? colorScheme.surfaceContainerHighest;

    void handleToggle() {
      if (isDisabled) return;

      final notifier = ref.read(commonButtonStateProvider.notifier);
      notifier.toggle(toggleId);

      if (onChanged != null) {
        onChanged!(!value);
      }
    }

    return InkWell(
      onTap: isDisabled ? null : handleToggle,
      borderRadius: BorderRadius.circular(AppDimens.radiusM),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingM,
          vertical: AppDimens.paddingS,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isDisabled
                    ? colorScheme.onSurface.withValues(
                        alpha: AppDimens.opacityDisabled,
                      )
                    : (value
                          ? effectiveActiveColor
                          : colorScheme.onSurfaceVariant),
                size: AppDimens.iconM,
              ),
              const SizedBox(width: AppDimens.spaceM),
            ],
            if (label != null) ...[
              Text(
                label!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDisabled
                      ? colorScheme.onSurface.withValues(
                          alpha: AppDimens.opacityDisabled,
                        )
                      : colorScheme.onSurface,
                ),
              ),
              const SizedBox(width: AppDimens.spaceM),
            ],
            Switch(
              value: value,
              onChanged: isDisabled ? null : (_) => handleToggle(),
              activeColor: effectiveActiveColor,
              inactiveTrackColor: effectiveInactiveColor,
            ),
          ],
        ),
      ),
    );
  }
}

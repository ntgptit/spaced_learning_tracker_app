// lib/presentation/widgets/buttons/slt_expandable_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

import '../../providers/common_button_provider.dart';

class SltExpandableButton extends ConsumerWidget {
  final String expandableId;
  final String label;
  final List<Widget> children;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool initiallyExpanded;
  final bool isDisabled;
  final VoidCallback? onTap;

  const SltExpandableButton({
    super.key,
    required this.expandableId,
    required this.label,
    required this.children,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.initiallyExpanded = false,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Initialize expansion state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(commonButtonStateProvider.notifier);
      if (initiallyExpanded && !notifier.isExpanded(expandableId)) {
        notifier.setExpanded(expandableId, initiallyExpanded);
      }
    });

    final isExpanded = ref.watch(buttonIsExpandedProvider(expandableId));
    final rotationAngle = isExpanded ? 0.5 : 0.0;

    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainerLow;
    final effectiveForegroundColor = foregroundColor ?? colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: isDisabled
                ? null
                : () {
                    final notifier = ref.read(
                      commonButtonStateProvider.notifier,
                    );
                    notifier.toggleExpansion(expandableId);

                    if (onTap != null) {
                      onTap!();
                    }
                  },
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.paddingM),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: isDisabled
                          ? colorScheme.onSurface.withValues(
                              alpha: AppDimens.opacityDisabled,
                            )
                          : effectiveForegroundColor,
                      size: AppDimens.iconM,
                    ),
                    const SizedBox(width: AppDimens.spaceM),
                  ],
                  Expanded(
                    child: Text(
                      label,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: isDisabled
                            ? colorScheme.onSurface.withValues(
                                alpha: AppDimens.opacityDisabled,
                              )
                            : effectiveForegroundColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: rotationAngle,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: isDisabled
                          ? colorScheme.onSurface.withValues(
                              alpha: AppDimens.opacityDisabled,
                            )
                          : effectiveForegroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild: Padding(
            padding: const EdgeInsets.only(
              left: AppDimens.paddingL,
              top: AppDimens.paddingS,
              right: AppDimens.paddingS,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

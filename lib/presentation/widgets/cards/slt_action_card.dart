// lib/presentation/widgets/cards/slt_action_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/theme/app_typography.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_dialog_button_bar.dart'; // To arrange buttons

/// A card that includes a main content area and a row of action buttons.
///
/// This widget is ideal for scenarios requiring user interaction, such as confirmations,
/// calls to action, or navigation.
class SltActionCard extends ConsumerWidget {
  final String? title;
  final String? subtitle;
  final Widget? content;
  final List<Widget> actions; // Expects SltButtonBase derivatives or similar
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? actionsPadding;
  final MainAxisAlignment actionsAlignment;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;

  const SltActionCard({
    super.key,
    this.title,
    this.subtitle,
    this.content,
    required this.actions,
    this.backgroundColor,
    this.contentPadding,
    this.actionsPadding,
    this.actionsAlignment = MainAxisAlignment.end,
    this.elevation,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine effective styles
    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainerLow;
    final effectiveElevation = elevation ?? AppDimens.elevationS;
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppDimens.radiusM);
    final effectiveContentPadding =
        contentPadding ?? const EdgeInsets.all(AppDimens.paddingL);
    final effectiveActionsPadding =
        actionsPadding ??
        const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingM,
          vertical: AppDimens.paddingS,
        );

    return Card(
      elevation: effectiveElevation,
      color: effectiveBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: effectiveContentPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null && title!.isNotEmpty)
                  Text(
                    title!,
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
                if (content != null)
                  Padding(
                    padding: EdgeInsets.only(
                      top: (title != null || subtitle != null)
                          ? AppDimens.paddingM
                          : 0,
                    ),
                    child: content!,
                  ),
              ],
            ),
          ),
          // Separator before actions if there's content above
          if (title != null || subtitle != null || content != null)
            Divider(
              height: 1,
              thickness: 0.5,
              color: colorScheme.outlineVariant.withOpacity(0.5),
            ),
          Padding(
            padding: effectiveActionsPadding,
            child: SltDialogButtonBar(
              // Using SltDialogButtonBar to arrange actions
              buttons: actions,
              alignment: actionsAlignment,
              spacing: AppDimens.paddingS,
            ),
          ),
        ],
      ),
    );
  }
}

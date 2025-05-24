import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

final _isExpandedProvider = StateProvider.family<bool, String>(
  (ref, id) => false,
);

class SltExpandableCard extends ConsumerWidget {
  final String cardId; // Unique ID for this expandable card instance
  final Widget header;
  final Widget collapsedContent; // Content visible when collapsed (optional)
  final Widget expandedContent; // Content visible when expanded
  final bool initiallyExpanded;
  final Color? backgroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Duration animationDuration;
  final Curve animationCurve;
  final IconData expandIcon;
  final IconData collapseIcon;

  const SltExpandableCard({
    super.key,
    required this.cardId,
    required this.header,
    this.collapsedContent = const SizedBox.shrink(),
    required this.expandedContent,
    this.initiallyExpanded = false,
    this.backgroundColor,
    this.elevation,
    this.padding,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeInOut,
    this.expandIcon = Icons.keyboard_arrow_down,
    this.collapseIcon = Icons.keyboard_arrow_up,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isExpanded = ref.watch(_isExpandedProvider(cardId));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(_isExpandedProvider(cardId).notifier).state !=
              initiallyExpanded &&
          !isExpanded) {
        ref.read(_isExpandedProvider(cardId).notifier).state =
            initiallyExpanded;
      }
    });

    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainerLow;
    final effectiveElevation = elevation ?? AppDimens.elevationS;
    final effectivePadding =
        padding ?? const EdgeInsets.all(AppDimens.paddingM);
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppDimens.radiusM);

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
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.only(
              topLeft: effectiveBorderRadius.resolve(TextDirection.ltr).topLeft,
              topRight: effectiveBorderRadius
                  .resolve(TextDirection.ltr)
                  .topRight,
              bottomLeft: isExpanded
                  ? Radius.zero
                  : effectiveBorderRadius.resolve(TextDirection.ltr).bottomLeft,
              bottomRight: isExpanded
                  ? Radius.zero
                  : effectiveBorderRadius
                        .resolve(TextDirection.ltr)
                        .bottomRight,
            ),
            onTap: () {
              ref.read(_isExpandedProvider(cardId).notifier).state =
                  !isExpanded;
            },
            child: Padding(
              padding: effectivePadding,
              child: Row(
                children: [
                  Expanded(child: header),
                  Padding(
                    padding: const EdgeInsets.only(left: AppDimens.paddingS),
                    child: Icon(
                      isExpanded ? collapseIcon : expandIcon,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Padding(
              padding: EdgeInsets.only(
                left: effectivePadding.resolve(TextDirection.ltr).left,
                right: effectivePadding.resolve(TextDirection.ltr).right,
                bottom: effectivePadding.resolve(TextDirection.ltr).bottom,
                top: AppDimens.paddingXS, // Small top padding if content exists
              ),
              child: collapsedContent,
            ),
            secondChild: Container(
              padding: effectivePadding,
              child: expandedContent,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: animationDuration,
            firstCurve: animationCurve,
            secondCurve: animationCurve,
            sizeCurve: animationCurve,
          ),
        ],
      ),
    );
  }
}

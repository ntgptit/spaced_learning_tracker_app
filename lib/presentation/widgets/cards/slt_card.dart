import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltCard extends ConsumerWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry?
  borderRadius; // Keep as BorderRadiusGeometry for Card shape
  final BorderSide? borderSide;
  final VoidCallback? onTap;
  final Clip clipBehavior;
  final bool useOutlinedVariantIfNoElevation;

  const SltCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.elevation,
    this.padding,
    this.margin,
    this.borderRadius,
    this.borderSide,
    this.onTap,
    this.clipBehavior = Clip.antiAlias,
    this.useOutlinedVariantIfNoElevation = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveElevation = elevation ?? AppDimens.elevationS;
    final isElevatedCard = effectiveElevation > AppDimens.elevationNone;

    final effectiveBackgroundColor =
        backgroundColor ??
        (isElevatedCard
            ? colorScheme.surface
            : colorScheme.surfaceContainerLow);

    final effectivePadding =
        padding ?? const EdgeInsets.all(AppDimens.paddingM);
    final effectiveMargin =
        margin ?? const EdgeInsets.symmetric(vertical: AppDimens.paddingS);
    final effectiveBorderRadiusGeometry =
        borderRadius ?? BorderRadius.circular(AppDimens.radiusM);

    final BorderRadius? inkWellBorderRadius;
    if (effectiveBorderRadiusGeometry is BorderRadius) {
      inkWellBorderRadius = effectiveBorderRadiusGeometry;
    } else {
      inkWellBorderRadius = effectiveBorderRadiusGeometry as BorderRadius?;
    }

    final BorderSide actualBorderSide;
    if (borderSide != null) {
      actualBorderSide = borderSide!;
    } else if (!isElevatedCard && useOutlinedVariantIfNoElevation) {
      actualBorderSide = BorderSide(
        color: colorScheme.outline,
        width: AppDimens.outlineButtonBorderWidth,
      );
    } else {
      actualBorderSide = BorderSide.none;
    }

    final Widget cardContent = Padding(padding: effectivePadding, child: child);

    final ShapeBorder cardShape = RoundedRectangleBorder(
      borderRadius: effectiveBorderRadiusGeometry,
      side: actualBorderSide,
    );

    if (onTap != null) {
      return Card(
        elevation: effectiveElevation,
        color: effectiveBackgroundColor,
        shape: cardShape,
        margin: effectiveMargin,
        clipBehavior: clipBehavior,
        child: InkWell(
          onTap: onTap,
          borderRadius: inkWellBorderRadius,
          child: cardContent,
        ),
      );
    }

    return Card(
      elevation: effectiveElevation,
      color: effectiveBackgroundColor,
      shape: cardShape,
      margin: effectiveMargin,
      clipBehavior: clipBehavior,
      child: cardContent,
    );
  }
}

// lib/presentation/widgets/cards/slt_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

/// A foundational card widget that provides standardized styling for elevation,
/// shape, and padding.
///
/// This widget adheres to Material 3 guidelines and uses the app's defined theme.
/// It can be used directly or as a base for more specialized card widgets.
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

    // For InkWell, we specifically need BorderRadius, not BorderRadiusGeometry.
    // If effectiveBorderRadiusGeometry is already a BorderRadius, use it.
    // Otherwise, InkWell might not clip the ripple correctly for complex geometries.
    // For simplicity in a base card, we'll try to cast or use a default if it's not BorderRadius.
    // A more robust solution might involve checking the type explicitly.
    final BorderRadius? inkWellBorderRadius;
    if (effectiveBorderRadiusGeometry is BorderRadius) {
      inkWellBorderRadius = effectiveBorderRadiusGeometry;
    } else {
      // Fallback: If it's a custom BorderRadiusGeometry that InkWell can't handle directly
      // for its borderRadius property, the ripple might not be perfectly clipped.
      // Setting it to null means the ripple might extend beyond complex corners.
      // Or, you could try to derive a simple BorderRadius (e.g., from all corners if uniform).
      // For now, let's assume typical usage involves BorderRadius.circular or similar.
      // A common practice is to use the same radius for the InkWell as the visual corners.
      // If effectiveBorderRadiusGeometry is BorderRadius.circular, this cast is safe.
      // If it's something more complex, InkWell's clipping might be imperfect.
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
      // Card shape can use BorderRadiusGeometry
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
          //borderRadius: effectiveBorderRadiusGeometry as BorderRadius?, // This was the problematic line
          // Corrected:
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

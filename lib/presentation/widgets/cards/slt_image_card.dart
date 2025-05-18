// lib/presentation/widgets/cards/slt_image_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/theme/app_typography.dart';

import '../media/slt_network_image.dart';

/// A card that prominently features an image, either as a background or a central element.
///
/// It can overlay text or other widgets on top of the image.
class SltImageCard extends ConsumerWidget {
  final String imageUrl;
  final BoxFit imageFit;
  final Widget? child; // Content to overlay on the image or display below
  final String? title;
  final String? subtitle;
  final VoidCallback? onTap;
  final double?
  aspectRatio; // If provided, the card will try to maintain this aspect ratio
  final Color?
  overlayColor; // Color to overlay on the image (e.g., for text contrast)
  final Color? backgroundColor; // Fallback if image fails or for padding area
  final double? elevation;
  final EdgeInsetsGeometry? padding; // Padding for the child content
  final BorderRadiusGeometry? borderRadius;

  const SltImageCard({
    super.key,
    required this.imageUrl,
    this.imageFit = BoxFit.cover,
    this.child,
    this.title,
    this.subtitle,
    this.onTap,
    this.aspectRatio,
    this.overlayColor,
    this.backgroundColor,
    this.elevation,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surfaceContainer;
    final effectiveElevation = elevation ?? AppDimens.elevationS;
    final effectivePadding =
        padding ?? const EdgeInsets.all(AppDimens.paddingM);
    final effectiveBorderRadiusGeometry =
        borderRadius ?? BorderRadius.circular(AppDimens.radiusM);

    BorderRadius? inkWellBorderRadius;
    if (effectiveBorderRadiusGeometry is BorderRadius) {
      inkWellBorderRadius = effectiveBorderRadiusGeometry;
    } else {
      inkWellBorderRadius = effectiveBorderRadiusGeometry as BorderRadius?;
    }

    Widget imageWidget = SltNetworkImage(
      // Correct usage of SltNetworkImage
      imageUrl: imageUrl,
      fit: imageFit,
      width: double.infinity,
      height: aspectRatio != null ? null : 200,
      placeholder: Container(
        color: colorScheme.surfaceContainerHighest,
        child: const Icon(Icons.image_outlined, size: AppDimens.iconXL),
      ),
      errorWidget: Container(
        color: colorScheme.errorContainer,
        child: Icon(
          Icons.broken_image_outlined,
          size: AppDimens.iconXL,
          color: colorScheme.onErrorContainer,
        ),
      ),
    );

    if (aspectRatio != null) {
      imageWidget = AspectRatio(aspectRatio: aspectRatio!, child: imageWidget);
    }

    Widget cardBody = Stack(
      children: [
        Positioned.fill(child: imageWidget),
        if (overlayColor != null)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: overlayColor,
                borderRadius:
                    effectiveBorderRadiusGeometry, // BoxDecoration can take BorderRadiusGeometry
              ),
            ),
          ),
        if (child != null)
          Positioned.fill(
            child: Padding(padding: effectivePadding, child: child),
          ),
        if (child == null && (title != null || subtitle != null))
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: effectivePadding,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  // This specifically needs BorderRadius
                  bottomLeft: (effectiveBorderRadiusGeometry is BorderRadius)
                      ? effectiveBorderRadiusGeometry.bottomLeft
                      : Radius.zero,
                  bottomRight: (effectiveBorderRadiusGeometry is BorderRadius)
                      ? effectiveBorderRadiusGeometry.bottomRight
                      : Radius.zero,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(
                      title!,
                      style: AppTypography.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ),
      ],
    );

    final cardShape = RoundedRectangleBorder(
      borderRadius: effectiveBorderRadiusGeometry,
    );

    if (onTap != null) {
      return Card(
        elevation: effectiveElevation,
        color: effectiveBackgroundColor,
        shape: cardShape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: inkWellBorderRadius, // Corrected
          child: cardBody,
        ),
      );
    }

    return Card(
      elevation: effectiveElevation,
      color: effectiveBackgroundColor,
      shape: cardShape,
      clipBehavior: Clip.antiAlias,
      child: cardBody,
    );
  }
}

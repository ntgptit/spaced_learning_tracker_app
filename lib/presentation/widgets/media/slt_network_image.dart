import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

import '../../../core/theme/app_colors.dart';

class SltNetworkImage extends ConsumerWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadiusGeometry? borderRadius;
  final BoxShape shape; // To handle circular images or other shapes
  final Map<String, String>? httpHeaders;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;

  const SltNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.httpHeaders,
    this.fadeInDuration = const Duration(
      milliseconds: AppDimens.durationMedium1,
    ), // from AppDimens
    this.fadeOutDuration = const Duration(
      milliseconds: AppDimens.durationShort2,
    ), // from AppDimens
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Widget defaultPlaceholder = Container(
      width: width,
      height: height,
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
      child: const Center(
        child: Icon(
          Icons.image_search_rounded,
          size: AppDimens.iconL,
          color: AppColors.dividerDark,
        ),
      ),
    );

    final Widget defaultErrorWidget = Container(
      width: width,
      height: height,
      color: colorScheme.errorContainer.withValues(alpha: 0.3),
      child: Center(
        child: Icon(
          Icons.broken_image_outlined,
          size: AppDimens.iconL,
          color: colorScheme.onErrorContainer,
        ),
      ),
    );

    final Widget image = CachedNetworkImage(
      imageUrl: imageUrl,
      httpHeaders: httpHeaders,
      width: width,
      height: height,
      fit: fit,
      fadeInDuration: fadeInDuration,
      fadeOutDuration: fadeOutDuration,
      placeholder: (context, url) => placeholder ?? defaultPlaceholder,
      errorWidget: (context, url, error) => errorWidget ?? defaultErrorWidget,
      imageBuilder: (context, imageProvider) {
        if (shape == BoxShape.circle || borderRadius != null) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: shape,
              borderRadius: (shape == BoxShape.rectangle) ? borderRadius : null,
              image: DecorationImage(image: imageProvider, fit: fit),
            ),
          );
        }
        return Image(
          image: imageProvider,
          fit: fit,
          width: width,
          height: height,
        );
      },
    );

    if (borderRadius != null && shape == BoxShape.rectangle) {
      return ClipRRect(
        borderRadius: borderRadius!, // borderRadius is BorderRadiusGeometry
        child: image,
      );
    }

    return image;
  }
}

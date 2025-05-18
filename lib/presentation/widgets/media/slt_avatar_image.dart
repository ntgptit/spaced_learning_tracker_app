// lib/presentation/widgets/media/slt_avatar_image.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltAvatarImage extends ConsumerWidget {
  final String? imageUrl;
  final double radius;
  final IconData placeholderIcon;
  final Color? backgroundColor; // Background for placeholder or if image fails
  final Color? iconColor;
  final Color? borderColor;
  final double borderWidth;
  final BoxFit fit;
  final Map<String, String>? httpHeaders;
  final Widget? errorWidget; // Custom widget to display on error

  const SltAvatarImage({
    super.key,
    this.imageUrl,
    this.radius =
        AppDimens.avatarSizeM /
        2, // Default to half of avatarSizeM for CircleAvatar radius
    this.placeholderIcon = Icons.person_outline_rounded,
    this.backgroundColor,
    this.iconColor,
    this.borderColor,
    this.borderWidth = 0.0, // No border by default
    this.fit = BoxFit.cover,
    this.httpHeaders,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.secondaryContainer;
    final effectiveIconColor = iconColor ?? colorScheme.onSecondaryContainer;
    final effectiveBorderColor = borderColor ?? colorScheme.outline;

    Widget avatarContent;

    if (imageUrl != null && imageUrl!.isNotEmpty) {
      avatarContent = CachedNetworkImage(
        imageUrl: imageUrl!,
        httpHeaders: httpHeaders,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: fit),
          ),
        ),
        placeholder: (context, url) => CircleAvatar(
          radius: radius,
          backgroundColor: effectiveBackgroundColor,
          child: SizedBox(
            width: radius * 0.8, // Adjust size of progress indicator
            height: radius * 0.8,
            child: CircularProgressIndicator(
              strokeWidth: AppDimens.dividerThickness * 1.5,
              color: effectiveIconColor,
            ),
          ),
        ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            CircleAvatar(
              radius: radius,
              backgroundColor: effectiveBackgroundColor,
              child: Icon(
                placeholderIcon,
                size: radius, // Icon size relative to avatar radius
                color: effectiveIconColor,
              ),
            ),
      );
    } else {
      avatarContent = CircleAvatar(
        radius: radius,
        backgroundColor: effectiveBackgroundColor,
        child: Icon(
          placeholderIcon,
          size: radius, // Icon size relative to avatar radius
          color: effectiveIconColor,
        ),
      );
    }

    // Apply border if borderWidth is greater than 0
    if (borderWidth > 0) {
      return Container(
        padding: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          color: effectiveBorderColor,
          // Border color acts as a background for the padding
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.transparent,
          // Inner avatar transparent if border acts as background
          child: ClipOval(
            child: avatarContent,
          ), // Clip the content within the bordered circle
        ),
      );
    }

    // Return avatarContent directly if no border
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: avatarContent,
    );
  }
}

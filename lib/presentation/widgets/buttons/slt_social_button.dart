
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_button_base.dart';

enum SocialButtonType { google, facebook, apple, twitter, github, custom }

class SltSocialButton extends ConsumerWidget {
  final SocialButtonType type;
  final String text;
  final VoidCallback? onPressed;
  final IconData? customIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? loadingId;
  final bool isFullWidth;

  const SltSocialButton({
    super.key,
    required this.type,
    required this.text,
    this.onPressed,
    this.customIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.loadingId,
    this.isFullWidth = false,
  }) : assert(
         type != SocialButtonType.custom || customIcon != null,
         'customIcon must be provided for custom type',
       );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SltButtonBase(
      text: text,
      onPressed: onPressed,
      prefixIcon: _getIcon(),
      loadingId: loadingId,
      isFullWidth: isFullWidth,
      variant: SltButtonVariant.outlined,
      backgroundColor: backgroundColor ?? Colors.transparent,
      foregroundColor: foregroundColor ?? colorScheme.onSurface,
    );
  }

  IconData? _getIcon() {
    if (type == SocialButtonType.custom) {
      return customIcon;
    }

    switch (type) {
      case SocialButtonType.google:
        return Icons.g_mobiledata;
      case SocialButtonType.facebook:
        return Icons.facebook;
      case SocialButtonType.apple:
        return Icons.apple;
      case SocialButtonType.twitter:
        return Icons.tag;
      case SocialButtonType.github:
        return Icons.code;
      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';
import '../common/slt_app_bar.dart';

class SltSuccessStateWidget extends ConsumerWidget {
  final String title;
  final String? message;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool showIcon;
  final bool compactMode;
  final Duration? autoHideDuration;
  final IconData icon;
  final Color? accentColor;
  final bool showAppBar;
  final String? appBarTitle;

  const SltSuccessStateWidget({
    super.key,
    required this.title,
    this.message,
    required this.primaryButtonText,
    required this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.showIcon = true,
    this.compactMode = false,
    this.autoHideDuration,
    this.icon = Icons.check_circle_outline_rounded,
    this.accentColor,
    this.showAppBar = false,
    this.appBarTitle,
  });

  factory SltSuccessStateWidget.actionComplete({
    Key? key,
    required String actionName,
    required VoidCallback onContinue,
    String? continueButtonText = 'Continue',
    String? successMessage,
    Duration? autoHideDuration,
    bool showAppBar = false,
    String? appBarTitle,
  }) {
    return SltSuccessStateWidget(
      key: key,
      title: '$actionName Successful!',
      message:
          successMessage ??
          'The $actionName operation was completed successfully.',
      primaryButtonText: continueButtonText!,
      onPrimaryButtonPressed: onContinue,
      autoHideDuration: autoHideDuration,
      icon: Icons.task_alt_rounded,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? '$actionName Successful!',
    );
  }

  factory SltSuccessStateWidget.saved({
    Key? key,
    required VoidCallback onContinue,
    String title = 'Saved Successfully',
    String? message,
    String continueButtonText = 'OK',
    Color? accentColor,
    bool showAppBar = false,
    String? appBarTitle,
  }) {
    return SltSuccessStateWidget(
      key: key,
      title: title,
      message: message ?? 'Your changes have been saved.',
      primaryButtonText: continueButtonText,
      onPrimaryButtonPressed: onContinue,
      icon: Icons.save_alt_rounded,
      accentColor: accentColor,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
    );
  }

  factory SltSuccessStateWidget.notification({
    Key? key,
    required String title,
    String? message,
    required VoidCallback onDismiss,
    Duration? autoDismissDuration,
    IconData icon = Icons.notifications_active_outlined,
  }) {
    return SltSuccessStateWidget(
      key: key,
      title: title,
      message: message,
      primaryButtonText: 'Dismiss',
      onPrimaryButtonPressed: onDismiss,
      compactMode: true,
      autoHideDuration: autoDismissDuration,
      icon: icon,
      showIcon: true,
    );
  }

  Color _getContrastColor(Color backgroundColor, ColorScheme colorScheme) {
    return backgroundColor.computeLuminance() > 0.5
        ? colorScheme.onSurface
        : colorScheme.surface;
  }

  Widget _buildFullSuccess(
    BuildContext context,
    ThemeData theme,
    TextTheme textTheme,
    ColorScheme colorScheme,
    Color effectiveSuccessColor,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Container(
            width: AppDimens.iconXXL,
            height: AppDimens.iconXXL,
            decoration: BoxDecoration(
              color: effectiveSuccessColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppDimens.iconXL,
              color: effectiveSuccessColor,
            ),
          ),
          const SizedBox(height: AppDimens.spaceXL),
        ],
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: effectiveSuccessColor,
          ),
          textAlign: TextAlign.center,
        ),
        if (message != null && message!.isNotEmpty) ...[
          const SizedBox(height: AppDimens.spaceM),
          Text(
            message!,
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: AppDimens.spaceXXL),
        SltPrimaryButton(
          text: primaryButtonText,
          onPressed: onPrimaryButtonPressed,
          backgroundColor: effectiveSuccessColor,
          foregroundColor: _getContrastColor(
            effectiveSuccessColor,
            colorScheme,
          ),
        ),
        if (secondaryButtonText != null &&
            onSecondaryButtonPressed != null) ...[
          const SizedBox(height: AppDimens.spaceM),
          SltTextButton(
            text: secondaryButtonText!,
            onPressed: onSecondaryButtonPressed,
            foregroundColor: effectiveSuccessColor,
          ),
        ],
      ],
    );
  }

  Widget _buildCompactSuccess(
    BuildContext context,
    ThemeData theme,
    TextTheme textTheme,
    ColorScheme colorScheme,
    Color effectiveSuccessColor,
  ) {
    return Card(
      color: effectiveSuccessColor.withValues(alpha: 0.08),
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        side: BorderSide(color: effectiveSuccessColor.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingM),
        child: Row(
          children: [
            if (showIcon) ...[
              Icon(icon, color: effectiveSuccessColor, size: AppDimens.iconM),
              const SizedBox(width: AppDimens.spaceM),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: effectiveSuccessColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (message != null && message!.isNotEmpty) ...[
                    const SizedBox(height: AppDimens.spaceXS),
                    Text(
                      message!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (primaryButtonText.isNotEmpty) ...[
              const SizedBox(width: AppDimens.spaceS),
              SltTextButton(
                text: primaryButtonText,
                onPressed: onPrimaryButtonPressed,
                foregroundColor: effectiveSuccessColor,
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final effectiveSuccessColor = accentColor ?? colorScheme.primary;

    // Handle auto-dismiss if needed
    if (autoHideDuration != null && context.mounted) {
      Future.delayed(autoHideDuration!, () {
        if (context.mounted) {
          onPrimaryButtonPressed();
        }
      });
    }

    Widget content;
    if (compactMode) {
      content = _buildCompactSuccess(
        context,
        theme,
        textTheme,
        colorScheme,
        effectiveSuccessColor,
      );
    } else {
      content = _buildFullSuccess(
        context,
        theme,
        textTheme,
        colorScheme,
        effectiveSuccessColor,
      );
    }

    if (showAppBar) {
      return Scaffold(
        appBar: SltAppBar(
          title: appBarTitle ?? title,
          showBackButton: true,
          onBackPressed: () => context.pop(),
          centerTitle: false,
        ),
        body: Center(
          child: Padding(
            padding: compactMode
                ? EdgeInsets.zero
                : const EdgeInsets.all(AppDimens.paddingL),
            child: content,
          ),
        ),
      );
    }

    return Material(
      color: compactMode ? Colors.transparent : theme.scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: compactMode
              ? EdgeInsets.zero
              : const EdgeInsets.all(AppDimens.paddingL),
          child: content,
        ),
      ),
    );
  }
}

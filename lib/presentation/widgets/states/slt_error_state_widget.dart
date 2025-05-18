import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';
import '../common/slt_app_bar.dart';

class SltErrorStateWidget extends ConsumerWidget {
  final String title;
  final String? message;
  final IconData icon;
  final VoidCallback? onRetry;
  final String? retryText;
  final bool compact;
  final Color? accentColor;
  final Widget? customAction;
  final bool showAppBar;
  final String? appBarTitle;
  final VoidCallback? onNavigateBack;

  const SltErrorStateWidget({
    super.key,
    required this.title,
    this.message,
    this.icon = Icons.error_outline_rounded,
    this.onRetry,
    this.retryText,
    this.compact = false,
    this.accentColor,
    this.customAction,
    this.showAppBar = false,
    this.appBarTitle,
    this.onNavigateBack,
  });

  factory SltErrorStateWidget.network({
    Key? key,
    VoidCallback? onRetry,
    bool compact = false,
    String? message,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltErrorStateWidget(
      key: key,
      title: 'Network Error',
      message:
          message ??
          'Failed to connect. Please check your connection and try again.',
      icon: Icons.wifi_off_rounded,
      onRetry: onRetry,
      retryText: 'Try Again',
      compact: compact,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? 'Network Error',
      onNavigateBack: onNavigateBack,
    );
  }

  factory SltErrorStateWidget.serverError({
    Key? key,
    String? details,
    VoidCallback? onRetry,
    bool compact = false,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltErrorStateWidget(
      key: key,
      title: 'Server Error',
      message:
          details ??
          'Something went wrong on our end. We\'re working to fix it.',
      icon: Icons.cloud_off_rounded,
      onRetry: onRetry,
      retryText: 'Try Again',
      compact: compact,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? 'Server Error',
      onNavigateBack: onNavigateBack,
    );
  }

  factory SltErrorStateWidget.custom({
    Key? key,
    required String title,
    String? message,
    IconData icon = Icons.error_outline_rounded,
    VoidCallback? onRetry,
    String? retryText = 'Try Again',
    bool compact = false,
    Color? accentColor,
    Widget? customAction,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltErrorStateWidget(
      key: key,
      title: title,
      message: message,
      icon: icon,
      onRetry: onRetry,
      retryText: retryText,
      compact: compact,
      accentColor: accentColor,
      customAction: customAction,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onNavigateBack,
    );
  }

  Widget _buildFullError(
    BuildContext context,
    ThemeData theme,
    Color effectiveErrorColor,
  ) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimens.iconXXL,
          height: AppDimens.iconXXL,
          decoration: BoxDecoration(
            color: effectiveErrorColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: AppDimens.iconXL, color: effectiveErrorColor),
        ),
        const SizedBox(height: AppDimens.spaceXL),
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
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
        if (customAction == null && onRetry != null) ...[
          const SizedBox(height: AppDimens.spaceXL),
          SltPrimaryButton(
            text: retryText ?? 'Try Again',
            onPressed: onRetry!,
            prefixIcon: Icons.refresh_rounded,
            backgroundColor: effectiveErrorColor,
            isFullWidth: false,
          ),
        ],
        if (customAction != null) ...[
          const SizedBox(height: AppDimens.spaceM),
          customAction!,
        ],
        if (customAction == null &&
            onRetry == null &&
            onNavigateBack != null &&
            !showAppBar) ...[
          const SizedBox(height: AppDimens.spaceM),
          SltTextButton(
            text: 'Go Back',
            onPressed: onNavigateBack!,
            foregroundColor: colorScheme.primary,
          ),
        ],
      ],
    );
  }

  Widget _buildCompactError(
    BuildContext context,
    ThemeData theme,
    Color effectiveErrorColor,
  ) {
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      color: effectiveErrorColor.withOpacity(0.08),
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        side: BorderSide(color: effectiveErrorColor.withOpacity(0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingM),
        child: Row(
          children: [
            Icon(icon, color: effectiveErrorColor, size: AppDimens.iconM),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: effectiveErrorColor,
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (customAction == null && onRetry != null) ...[
              const SizedBox(width: AppDimens.spaceS),
              SltTextButton(
                text: retryText ?? 'Retry',
                onPressed: onRetry!,
                foregroundColor: effectiveErrorColor,
              ),
            ],
            if (customAction != null) ...[
              const SizedBox(width: AppDimens.spaceS),
              customAction!,
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final effectiveErrorColor = accentColor ?? theme.colorScheme.error;

    Widget content;
    if (compact) {
      content = _buildCompactError(context, theme, effectiveErrorColor);
    } else {
      content = _buildFullError(context, theme, effectiveErrorColor);
    }

    if (showAppBar) {
      return Scaffold(
        appBar: SltAppBar(
          title: appBarTitle ?? title,
          showBackButton: true,
          onBackPressed: () {
            if (onNavigateBack != null) {
              onNavigateBack!();
              return;
            }

            context.pop();
          },
          centerTitle: false,
        ),
        body: Center(
          child: Padding(
            padding: compact
                ? EdgeInsets.zero
                : const EdgeInsets.all(AppDimens.paddingL),
            child: content,
          ),
        ),
      );
    }

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: compact
              ? EdgeInsets.zero
              : const EdgeInsets.all(AppDimens.paddingL),
          child: content,
        ),
      ),
    );
  }
}

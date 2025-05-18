import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';
import '../common/slt_app_bar.dart';

class SltOfflineStateWidget extends ConsumerWidget {
  final String title;
  final String? message;
  final String? retryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onRetry;
  final VoidCallback? onSecondaryAction;
  final bool compact;
  final bool showOfflineImage;
  final IconData icon;
  final bool showAppBar;
  final String? appBarTitle;
  final VoidCallback? onNavigateBack;

  const SltOfflineStateWidget({
    super.key,
    this.title = 'No Internet Connection',
    this.message,
    this.retryButtonText = 'Try Again',
    this.secondaryButtonText,
    this.onRetry,
    this.onSecondaryAction,
    this.compact = false,
    this.showOfflineImage = true,
    this.icon = Icons.wifi_off_rounded,
    this.showAppBar = false,
    this.appBarTitle,
    this.onNavigateBack,
  });

  factory SltOfflineStateWidget.generic({
    Key? key,
    String title = 'You Are Offline',
    String? message = 'Please check your internet connection and try again.',
    VoidCallback? onRetry,
    String? retryText = 'Retry',
    VoidCallback? onOpenSettings,
    String? openSettingsText = 'Network Settings',
    bool compact = false,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltOfflineStateWidget(
      key: key,
      title: title,
      message: message,
      onRetry: onRetry,
      retryButtonText: retryText,
      onSecondaryAction: onOpenSettings,
      secondaryButtonText: onOpenSettings != null ? openSettingsText : null,
      compact: compact,
      icon: Icons.signal_wifi_off_outlined,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onNavigateBack,
    );
  }

  factory SltOfflineStateWidget.contentUnavailable({
    Key? key,
    String title = 'Content Unavailable Offline',
    String? message =
        'This content requires an internet connection to load. Please connect and try again.',
    VoidCallback? onRetry,
    String? retryText = 'Refresh',
    bool compact = false,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltOfflineStateWidget(
      key: key,
      title: title,
      message: message,
      onRetry: onRetry,
      retryButtonText: retryText,
      compact: compact,
      icon: Icons.cloud_off_outlined,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onNavigateBack,
    );
  }

  Widget _buildFullOffline(
    BuildContext context,
    ThemeData theme,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showOfflineImage) ...[
          Container(
            width: AppDimens.iconXXL,
            height: AppDimens.iconXXL,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppDimens.iconXL,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimens.spaceXL),
        ],
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
        if (onRetry != null) ...[
          const SizedBox(height: AppDimens.spaceXL),
          SltPrimaryButton(
            text: retryButtonText ?? 'Try Again',
            onPressed: onRetry!,
            prefixIcon: Icons.refresh_rounded,
          ),
        ],
        if (secondaryButtonText != null && onSecondaryAction != null) ...[
          SizedBox(
            height: onRetry != null ? AppDimens.spaceM : AppDimens.spaceXL,
          ),
          SltTextButton(
            text: secondaryButtonText!,
            onPressed: onSecondaryAction!,
            foregroundColor: colorScheme.primary,
          ),
        ],
        if (onRetry == null &&
            onSecondaryAction == null &&
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

  Widget _buildCompactOffline(
    BuildContext context,
    ThemeData theme,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Card(
      color: colorScheme.surfaceVariant.withOpacity(0.5),
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingM),
        child: Row(
          children: [
            Icon(
              icon,
              color: colorScheme.onSurfaceVariant,
              size: AppDimens.iconM,
            ),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
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
            if (onRetry != null) ...[
              const SizedBox(width: AppDimens.spaceS),
              SltTextButton(
                text: retryButtonText ?? 'Retry',
                onPressed: onRetry!,
                foregroundColor: colorScheme.primary,
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

    Widget offlineContent;
    if (compact) {
      offlineContent = _buildCompactOffline(
        context,
        theme,
        textTheme,
        colorScheme,
      );
    } else {
      offlineContent = _buildFullOffline(
        context,
        theme,
        textTheme,
        colorScheme,
      );
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
            child: offlineContent,
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
          child: offlineContent,
        ),
      ),
    );
  }
}

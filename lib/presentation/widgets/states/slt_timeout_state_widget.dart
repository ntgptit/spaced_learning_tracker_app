import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';
import '../common/slt_app_bar.dart';

class SltTimeoutStateWidget extends ConsumerWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;
  final String retryButtonText;
  final VoidCallback? onCancel;
  final String? cancelButtonText;
  final bool isServiceTimeout;
  final Duration? timeoutDuration;
  final bool compact;
  final IconData icon;
  final bool showAppBar;
  final String? appBarTitle;
  final VoidCallback? onNavigateBack;

  const SltTimeoutStateWidget({
    super.key,
    this.title = 'Request Timeout',
    this.message =
        'The operation is taking longer than expected. Please try again.',
    required this.onRetry,
    this.retryButtonText = 'Try Again',
    this.onCancel,
    this.cancelButtonText,
    this.isServiceTimeout = false,
    this.timeoutDuration,
    this.compact = false,
    this.icon = Icons.timer_off_outlined,
    this.showAppBar = false,
    this.appBarTitle,
    this.onNavigateBack,
  });

  factory SltTimeoutStateWidget.networkRequest({
    Key? key,
    required VoidCallback onRetry,
    VoidCallback? onCancel,
    String? message,
    Duration? timeout,
    bool compact = false,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltTimeoutStateWidget(
      key: key,
      title: 'Network Timeout',
      message:
          message ??
          'The connection to our servers timed out. Please check your internet connection and try again.',
      onRetry: onRetry,
      retryButtonText: 'Retry',
      onCancel: onCancel,
      cancelButtonText: onCancel != null ? 'Cancel' : null,
      isServiceTimeout: false,
      timeoutDuration: timeout,
      compact: compact,
      icon: Icons.signal_wifi_statusbar_connected_no_internet_4_outlined,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? 'Network Timeout',
      onNavigateBack: onNavigateBack,
    );
  }

  factory SltTimeoutStateWidget.slowProcess({
    Key? key,
    required VoidCallback onRetry,
    VoidCallback? onCancel,
    String? processName,
    String? message,
    bool compact = false,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    final effectiveMessage =
        message ??
        (processName != null
            ? 'The $processName process is taking longer than expected. You can wait or try again.'
            : 'This process is taking longer than expected. You can wait or try again.');

    return SltTimeoutStateWidget(
      key: key,
      title: processName != null ? '$processName Timeout' : 'Process Timeout',
      message: effectiveMessage,
      onRetry: onRetry,
      retryButtonText: 'Retry Process',
      onCancel: onCancel,
      cancelButtonText: onCancel != null ? 'Cancel Process' : null,
      isServiceTimeout: true,
      compact: compact,
      icon: Icons.hourglass_empty_rounded,
      showAppBar: showAppBar,
      appBarTitle:
          appBarTitle ??
          (processName != null ? '$processName Timeout' : 'Process Timeout'),
      onNavigateBack: onNavigateBack,
    );
  }

  Widget _buildFullTimeout(
    BuildContext context,
    ThemeData theme,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    final effectiveDisplayColor = isServiceTimeout
        ? colorScheme.tertiary
        : colorScheme.error;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: AppDimens.iconXXL,
          height: AppDimens.iconXXL,
          decoration: BoxDecoration(
            color: effectiveDisplayColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: AppDimens.iconXL,
            color: effectiveDisplayColor,
          ),
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
        const SizedBox(height: AppDimens.spaceM),
        Text(
          message,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        if (timeoutDuration != null) ...[
          const SizedBox(height: AppDimens.spaceS),
          Text(
            'Timeout occurred after ${timeoutDuration!.inSeconds} seconds.',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: AppDimens.spaceXL),
        SltPrimaryButton(
          text: retryButtonText,
          onPressed: onRetry,
          prefixIcon: Icons.refresh_rounded,
          backgroundColor: effectiveDisplayColor,
          foregroundColor: effectiveDisplayColor.computeLuminance() > 0.5
              ? colorScheme.onSurface
              : colorScheme.surface,
        ),
        if (cancelButtonText != null && onCancel != null) ...[
          const SizedBox(height: AppDimens.spaceM),
          SltTextButton(
            text: cancelButtonText!,
            onPressed: onCancel,
            foregroundColor: colorScheme.onSurfaceVariant,
          ),
        ],
        if (onCancel == null && onNavigateBack != null && !showAppBar) ...[
          const SizedBox(height: AppDimens.spaceM),
          SltTextButton(
            text: 'Go Back',
            onPressed: onNavigateBack,
            foregroundColor: colorScheme.primary,
          ),
        ],
      ],
    );
  }

  Widget _buildCompactTimeout(
    BuildContext context,
    ThemeData theme,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    final effectiveDisplayColor = isServiceTimeout
        ? colorScheme.tertiary
        : colorScheme.error;

    return Card(
      color: effectiveDisplayColor.withValues(alpha: 0.08),
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingS,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        side: BorderSide(color: effectiveDisplayColor.withValues(alpha: 0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingM),
        child: Row(
          children: [
            Icon(icon, color: effectiveDisplayColor, size: AppDimens.iconM),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: textTheme.titleSmall?.copyWith(
                      color: effectiveDisplayColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (message.isNotEmpty) ...[
                    const SizedBox(height: AppDimens.spaceXS),
                    Text(
                      message,
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
            const SizedBox(width: AppDimens.spaceS),
            SltTextButton(
              text: retryButtonText,
              onPressed: onRetry,
              foregroundColor: effectiveDisplayColor,
            ),
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

    Widget timeoutContent;
    if (compact) {
      timeoutContent = _buildCompactTimeout(
        context,
        theme,
        textTheme,
        colorScheme,
      );
    } else {
      timeoutContent = _buildFullTimeout(
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
            if (onCancel != null) {
              onCancel!();
              return;
            }

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
            child: timeoutContent,
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
          child: timeoutContent,
        ),
      ),
    );
  }
}

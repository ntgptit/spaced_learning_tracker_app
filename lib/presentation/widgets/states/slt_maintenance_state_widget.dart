import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_outlined_button.dart';
import '../buttons/slt_text_button.dart';
import '../common/slt_app_bar.dart';

class SltMaintenanceStateWidget extends ConsumerWidget {
  final String title;
  final String message;
  final String? estimatedTimeMessageText;
  final VoidCallback? onRetryPressed;
  final String? retryButtonText;
  final bool showImage;
  final Widget? customImage;
  final bool showEstimatedTime;
  final DateTime? estimatedCompletionTime;
  final IconData icon;
  final bool showAppBar;
  final String? appBarTitle;
  final VoidCallback? onNavigateBack;

  const SltMaintenanceStateWidget({
    super.key,
    this.title = 'Under Maintenance',
    this.message =
    'We\'re currently making some improvements. Please check back shortly.',
    this.estimatedTimeMessageText,
    this.onRetryPressed,
    this.retryButtonText = 'Check Again',
    this.showImage = true,
    this.customImage,
    this.showEstimatedTime = true,
    this.estimatedCompletionTime,
    this.icon = Icons.build_rounded,
    this.showAppBar = false,
    this.appBarTitle,
    this.onNavigateBack,
  });

  factory SltMaintenanceStateWidget.generic({
    Key? key,
    String title = 'System Maintenance',
    String message =
    'Our services are temporarily unavailable as we perform scheduled maintenance. We apologize for any inconvenience.',
    VoidCallback? onRetry,
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltMaintenanceStateWidget(
      key: key,
      title: title,
      message: message,
      onRetryPressed: onRetry,
      icon: Icons.settings_applications_outlined,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onNavigateBack,
    );
  }

  factory SltMaintenanceStateWidget.withReason({
    Key? key,
    required String reason,
    String title = 'System Maintenance',
    DateTime? estimatedEndTime,
    VoidCallback? onRetry,
    String retryText = 'Try Again',
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
  }) {
    return SltMaintenanceStateWidget(
      key: key,
      title: title,
      message:
      'We\'re temporarily down for maintenance: $reason. We expect to be back soon.',
      estimatedCompletionTime: estimatedEndTime,
      onRetryPressed: onRetry,
      retryButtonText: retryText,
      showEstimatedTime: estimatedEndTime != null,
      icon: Icons.miscellaneous_services_outlined,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onNavigateBack,
    );
  }

  factory SltMaintenanceStateWidget.scheduled({
    Key? key,
    required DateTime startTime,
    required DateTime endTime,
    String? details,
    String title = 'Scheduled Maintenance',
    bool showAppBar = false,
    String? appBarTitle,
    VoidCallback? onNavigateBack,
    VoidCallback? onRetryIfActive,
  }) {
    final now = DateTime.now();
    final bool isActive = now.isAfter(startTime) && now.isBefore(endTime);
    final String effectiveMessage;

    final DateFormat timeFormatter = DateFormat.jm(); // Example: 5:08 PM
    final DateFormat dateFormatter =
    DateFormat.yMMMd(); // Example: May 17, 2025

    if (isActive) {
      effectiveMessage =
      'Scheduled maintenance is currently in progress. We appreciate your patience.';
    } else if (now.isBefore(startTime)) {
      effectiveMessage =
      'We will be undergoing scheduled maintenance starting at ${timeFormatter
          .format(startTime)} on ${dateFormatter.format(startTime)}.';
    } else {
      effectiveMessage = 'Scheduled maintenance has been completed.';
    }

    return SltMaintenanceStateWidget(
      key: key,
      title: title,
      message: details != null
          ? '$effectiveMessage\n\nDetails: $details'
          : effectiveMessage,
      estimatedCompletionTime: endTime,
      icon: isActive
          ? Icons.build_circle_outlined
          : Icons.event_available_outlined,
      showEstimatedTime: isActive || now.isBefore(endTime),
      onRetryPressed: isActive ? onRetryIfActive : null,
      retryButtonText: isActive ? 'Check Status' : null,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onNavigateBack,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    String displayTimeMessage = estimatedTimeMessageText ?? '';
    if (estimatedTimeMessageText == null &&
        estimatedCompletionTime != null &&
        showEstimatedTime) {
      final now = DateTime.now();
      final difference = estimatedCompletionTime!.difference(now);

      if (difference.isNegative) {
        displayTimeMessage = 'Maintenance should be complete. Try refreshing.';
      } else if (difference.inDays > 0) {
        final hours = difference.inHours % 24;
        displayTimeMessage =
        'Estimated completion: In ${difference.inDays} day(s)${hours > 0
            ? ' and $hours hour(s)'
            : ''}.';
      } else if (difference.inHours > 0) {
        final minutes = difference.inMinutes % 60;
        displayTimeMessage =
        'Estimated time remaining: ~${difference.inHours} hour(s)${minutes > 0
            ? ' and $minutes minute(s)'
            : ''}.';
      } else if (difference.inMinutes > 0) {
        displayTimeMessage =
        'Estimated time remaining: ~${difference.inMinutes} minute(s).';
      } else {
        // This case handles remaining time less than a minute or very close to completion
        displayTimeMessage = 'Maintenance should be complete very soon.';
      }
    }

    // The main content of the maintenance screen
    final Widget maintenanceContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showImage) ...[
          customImage ??
              Container(
                width: AppDimens.iconXXL,
                height: AppDimens.iconXXL,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer.withValues(alpha: 0.7),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: AppDimens.iconXL,
                  color: colorScheme.onSecondaryContainer,
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
        const SizedBox(height: AppDimens.spaceM),
        Text(
          message,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        if (displayTimeMessage.isNotEmpty) ...[
          const SizedBox(height: AppDimens.spaceL),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.paddingL,
              vertical: AppDimens.paddingM,
            ),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(AppDimens.radiusM),
            ),
            child: Text(
              displayTimeMessage,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onTertiaryContainer,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
        if (onRetryPressed != null && retryButtonText != null) ...[
          const SizedBox(height: AppDimens.spaceXL),
          SltOutlinedButton(
            text: retryButtonText!,
            onPressed: onRetryPressed,
            prefixIcon: Icons.refresh_rounded,
          ),
        ],
        if (onRetryPressed == null &&
            onNavigateBack != null &&
            !showAppBar) ...[
          const SizedBox(height: AppDimens.spaceM),
          SltTextButton(
            text: 'Go Back',
            onPressed: onNavigateBack,
            foregroundColor: colorScheme.primary,
          ),
        ],
      ],
    );

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
            padding: const EdgeInsets.all(AppDimens.paddingXL),
            child: maintenanceContent,
          ),
        ),
      );
    }

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingXL),
          child: maintenanceContent,
        ),
      ),
    );
  }
}

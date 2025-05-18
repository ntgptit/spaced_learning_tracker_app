// lib/presentation/widgets/cards/slt_notification_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/theme/app_typography.dart';
import 'package:spaced_learning_app/core/utils/date_utils.dart' as SltDateUtils;

import '../../../core/theme/app_theme.dart'; // Alias to avoid conflict with Flutter's DateUtils

enum SltNotificationType { info, success, warning, error, custom }

/// A card designed to display notifications with various types and actions.
class SltNotificationCard extends ConsumerWidget {
  final String title;
  final String? message;
  final DateTime? timestamp;
  final IconData? icon;
  final SltNotificationType type;
  final bool isRead;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss; // Optional dismiss action
  final Color? customColor; // For SltNotificationType.custom
  final Widget? trailingAction; // e.g., an IconButton

  const SltNotificationCard({
    super.key,
    required this.title,
    this.message,
    this.timestamp,
    this.icon,
    this.type = SltNotificationType.info,
    this.isRead = false,
    this.onTap,
    this.onDismiss,
    this.customColor,
    this.trailingAction,
  });

  Color _getTypeColor(
    BuildContext context,
    SltNotificationType type,
    ColorScheme colorScheme,
  ) {
    if (type == SltNotificationType.custom && customColor != null) {
      return customColor!;
    }
    // Accessing semantic colors from theme extension
    final semanticColors = Theme.of(
      context,
    ).extension<SemanticColorExtension>();

    switch (type) {
      case SltNotificationType.success:
        return semanticColors?.successColor ??
            colorScheme.tertiary; // M3 Tertiary or custom success
      case SltNotificationType.warning:
        return semanticColors?.warningColor ?? Colors.orange; // M3 Warning
      case SltNotificationType.error:
        return semanticColors?.errorColor ?? colorScheme.error; // M3 Error
      case SltNotificationType.info:
      default:
        return semanticColors?.infoColor ??
            colorScheme.secondary; // M3 Secondary or custom info
    }
  }

  IconData _getDefaultIcon(SltNotificationType type) {
    switch (type) {
      case SltNotificationType.success:
        return Icons.check_circle_outline_rounded;
      case SltNotificationType.warning:
        return Icons.warning_amber_rounded;
      case SltNotificationType.error:
        return Icons.error_outline_rounded;
      case SltNotificationType.info:
      default:
        return Icons.info_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveIcon = icon ?? _getDefaultIcon(type);
    final typeColor = _getTypeColor(context, type, colorScheme);

    final titleStyle = AppTypography.titleSmall.copyWith(
      color: isRead ? colorScheme.onSurfaceVariant : colorScheme.onSurface,
      fontWeight: isRead ? FontWeight.normal : FontWeight.w600,
    );
    final messageStyle = AppTypography.bodySmall.copyWith(
      color: isRead
          ? colorScheme.onSurfaceVariant.withOpacity(0.7)
          : colorScheme.onSurfaceVariant,
    );
    final timeStyle = AppTypography.labelSmall.copyWith(
      color: colorScheme.onSurfaceVariant.withOpacity(0.6),
    );

    Widget cardContent = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingM,
        vertical: AppDimens.paddingS,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.paddingXXS,
                  right: AppDimens.paddingM,
                ),
                child: Icon(
                  effectiveIcon,
                  color: typeColor,
                  size: AppDimens.iconM,
                ),
              ),
              if (!isRead)
                Positioned(
                  top: 0,
                  right: AppDimens.paddingS - 2,
                  child: Container(
                    width: AppDimens.paddingS,
                    height: AppDimens.paddingS,
                    decoration: BoxDecoration(
                      color: typeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: titleStyle),
                if (message != null && message!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimens.paddingXXS),
                    child: Text(
                      message!,
                      style: messageStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (timestamp != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppDimens.paddingXS),
                    child: Text(
                      SltDateUtils.DateUtils.getTimeAgo(timestamp!),
                      style: timeStyle,
                    ),
                  ),
              ],
            ),
          ),
          if (trailingAction != null)
            Padding(
              padding: const EdgeInsets.only(left: AppDimens.paddingS),
              child: trailingAction,
            )
          else if (onDismiss != null)
            IconButton(
              icon: const Icon(Icons.close, size: AppDimens.iconS),
              color: colorScheme.onSurfaceVariant,
              tooltip: 'Dismiss',
              onPressed: onDismiss,
            ),
        ],
      ),
    );

    if (onTap != null) {
      return Card(
        elevation: isRead ? AppDimens.elevationNone : AppDimens.elevationXS,
        color: isRead
            ? colorScheme.surfaceContainer
            : colorScheme.surfaceContainerLow,
        // Slightly different bg for unread
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
          side: BorderSide(
            color: isRead
                ? colorScheme.outlineVariant.withOpacity(0.3)
                : typeColor.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
          child: cardContent,
        ),
      );
    }

    return Card(
      elevation: isRead ? AppDimens.elevationNone : AppDimens.elevationXS,
      color: isRead
          ? colorScheme.surfaceContainer
          : colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        side: BorderSide(
          color: isRead
              ? colorScheme.outlineVariant.withOpacity(0.3)
              : typeColor.withOpacity(0.5),
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: cardContent,
    );
  }
}

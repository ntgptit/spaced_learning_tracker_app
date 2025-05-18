// lib/presentation/widgets/dialogs/slt_alert_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_dialog_button_bar.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';

part 'slt_alert_dialog.g.dart';

enum AlertType { info, success, warning, error }

@riverpod
class AlertDialogState extends _$AlertDialogState {
  @override
  Map<String, bool> build() {
    // Map of dialog IDs to visibility states
    return {};
  }

  void showDialog(String dialogId) {
    state = {...state, dialogId: true};
  }

  void hideDialog(String dialogId) {
    state = {...state, dialogId: false};
  }

  bool isDialogVisible(String dialogId) {
    return state[dialogId] ?? false;
  }
}

/// An alert dialog with Material 3 design principles and customizable options.
class SltAlertDialog extends ConsumerWidget {
  final String title;
  final String message;
  final String? confirmButtonText;
  final VoidCallback? onConfirm;
  final IconData? icon;
  final AlertType alertType;
  final bool barrierDismissible;
  final bool autoDismiss;
  final Duration autoDismissDuration;
  final Widget? customContent;
  final List<Widget>? customActions; // For completely custom actions
  final String? cancelButtonText; // Added for two-button scenarios
  final VoidCallback? onCancel; // Added for two-button scenarios
  final String dialogId;

  const SltAlertDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmButtonText,
    this.onConfirm,
    this.icon,
    this.alertType = AlertType.info,
    this.barrierDismissible = true,
    this.autoDismiss = false,
    this.autoDismissDuration = const Duration(seconds: 3),
    this.customContent,
    this.customActions,
    this.cancelButtonText,
    this.onCancel,
    this.dialogId = 'default',
  });

  // Factory constructor for a generic info alert
  factory SltAlertDialog.info({
    required String title,
    required String message,
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
    bool autoDismiss = false,
    String dialogId = 'info_dialog',
  }) {
    return SltAlertDialog(
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
      alertType: AlertType.info,
      icon: Icons.info_outline_rounded,
      autoDismiss: autoDismiss,
      dialogId: dialogId,
    );
  }

  // Factory constructor for a success alert
  factory SltAlertDialog.success({
    required String title,
    required String message,
    String confirmButtonText = 'Great!',
    VoidCallback? onConfirm,
    bool autoDismiss = true,
    Duration autoDismissDuration = const Duration(seconds: 2),
    String dialogId = 'success_dialog',
  }) {
    return SltAlertDialog(
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
      alertType: AlertType.success,
      icon: Icons.check_circle_outline_rounded,
      autoDismiss: autoDismiss,
      autoDismissDuration: autoDismissDuration,
      dialogId: dialogId,
    );
  }

  // Factory constructor for a warning alert
  factory SltAlertDialog.warning({
    required String title,
    required String message,
    String confirmButtonText = 'Understood',
    VoidCallback? onConfirm,
    String? cancelButtonText = 'Cancel',
    VoidCallback? onCancel,
    List<Widget>? customActions,
    String dialogId = 'warning_dialog',
  }) {
    return SltAlertDialog(
      title: title,
      message: message,
      confirmButtonText: customActions == null ? confirmButtonText : null,
      onConfirm: customActions == null ? onConfirm : null,
      cancelButtonText: customActions == null ? cancelButtonText : null,
      onCancel: customActions == null ? onCancel : null,
      alertType: AlertType.warning,
      icon: Icons.warning_amber_rounded,
      customActions: customActions,
      dialogId: dialogId,
    );
  }

  // Factory constructor for an error alert
  factory SltAlertDialog.error({
    required String title,
    required String message,
    String confirmButtonText = 'Dismiss',
    VoidCallback? onConfirm,
    String dialogId = 'error_dialog',
  }) {
    return SltAlertDialog(
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
      alertType: AlertType.error,
      icon: Icons.error_outline_rounded,
      dialogId: dialogId,
    );
  }

  IconData _getAlertIcon() {
    switch (alertType) {
      case AlertType.success:
        return icon ?? Icons.check_circle_outline_rounded;
      case AlertType.warning:
        return icon ?? Icons.warning_amber_rounded;
      case AlertType.error:
        return icon ?? Icons.error_outline_rounded;
      case AlertType.info:
        return icon ?? Icons.info_outline_rounded;
    }
  }

  Color _getAlertColor(ColorScheme colorScheme) {
    switch (alertType) {
      case AlertType.success:
        return colorScheme.tertiary;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.error:
        return colorScheme.error;
      case AlertType.info:
        return colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (autoDismiss && context.mounted) {
      Future.delayed(autoDismissDuration, () {
        if (context.mounted) {
          Navigator.of(context).pop();
          ref.read(alertDialogStateProvider.notifier).hideDialog(dialogId);
        }
      });
    }

    final Color effectiveAlertColor = _getAlertColor(colorScheme);
    final IconData effectiveIcon = _getAlertIcon();

    Widget? confirmActionWidget;
    if (confirmButtonText != null) {
      confirmActionWidget = SltPrimaryButton(
        text: confirmButtonText!,
        onPressed:
            onConfirm ??
            () {
              Navigator.of(context).pop();
              ref.read(alertDialogStateProvider.notifier).hideDialog(dialogId);
            },
        backgroundColor: effectiveAlertColor,
        foregroundColor: effectiveAlertColor.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white,
      );
    }

    Widget? cancelActionWidget;
    if (cancelButtonText != null) {
      cancelActionWidget = SltTextButton(
        text: cancelButtonText!,
        onPressed:
            onCancel ??
            () {
              Navigator.of(context).pop(false);
              ref.read(alertDialogStateProvider.notifier).hideDialog(dialogId);
            },
      );
    }

    final List<Widget> effectiveActions =
        customActions ??
        [
          if (cancelActionWidget != null) cancelActionWidget,
          if (confirmActionWidget != null) confirmActionWidget,
        ].where((widget) => widget != null).toList().cast<Widget>();

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
      ),
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      titlePadding: const EdgeInsets.fromLTRB(
        AppDimens.paddingL,
        AppDimens.paddingL,
        AppDimens.paddingL,
        AppDimens.paddingS,
      ),
      contentPadding: EdgeInsets.fromLTRB(
        AppDimens.paddingL,
        AppDimens.paddingS,
        AppDimens.paddingL,
        (effectiveActions.isEmpty) ? AppDimens.paddingL : AppDimens.paddingS,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingM,
      ),
      icon: Container(
        padding: const EdgeInsets.all(AppDimens.paddingXS),
        decoration: BoxDecoration(
          color: effectiveAlertColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          effectiveIcon,
          color: effectiveAlertColor,
          size: AppDimens.iconL,
        ),
      ),
      iconPadding: const EdgeInsets.only(
        top: AppDimens.paddingL,
        bottom: AppDimens.paddingS,
      ),
      title: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        textAlign: TextAlign.center,
      ),
      content:
          customContent ??
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
      actionsAlignment: MainAxisAlignment.end,
      actionsOverflowButtonSpacing: AppDimens.spaceS,
      actions: effectiveActions.isNotEmpty
          ? [
              SltDialogButtonBar(
                cancelButton: cancelActionWidget,
                confirmButton: confirmActionWidget,
              ),
            ]
          : null,
    );
  }

  /// Show the alert dialog
  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String message,
    String? confirmButtonText,
    VoidCallback? onConfirm,
    IconData? icon,
    AlertType alertType = AlertType.info,
    bool barrierDismissible = true,
    bool autoDismiss = false,
    Duration autoDismissDuration = const Duration(seconds: 3),
    Widget? customContent,
    List<Widget>? customActions,
    String? cancelButtonText,
    VoidCallback? onCancel,
    String dialogId = 'default_alert',
  }) {
    // Register dialog as visible
    ref.read(alertDialogStateProvider.notifier).showDialog(dialogId);

    // Determine default button text if not provided for custom actions
    String effectiveConfirmButtonText = confirmButtonText ?? 'OK';
    if (customActions == null &&
        onConfirm == null &&
        confirmButtonText == null) {
      effectiveConfirmButtonText = 'OK';
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return SltAlertDialog(
          title: title,
          message: message,
          confirmButtonText: effectiveConfirmButtonText,
          onConfirm: onConfirm,
          icon: icon,
          alertType: alertType,
          autoDismiss: autoDismiss,
          autoDismissDuration: autoDismissDuration,
          customContent: customContent,
          customActions: customActions,
          cancelButtonText: cancelButtonText,
          onCancel: onCancel,
          dialogId: dialogId,
        );
      },
    ).then((_) {
      // When dialog is closed, update state
      ref.read(alertDialogStateProvider.notifier).hideDialog(dialogId);
    });
  }
}

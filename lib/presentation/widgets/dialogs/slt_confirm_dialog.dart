import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_dialog_button_bar.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';

class SltConfirmDialog extends ConsumerWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDangerAction; // True if the confirm action is destructive
  final bool barrierDismissible;
  final IconData? icon;
  final Color? iconColor;
  final Color? confirmButtonColor; // Custom color for the confirm button
  final Color? cancelButtonColor; // Custom color for the cancel button text

  const SltConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.isDangerAction = false,
    this.barrierDismissible = true,
    this.icon,
    this.iconColor,
    this.confirmButtonColor,
    this.cancelButtonColor,
  });

  factory SltConfirmDialog._create({
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    required VoidCallback? onConfirm,
    required VoidCallback? onCancel,
    required bool isDangerAction,
    required IconData? icon,
    Color? iconColor,
    Color? confirmButtonColor,
  }) {
    return SltConfirmDialog(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      isDangerAction: isDangerAction,
      icon: icon,
      iconColor: iconColor,
      confirmButtonColor: confirmButtonColor,
    );
  }

  factory SltConfirmDialog.standard({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData icon = Icons.help_outline_rounded,
  }) {
    return SltConfirmDialog._create(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      isDangerAction: false,
      icon: icon,
    );
  }

  factory SltConfirmDialog.delete({
    required String title,
    required String message,
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return SltConfirmDialog._create(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      isDangerAction: true,
      icon: Icons.delete_outline_rounded,
    );
  }

  factory SltConfirmDialog.warning({
    required String title,
    required String message,
    String confirmText = 'Continue',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return SltConfirmDialog._create(
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      isDangerAction: false,
      icon: Icons.warning_amber_rounded,
      iconColor: Colors.orange,
      confirmButtonColor: Colors.orange, // Default warning color
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveIconColor =
        iconColor ?? (isDangerAction ? colorScheme.error : colorScheme.primary);

    final effectiveConfirmButtonColor =
        confirmButtonColor ??
        (isDangerAction ? colorScheme.error : colorScheme.primary);

    final effectiveConfirmButtonForegroundColor =
        effectiveConfirmButtonColor.computeLuminance() > 0.5
        ? colorScheme.onSurface
        : colorScheme.surface;

    final SltTextButton cancelAction = SltTextButton(
      text: cancelText,
      onPressed: () {
        if (onCancel != null) {
          onCancel!();
        } else {
          Navigator.of(context).pop(false);
        }
      },
      foregroundColor: cancelButtonColor ?? colorScheme.onSurfaceVariant,
    );

    final SltPrimaryButton confirmAction = SltPrimaryButton(
      text: confirmText,
      onPressed: () {
        if (onConfirm != null) {
          onConfirm!();
        } else {
          Navigator.of(context).pop(true);
        }
      },
      backgroundColor: effectiveConfirmButtonColor,
      foregroundColor: effectiveConfirmButtonForegroundColor,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
      ),
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      iconPadding: const EdgeInsets.only(
        top: AppDimens.paddingL,
        bottom: AppDimens.paddingS,
      ),
      icon: icon != null
          ? Icon(icon, color: effectiveIconColor, size: AppDimens.iconL)
          : null,
      titlePadding: const EdgeInsets.fromLTRB(
        AppDimens.paddingL,
        AppDimens.paddingM,
        AppDimens.paddingL,
        AppDimens.paddingS,
      ),
      contentPadding: const EdgeInsets.fromLTRB(
        AppDimens.paddingL,
        AppDimens.paddingS,
        AppDimens.paddingL,
        AppDimens.paddingL,
      ),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingM,
      ),
      actionsAlignment: MainAxisAlignment.end,
      title: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: isDangerAction ? colorScheme.error : colorScheme.onSurface,
        ),
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
      ),
      content: Text(
        message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        textAlign: icon != null ? TextAlign.center : TextAlign.start,
      ),
      actions: [
        SltDialogButtonBar(
          cancelButton: cancelAction,
          confirmButton: confirmAction,
        ),
      ],
    );
  }

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDangerAction = false,
    bool barrierDismissible = true,
    IconData? icon,
    Color? iconColor,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => SltConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDangerAction: isDangerAction,
        barrierDismissible: barrierDismissible,
        icon: icon,
        iconColor: iconColor,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
      ),
    );
  }
}

// lib/presentation/widgets/services/slt_dialog_service.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dialogs/slt_alert_dialog.dart';
import '../dialogs/slt_confirm_dialog.dart';
import '../dialogs/slt_progress_dialog.dart';
import '../states/slt_loading_state_widget.dart';

part 'slt_dialog_service.g.dart';

enum DialogType {
  alert,
  confirm,
  progress,
  input,
  dateTime,
  bottomSheet,
  fullScreen,
}

@riverpod
class DialogService extends _$DialogService {
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

  void hideAllDialogs() {
    final Map<String, bool> updatedState = {};
    state.forEach((key, _) {
      updatedState[key] = false;
    });
    state = updatedState;
  }

  bool isDialogVisible(String dialogId) {
    return state[dialogId] ?? false;
  }

  // Helper methods for specific dialog types
  Future<void> showProgressDialog(
    BuildContext context, {
    required String dialogId,
    String message = 'Loading...',
    bool barrierDismissible = false,
    Color? progressColor,
    Duration? timeout,
    VoidCallback? onTimeout,
    LoadingIndicatorType indicatorType = LoadingIndicatorType.threeBounce,
  }) async {
    showDialog(dialogId);

    await SltProgressDialog.show(
      context,
      ref as WidgetRef,
      dialogId: dialogId,
      message: message,
      barrierDismissible: barrierDismissible,
      progressColor: progressColor,
      timeout: timeout,
      onTimeout: onTimeout,
      indicatorType: indicatorType,
    );

    hideDialog(dialogId);
  }

  Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDangerAction = false,
    IconData? icon,
  }) {
    final dialogId = 'confirm_${DateTime.now().millisecondsSinceEpoch}';
    showDialog(dialogId);

    return SltConfirmDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: () {
        if (onConfirm != null) {
          onConfirm();
        }
        hideDialog(dialogId);
      },
      onCancel: () {
        if (onCancel != null) {
          onCancel();
        }
        hideDialog(dialogId);
      },
      isDangerAction: isDangerAction,
      icon: icon,
    );
  }

  Future<void> showAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmButtonText = 'OK',
    VoidCallback? onConfirm,
    AlertType alertType = AlertType.info,
    IconData? icon,
    bool autoDismiss = false,
    Duration autoDismissDuration = const Duration(seconds: 3),
  }) async {
    final dialogId = 'alert_${DateTime.now().millisecondsSinceEpoch}';
    showDialog(dialogId);

    await SltAlertDialog.show(
      context,
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      onConfirm: () {
        if (onConfirm != null) {
          onConfirm();
        }
        hideDialog(dialogId);
      },
      alertType: alertType,
      icon: icon,
      autoDismiss: autoDismiss,
      autoDismissDuration: autoDismissDuration,
    );

    hideDialog(dialogId);
  }

  Future<String?> showInputDialog(
    BuildContext context,
    WidgetRef ref, {
    required String dialogId,
    required String title,
    String? message,
    String? initialValue,
    String? hintText,
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
    IconData? prefixIcon,
  }) {
    showDialog(dialogId);

    return SltInputDialog.show(
      context,
      ref,
      dialogId: dialogId,
      title: title,
      message: message,
      initialValue: initialValue,
      hintText: hintText,
      confirmText: confirmText,
      cancelText: cancelText,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      prefixIcon: prefixIcon,
    ).then((result) {
      hideDialog(dialogId);
      return result;
    });
  }

  void hideProgressDialog(
    BuildContext context,
    WidgetRef ref, {
    String dialogId = 'default',
  }) {
    SltProgressDialog.hide(context, ref, dialogId: dialogId);
    hideDialog(dialogId);
  }
}

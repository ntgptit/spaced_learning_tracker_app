// lib/presentation/widgets/managers/slt_dialog_manager.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dialogs/slt_alert_dialog.dart';
import '../dialogs/slt_confirm_dialog.dart';
import '../dialogs/slt_date_picker_dialog.dart';
import '../dialogs/slt_progress_dialog.dart';
import '../dialogs/slt_time_picker_dialog.dart';

part 'slt_dialog_manager.g.dart';

/// Enum for tracking different types of dialogs
enum DialogType {
  alert,
  confirm,
  progress,
  input,
  date,
  time,
  bottomSheet,
  fullScreen,
}

/// Model class for dialog request
class DialogRequest {
  final String id;
  final DialogType type;
  final Map<String, dynamic> params;

  DialogRequest({required this.id, required this.type, this.params = const {}});
}

/// Model class for dialog response
class DialogResponse {
  final String id;
  final bool confirmed;
  final dynamic result;

  DialogResponse({required this.id, this.confirmed = false, this.result});
}

@riverpod
class DialogManager extends _$DialogManager {
  static const defaultId = 'default_dialog';

  @override
  Map<String, DialogRequest> build() => {};

  // Add a dialog to the active dialogs map
  void showDialog({
    required DialogType type,
    String id = defaultId,
    Map<String, dynamic> params = const {},
  }) {
    final request = DialogRequest(id: id, type: type, params: params);

    state = {...state, id: request};
  }

  // Remove a dialog from the active dialogs map
  void hideDialog(String id) {
    final newState = Map<String, DialogRequest>.from(state);
    newState.remove(id);
    state = newState;
  }

  // Check if a dialog is currently showing
  bool isDialogActive(String id) => state.containsKey(id);

  // Get all active dialogs
  List<DialogRequest> get activeDialogs => state.values.toList();

  // Utility method to show an alert dialog
  Future<void> showAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmButtonText,
    VoidCallback? onConfirm,
    AlertType alertType = AlertType.info,
    IconData? icon,
    String id = 'alert_dialog',
  }) async {
    // Register the dialog
    showDialog(type: DialogType.alert, id: id);

    // Show the actual dialog
    await SltAlertDialog.show(
      context,
      ref as WidgetRef,
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm != null
          ? () {
              onConfirm();
              hideDialog(id);
            }
          : () => hideDialog(id),
      alertType: alertType,
      icon: icon,
      dialogId: id,
    );

    // Ensure dialog is removed from state
    if (isDialogActive(id)) {
      hideDialog(id);
    }
  }

  // Utility method to show a confirmation dialog
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
    String id = 'confirm_dialog',
  }) {
    // Register the dialog
    showDialog(type: DialogType.confirm, id: id);

    return SltConfirmDialog.show(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm != null
          ? () {
              onConfirm();
              hideDialog(id);
            }
          : null,
      onCancel: onCancel != null
          ? () {
              onCancel();
              hideDialog(id);
            }
          : null,
      isDangerAction: isDangerAction,
      icon: icon,
    ).then((result) {
      hideDialog(id);
      return result;
    });
  }

  // Utility method to show a progress dialog
  Future<void> showProgressDialog(
    BuildContext context,
    WidgetRef ref, {
    String message = 'Loading...',
    bool barrierDismissible = false,
    Color? progressColor,
    Duration? timeout,
    VoidCallback? onTimeout,
    String id = 'progress_dialog',
  }) async {
    // Register the dialog
    showDialog(type: DialogType.progress, id: id);

    await SltProgressDialog.show(
      context,
      ref,
      dialogId: id,
      message: message,
      barrierDismissible: barrierDismissible,
      progressColor: progressColor,
      timeout: timeout,
      onTimeout: onTimeout,
    );

    hideDialog(id);
  }

  // Utility method to hide a progress dialog
  void hideProgressDialog(
    BuildContext context,
    WidgetRef ref, {
    String id = 'progress_dialog',
  }) {
    if (isDialogActive(id)) {
      SltProgressDialog.hide(context, ref, dialogId: id);
      hideDialog(id);
    }
  }

  // Utility method to show a date picker dialog
  Future<DateTime?> showDatePickerDialog(
    BuildContext context,
    WidgetRef ref, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String title = 'Select Date',
    String id = 'date_picker_dialog',
  }) {
    // Register the dialog
    showDialog(type: DialogType.date, id: id);

    return SltDatePickerDialog.show(
      context,
      ref,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      title: title,
    ).then((result) {
      hideDialog(id);
      return result;
    });
  }

  // Utility method to show a time picker dialog
  Future<TimeOfDay?> showTimePickerDialog(
    BuildContext context,
    WidgetRef ref, {
    required TimeOfDay initialTime,
    String title = 'Select Time',
    bool use24HourFormat = false,
    String id = 'time_picker_dialog',
  }) {
    // Register the dialog
    showDialog(type: DialogType.time, id: id);

    return SltTimePickerDialog.show(
      context,
      ref,
      initialTime: initialTime,
      title: title,
      use24HourFormat: use24HourFormat,
    ).then((result) {
      hideDialog(id);
      return result;
    });
  }

  // Utility method to show an input dialog
  Future<String?> showInputDialog(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    String? message,
    String? initialValue,
    String? hintText,
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
    String id = 'input_dialog',
  }) {
    // Register the dialog
    showDialog(type: DialogType.input, id: id);

    return SltInputDialog.show(
      context,
      ref,
      dialogId: id,
      title: title,
      message: message,
      initialValue: initialValue,
      hintText: hintText,
      confirmText: confirmText,
      cancelText: cancelText,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    ).then((result) {
      hideDialog(id);
      return result;
    });
  }
}

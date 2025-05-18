import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';
import '../dialogs/slt_alert_dialog.dart';
import '../dialogs/slt_bottom_sheet_dialog.dart';
import '../dialogs/slt_confirm_dialog.dart';
import '../dialogs/slt_date_picker_dialog.dart';
import '../dialogs/slt_full_screen_dialog.dart';
import '../dialogs/slt_input_dialog.dart';
import '../dialogs/slt_progress_dialog.dart';
import '../dialogs/slt_score_input_dialog_content.dart';
import '../dialogs/slt_time_picker_dialog.dart';
import '../states/slt_loading_state_widget.dart';

part 'slt_dialog_service.g.dart';

/// Types of dialogs that can be shown by the dialog service
enum DialogType {
  alert,
  confirm,
  progress,
  input,
  scoreInput,
  dateTime,
  bottomSheet,
  fullScreen,
}

/// Provider for managing dialog states
@riverpod
class DialogService extends _$DialogService {
  @override
  Map<String, bool> build() {
    // Map of dialog IDs to visibility states
    return {};
  }

  /// Mark a dialog as visible
  void showDialog(String dialogId) {
    state = {...state, dialogId: true};
  }

  /// Mark a dialog as hidden
  void hideDialog(String dialogId) {
    final updatedState = Map<String, bool>.from(state);
    updatedState[dialogId] = false;
    state = updatedState;
  }

  /// Hide all active dialogs
  void hideAllDialogs() {
    final Map<String, bool> updatedState = {};
    state.forEach((key, _) {
      updatedState[key] = false;
    });
    state = updatedState;
  }

  /// Check if a dialog is currently visible
  bool isDialogVisible(String dialogId) {
    return state[dialogId] ?? false;
  }

  // =================== ALERT DIALOG ===================

  /// Show an alert dialog
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
      ref as WidgetRef, // Passing WidgetRef
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
      dialogId: dialogId,
    );

    hideDialog(dialogId);
  }

  /// Show a success alert dialog
  Future<void> showSuccessDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmButtonText = 'Great!',
    VoidCallback? onConfirm,
    bool autoDismiss = true,
  }) async {
    return showAlertDialog(
      context,
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
      alertType: AlertType.success,
      icon: Icons.check_circle_outline_rounded,
      autoDismiss: autoDismiss,
      autoDismissDuration: const Duration(seconds: 2),
    );
  }

  /// Show an error alert dialog
  Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmButtonText = 'Dismiss',
    VoidCallback? onConfirm,
  }) async {
    return showAlertDialog(
      context,
      title: title,
      message: message,
      confirmButtonText: confirmButtonText,
      onConfirm: onConfirm,
      alertType: AlertType.error,
      icon: Icons.error_outline_rounded,
    );
  }

  // =================== CONFIRM DIALOG ===================

  /// Show a confirmation dialog
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
    ).then((result) {
      hideDialog(dialogId);
      return result;
    });
  }

  /// Show a delete confirmation dialog
  Future<bool?> showDeleteConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Delete',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    return showConfirmDialog(
      context,
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

  // =================== PROGRESS DIALOG ===================

  /// Show a progress dialog
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
      ref as WidgetRef, // Passing WidgetRef
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

  /// Hide a progress dialog
  void hideProgressDialog(BuildContext context, {required String dialogId}) {
    SltProgressDialog.hide(context, ref as WidgetRef, dialogId: dialogId);
    hideDialog(dialogId);
  }

  /// Show a processing dialog (with longer timeout)
  Future<void> showProcessingDialog(
    BuildContext context, {
    required String dialogId,
    String message = 'Processing...',
    Duration timeout = const Duration(seconds: 30),
    VoidCallback? onTimeout,
  }) {
    return showProgressDialog(
      context,
      dialogId: dialogId,
      message: message,
      timeout: timeout,
      onTimeout: onTimeout,
      indicatorType: LoadingIndicatorType.fadingCircle,
    );
  }

  /// Show a saving dialog
  Future<void> showSavingDialog(
    BuildContext context, {
    required String dialogId,
    String message = 'Saving...',
    Duration? timeout,
    VoidCallback? onTimeout,
  }) {
    return showProgressDialog(
      context,
      dialogId: dialogId,
      message: message,
      timeout: timeout,
      onTimeout: onTimeout,
      indicatorType: LoadingIndicatorType.pulse,
    );
  }

  // =================== INPUT DIALOG ===================

  /// Show an input dialog
  Future<String?> showInputDialog(
    BuildContext context, {
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
      ref as WidgetRef, // Passing WidgetRef
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

  /// Show a text input dialog with prefilled validator
  Future<String?> showTextInputDialog(
    BuildContext context, {
    required String dialogId,
    required String title,
    String? message,
    String? initialValue,
    String hintText = 'Enter text',
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
    bool required = true,
    IconData? prefixIcon,
  }) {
    return showInputDialog(
      context,
      dialogId: dialogId,
      title: title,
      message: message,
      initialValue: initialValue,
      hintText: hintText,
      confirmText: confirmText,
      cancelText: cancelText,
      keyboardType: TextInputType.text,
      validator: required
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            }
          : null,
      prefixIcon: prefixIcon,
    );
  }

  /// Show an email input dialog
  Future<String?> showEmailInputDialog(
    BuildContext context, {
    required String dialogId,
    String title = 'Enter Email',
    String? message,
    String? initialValue,
    String hintText = 'Enter email address',
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
  }) {
    return showInputDialog(
      context,
      dialogId: dialogId,
      title: title,
      message: message,
      initialValue: initialValue,
      hintText: hintText,
      confirmText: confirmText,
      cancelText: cancelText,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email_outlined,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegExp.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  /// Show a password input dialog
  Future<String?> showPasswordInputDialog(
    BuildContext context, {
    required String dialogId,
    String title = 'Enter Password',
    String? message,
    String hintText = 'Enter password',
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
  }) {
    return showInputDialog(
      context,
      dialogId: dialogId,
      title: title,
      message: message,
      hintText: hintText,
      confirmText: confirmText,
      cancelText: cancelText,
      obscureText: true,
      prefixIcon: Icons.lock_outline_rounded,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
    );
  }

  // =================== SCORE INPUT DIALOG ===================

  /// Show a score input dialog
  Future<double?> showScoreInputDialog(
    BuildContext context, {
    required String dialogId,
    double initialValue = 70.0,
    double minValue = 0.0,
    double maxValue = 100.0,
    int divisions = 100,
    String title = 'Input Score',
    String? subtitle,
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
    IconData? titleIcon = Icons.leaderboard_outlined,
  }) {
    showDialog(dialogId);

    return SltScoreInputDialogContent.show(
      context,
      ref as WidgetRef, // Passing WidgetRef
      dialogId: dialogId,
      initialValue: initialValue,
      minValue: minValue,
      maxValue: maxValue,
      divisions: divisions,
      title: title,
      subtitle: subtitle,
      confirmText: confirmText,
      cancelText: cancelText,
      titleIcon: titleIcon,
    ).then((result) {
      hideDialog(dialogId);
      return result;
    });
  }

  /// Show a feedback score dialog
  Future<double?> showFeedbackScoreDialog(
    BuildContext context, {
    required String dialogId,
    double initialValue = 50.0,
    String title = 'Provide Feedback',
    String? subtitle = 'How would you rate this content?',
  }) {
    return showScoreInputDialog(
      context,
      dialogId: dialogId,
      initialValue: initialValue,
      title: title,
      subtitle: subtitle,
      titleIcon: Icons.feedback_outlined,
      confirmText: 'Submit Feedback',
    );
  }

  // =================== DATE & TIME PICKERS ===================

  /// Show a date picker dialog
  Future<DateTime?> showDatePickerDialog(
    BuildContext context, {
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    String title = 'Select Date',
    String confirmText = 'OK',
    String cancelText = 'CANCEL',
    bool barrierDismissible = true,
    Color? headerBackgroundColor,
    Color? headerForegroundColor,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
  }) {
    final dialogId = 'date_picker_${DateTime.now().millisecondsSinceEpoch}';
    showDialog(dialogId);

    return SltDatePickerDialog.show(
      context,
      ref as WidgetRef, // Passing WidgetRef
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      title: title.toUpperCase(),
      confirmText: confirmText,
      cancelText: cancelText,
      barrierDismissible: barrierDismissible,
      headerBackgroundColor: headerBackgroundColor,
      headerForegroundColor: headerForegroundColor,
      initialEntryMode: initialEntryMode,
    ).then((result) {
      hideDialog(dialogId);
      return result;
    });
  }

  /// Show a date picker dialog for birth date
  Future<DateTime?> showBirthDatePickerDialog(
    BuildContext context, {
    DateTime? initialDate,
    String title = 'SELECT DATE OF BIRTH',
  }) {
    final now = DateTime.now();
    return showDatePickerDialog(
      context,
      initialDate: initialDate ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      title: title,
      initialEntryMode: DatePickerEntryMode.calendar, // ✅ sửa ở đây
    );
  }

  /// Show a time picker dialog
  Future<TimeOfDay?> showTimePickerDialog(
    BuildContext context, {
    required TimeOfDay initialTime,
    String title = 'Select Time',
    String confirmText = 'OK',
    String cancelText = 'CANCEL',
    bool use24HourFormat = false,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  }) {
    final dialogId = 'time_picker_${DateTime.now().millisecondsSinceEpoch}';
    showDialog(dialogId);

    return SltTimePickerDialog.show(
      context,
      ref as WidgetRef, // Passing WidgetRef
      initialTime: initialTime,
      title: title,
      confirmText: confirmText,
      cancelText: cancelText,
      use24HourFormat: use24HourFormat,
      initialEntryMode: initialEntryMode,
    ).then((result) {
      hideDialog(dialogId);
      return result;
    });
  }

  // =================== BOTTOM SHEET DIALOG ===================

  /// Show a bottom sheet dialog
  Future<T?> showBottomSheetDialog<T>(
    BuildContext context, {
    String? title,
    String? message,
    Widget? content,
    List<Widget>? actions,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showCloseButton = true,
    double? maxHeightFraction = 0.85,
    EdgeInsetsGeometry? padding,
    Widget? iconWidget,
    bool useSafeArea = true,
    bool showDivider = true,
    BorderRadius? borderRadius,
    ScrollController? scrollController,
    bool isScrollControlled = true,
    Color? backgroundColor,
    bool showDragHandle = true,
    bool expandToFullScreen = false,
    VoidCallback? onClose,
  }) {
    final dialogId = 'bottom_sheet_${DateTime.now().millisecondsSinceEpoch}';
    showDialog(dialogId);

    return SltBottomSheetDialog.show<T>(
      context,
      title: title,
      message: message,
      content: content,
      actions: actions,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showCloseButton: showCloseButton,
      maxHeightFraction: maxHeightFraction,
      padding: padding,
      iconWidget: iconWidget,
      useSafeArea: useSafeArea,
      showDivider: showDivider,
      borderRadius: borderRadius,
      scrollController: scrollController,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      showDragHandle: showDragHandle,
      expandToFullScreen: expandToFullScreen,
      onClose: onClose != null
          ? () {
              onClose();
              hideDialog(dialogId);
            }
          : () => hideDialog(dialogId),
    ).then((result) {
      hideDialog(dialogId);
      return result;
    });
  }

  /// Show a message bottom sheet
  Future<void> showMessageBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    String closeButtonText = 'OK',
    VoidCallback? onClose,
    Widget? icon,
  }) {
    return showBottomSheetDialog(
      context,
      title: title,
      message: message,
      iconWidget: icon,
      showCloseButton: false,
      actions: [
        SizedBox(
          width: double.infinity,
          child: SltPrimaryButton(
            text: closeButtonText,
            onPressed: () {
              Navigator.pop(context);
              if (onClose != null) {
                onClose();
              }
            },
            isFullWidth: true,
          ),
        ),
      ],
      onClose: onClose,
    );
  }

  /// Show an action sheet
  Future<T?> showActionSheet<T>(
    BuildContext context, {
    String? title,
    required List<Widget> options,
    Widget? cancelButton,
    VoidCallback? onClose,
  }) {
    return showBottomSheetDialog<T>(
      context,
      title: title,
      content: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: options,
      ),
      actions: cancelButton != null ? [cancelButton] : null,
      showCloseButton: title != null && cancelButton == null,
      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingS),
      onClose: onClose,
    );
  }

  // =================== FULL SCREEN DIALOG ===================

  /// Show a full screen dialog
  Future<T?> showFullScreenDialog<T>(
    BuildContext context, {
    required String title,
    required Widget body,
    List<Widget>? actions,
    VoidCallback? onClose,
    bool showAppBar = true,
    Color? backgroundColor,
    IconData? leadingIcon = Icons.close_rounded,
    VoidCallback? onLeadingIconPressed,
    List<Widget>? appBarActions,
    bool showAppBarDivider = true,
    bool useSafeArea = true,
    bool resizeToAvoidBottomInset = true,
    bool centerTitle = false,
    Widget? floatingActionButton,
    EdgeInsetsGeometry? bodyPadding,
    PreferredSizeWidget? customAppBar,
  }) {
    final dialogId = 'full_screen_${DateTime.now().millisecondsSinceEpoch}';
    showDialog(dialogId);

    return SltFullScreenDialog.show<T>(
      context,
      title: title,
      body: body,
      actions: actions,
      onClose: onClose != null
          ? () {
              onClose();
              hideDialog(dialogId);
            }
          : () => hideDialog(dialogId),
      showAppBar: showAppBar,
      backgroundColor: backgroundColor,
      leadingIcon: leadingIcon,
      onLeadingIconPressed: onLeadingIconPressed != null
          ? () {
              onLeadingIconPressed();
              hideDialog(dialogId);
            }
          : null,
      appBarActions: appBarActions,
      showAppBarDivider: showAppBarDivider,
      useSafeArea: useSafeArea,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      centerTitle: centerTitle,
      floatingActionButton: floatingActionButton,
      bodyPadding: bodyPadding,
      customAppBar: customAppBar,
    ).then((result) {
      hideDialog(dialogId);
      return result;
    });
  }

  /// Show an info full screen dialog
  Future<T?> showInfoFullScreenDialog<T>(
    BuildContext context, {
    required String title,
    required Widget contentBody,
    String closeButtonText = 'Done',
    VoidCallback? onCloseAction,
  }) {
    return showFullScreenDialog<T>(
      context,
      title: title,
      body: contentBody,
      actions: [
        SltPrimaryButton(
          text: closeButtonText,
          onPressed: () {
            Navigator.pop(context);
            if (onCloseAction != null) {
              onCloseAction();
            }
          },
        ),
      ],
      centerTitle: true,
    );
  }

  /// Show a form full screen dialog
  Future<T?> showFormFullScreenDialog<T>(
    BuildContext context, {
    required String title,
    required Widget formBody,
    required List<Widget> formActions,
    bool resizeToAvoidBottomInset = true,
    IconData leadingIcon = Icons.arrow_back_rounded,
  }) {
    return showFullScreenDialog<T>(
      context,
      title: title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        child: formBody,
      ),
      actions: formActions,
      leadingIcon: leadingIcon,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      showAppBarDivider: true,
    );
  }
}

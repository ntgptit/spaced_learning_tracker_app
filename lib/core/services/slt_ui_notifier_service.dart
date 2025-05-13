import 'package:flutter/material.dart';

/// UI Notifier Service
/// Handles showing snackbars, dialogs, and other UI notifications
class UiNotifierService {
  /// Show a snackbar
  void showSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    bool isError = false,
    bool isSuccess = false,
    bool isWarning = false,
  }) {
    // Get the ScaffoldMessenger
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // Hide current snackbar if any
    scaffoldMessenger.hideCurrentSnackBar();

    // Create the snackbar
    final snackBar = SnackBar(
      content: Text(message),
      duration: duration,
      action: action,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(8),
      backgroundColor: _getBackgroundColor(
        context,
        isError: isError,
        isSuccess: isSuccess,
        isWarning: isWarning,
      ),
    );

    // Show the snackbar
    scaffoldMessenger.showSnackBar(snackBar);
  }

  /// Show an error snackbar
  void showErrorSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    showSnackBar(
      context,
      message,
      duration: duration,
      action: action,
      isError: true,
    );
  }

  /// Show a success snackbar
  void showSuccessSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    showSnackBar(
      context,
      message,
      duration: duration,
      action: action,
      isSuccess: true,
    );
  }

  /// Show a warning snackbar
  void showWarningSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    showSnackBar(
      context,
      message,
      duration: duration,
      action: action,
      isWarning: true,
    );
  }

  /// Show a dialog
  Future<T?> showAppDialog<T>({
    required BuildContext context,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => child,
    );
  }

  /// Show a confirmation dialog
  Future<bool> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'No',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  )
                : null,
            child: Text(confirmText),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Show a bottom sheet
  Future<T?> showAppBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      builder: (context) => child,
    );
  }

  /// Show a loading dialog
  Future<void> showLoadingDialog({
    required BuildContext context,
    String message = 'Loading...',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 16),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  /// Show a toast
  void showToast(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    // Create an overlay entry
    final overlayState = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 0,
        right: 0,
        child: Container(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    // Show the overlay
    overlayState.insert(overlayEntry);

    // Remove after duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  /// Get background color based on snackbar type
  Color _getBackgroundColor(
    BuildContext context, {
    bool isError = false,
    bool isSuccess = false,
    bool isWarning = false,
  }) {
    if (isError) {
      return Theme.of(context).colorScheme.error;
    } else if (isSuccess) {
      return Colors.green;
    } else if (isWarning) {
      return Colors.orange;
    } else {
      return Theme.of(context).colorScheme.surface;
    }
  }
}

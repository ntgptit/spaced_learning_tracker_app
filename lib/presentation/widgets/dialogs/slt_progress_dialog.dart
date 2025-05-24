import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/app_dimens.dart';
import '../states/slt_loading_state_widget.dart';

part 'slt_progress_dialog.g.dart';

@riverpod
class ProgressDialogState extends _$ProgressDialogState {
  @override
  bool build({String id = 'default'}) => false;

  void show() {
    state = true;
  }

  void hide() {
    state = false;
  }
}

class SltProgressDialog extends ConsumerStatefulWidget {
  final String message;
  final bool barrierDismissible;
  final Color? progressColor;
  final Color? backgroundColor;
  final Duration? timeout;
  final VoidCallback? onTimeout;
  final Widget? customProgressWidget;
  final double progressIndicatorSize;
  final LoadingIndicatorType indicatorType;
  final String dialogId;

  const SltProgressDialog({
    super.key,
    this.message = 'Loading...',
    this.barrierDismissible = false,
    this.progressColor,
    this.backgroundColor,
    this.timeout,
    this.onTimeout,
    this.customProgressWidget,
    this.progressIndicatorSize = AppDimens.circularProgressSizeL,
    this.indicatorType = LoadingIndicatorType.threeBounce,
    required this.dialogId,
  });

  @override
  ConsumerState<SltProgressDialog> createState() => _SltProgressDialogState();

  static Future<void> show(
    BuildContext context,
    WidgetRef ref, {
    String dialogId = 'default',
    String message = 'Loading...',
    bool barrierDismissible = false,
    Color? progressColor,
    Color? backgroundColor,
    Duration? timeout,
    VoidCallback? onTimeout,
    Widget? customProgressWidget,
    double progressIndicatorSize = AppDimens.circularProgressSizeL,
    LoadingIndicatorType indicatorType = LoadingIndicatorType.threeBounce,
  }) {
    ref.read(progressDialogStateProvider(id: dialogId).notifier).show();

    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogContext) => SltProgressDialog(
        message: message,
        barrierDismissible: barrierDismissible,
        progressColor: progressColor,
        backgroundColor: backgroundColor,
        timeout: timeout,
        onTimeout: onTimeout,
        customProgressWidget: customProgressWidget,
        progressIndicatorSize: progressIndicatorSize,
        indicatorType: indicatorType,
        dialogId: dialogId,
      ),
    ).whenComplete(() {
      ref.read(progressDialogStateProvider(id: dialogId).notifier).hide();
    });
  }

  static void hide(
    BuildContext context,
    WidgetRef ref, {
    String dialogId = 'default',
  }) {
    ref.read(progressDialogStateProvider(id: dialogId).notifier).hide();

    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  factory SltProgressDialog.loading({
    required String dialogId,
    String message = 'Loading...',
    Duration? timeout,
    VoidCallback? onTimeout,
  }) {
    return SltProgressDialog(
      message: message,
      timeout: timeout,
      onTimeout: onTimeout,
      indicatorType: LoadingIndicatorType.threeBounce,
      dialogId: dialogId,
    );
  }

  factory SltProgressDialog.processing({
    required String dialogId,
    String message = 'Processing...',
    Duration timeout = const Duration(seconds: 30),
    VoidCallback? onTimeout,
  }) {
    return SltProgressDialog(
      message: message,
      timeout: timeout,
      onTimeout: onTimeout,
      indicatorType: LoadingIndicatorType.fadingCircle,
      dialogId: dialogId,
    );
  }

  factory SltProgressDialog.saving({
    required String dialogId,
    String message = 'Saving changes...',
    Duration? timeout,
    VoidCallback? onTimeout,
  }) {
    return SltProgressDialog(
      message: message,
      timeout: timeout,
      onTimeout: onTimeout,
      indicatorType: LoadingIndicatorType.pulse,
      dialogId: dialogId,
    );
  }
}

class _SltProgressDialogState extends ConsumerState<SltProgressDialog> {
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    if (widget.timeout != null && widget.onTimeout != null) {
      _timeoutTimer = Timer(widget.timeout!, () {
        if (mounted) {
          Navigator.of(context).pop();
          widget.onTimeout!();
        }
      });
    }
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isVisible = ref.watch(
      progressDialogStateProvider(id: widget.dialogId),
    );

    if (!isVisible) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Navigator.of(context, rootNavigator: true).canPop()) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      });
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
      ),
      backgroundColor: widget.backgroundColor ?? colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      contentPadding: const EdgeInsets.all(AppDimens.paddingXL),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.customProgressWidget ??
              SltLoadingIndicator(
                size: widget.progressIndicatorSize,
                color: widget.progressColor ?? colorScheme.primary,
                type: widget.indicatorType,
              ),
          if (widget.message.isNotEmpty) ...[
            const SizedBox(height: AppDimens.spaceL),
            Text(
              widget.message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

part 'slt_floating_action_button.g.dart';

enum SltFabSize { small, regular, large, extended }

@riverpod
class FabState extends _$FabState {
  @override
  bool build({String id = 'default'}) => false;

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}

class SltFloatingActionButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String? label;
  final SltFabSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String? loadingId;

  const SltFloatingActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
    this.size = SltFabSize.regular,
    this.backgroundColor,
    this.foregroundColor,
    this.loadingId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLoading = loadingId != null
        ? ref.watch(fabStateProvider(id: loadingId!))
        : false;

    final effectiveBackgroundColor = backgroundColor ?? colorScheme.primary;
    final effectiveForegroundColor = foregroundColor ?? colorScheme.onPrimary;

    if (size == SltFabSize.extended && label != null) {
      return FloatingActionButton.extended(
        onPressed: isLoading || onPressed == null ? null : onPressed,
        label: Text(label!),
        icon: isLoading
            ? SizedBox(
                width: AppDimens.iconS,
                height: AppDimens.iconS,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    effectiveForegroundColor,
                  ),
                ),
              )
            : Icon(icon),
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveForegroundColor,
      );
    }

    final Widget content = isLoading
        ? SizedBox(
            width: _getLoadingSize(),
            height: _getLoadingSize(),
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveForegroundColor,
              ),
            ),
          )
        : Icon(icon, size: _getIconSize());

    switch (size) {
      case SltFabSize.small:
        return FloatingActionButton.small(
          onPressed: isLoading || onPressed == null ? null : onPressed,
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          child: content,
        );
      case SltFabSize.regular:
        return FloatingActionButton(
          onPressed: isLoading || onPressed == null ? null : onPressed,
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          child: content,
        );
      case SltFabSize.large:
        return FloatingActionButton.large(
          onPressed: isLoading || onPressed == null ? null : onPressed,
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          child: content,
        );
      case SltFabSize.extended:
        return FloatingActionButton(
          onPressed: isLoading || onPressed == null ? null : onPressed,
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          child: content,
        );
    }
  }

  double _getIconSize() {
    switch (size) {
      case SltFabSize.small:
        return AppDimens.iconM;
      case SltFabSize.regular:
      case SltFabSize.extended:
        return AppDimens.iconL;
      case SltFabSize.large:
        return AppDimens.iconXL;
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case SltFabSize.small:
        return AppDimens.iconXS;
      case SltFabSize.regular:
      case SltFabSize.extended:
        return AppDimens.iconS;
      case SltFabSize.large:
        return AppDimens.iconM;
    }
  }
}

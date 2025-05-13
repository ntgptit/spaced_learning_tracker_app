import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_strings.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_secondary_button.dart';

import '../../../core/theme/app_dimens.dart';

/// Confirm dialog
/// A dialog that asks for confirmation with OK and Cancel buttons
class SltConfirmDialog extends StatelessWidget {
  /// Title of the dialog
  final String title;

  /// Message to display
  final String message;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Whether the confirm action is destructive (e.g., delete)
  final bool isDestructive;

  /// Dialog border radius
  final double borderRadius;

  /// Whether to show the cancel button
  final bool showCancelButton;

  /// Icon to display above the title
  final IconData? icon;

  /// Icon color
  final Color? iconColor;

  /// Icon background color
  final Color? iconBackgroundColor;

  /// Icon size
  final double iconSize;

  /// Confirm button color
  final Color? confirmButtonColor;

  /// Cancel button color
  final Color? cancelButtonColor;

  /// Dialog width
  final double? width;

  /// Dialog content padding
  final EdgeInsetsGeometry contentPadding;

  /// Dialog title padding
  final EdgeInsetsGeometry titlePadding;

  /// Dialog action buttons padding
  final EdgeInsetsGeometry actionsPadding;

  const SltConfirmDialog({
    Key? key,
    required this.title,
    required this.message,
    this.confirmText = AppStrings.confirm,
    this.cancelText = AppStrings.cancel,
    this.isDestructive = false,
    this.borderRadius = AppDimens.dialogBorderRadius,
    this.showCancelButton = true,
    this.icon,
    this.iconColor,
    this.iconBackgroundColor,
    this.iconSize = 32.0,
    this.confirmButtonColor,
    this.cancelButtonColor,
    this.width,
    this.contentPadding = AppDimens.dialogContentPadding,
    this.titlePadding = const EdgeInsets.only(
      left: AppDimens.paddingL,
      right: AppDimens.paddingL,
      top: AppDimens.paddingL,
    ),
    this.actionsPadding = const EdgeInsets.all(AppDimens.paddingM),
  }) : super(key: key);

  /// Show the dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = AppStrings.confirm,
    String cancelText = AppStrings.cancel,
    bool isDestructive = false,
    double borderRadius = AppDimens.dialogBorderRadius,
    bool showCancelButton = true,
    IconData? icon,
    Color? iconColor,
    Color? iconBackgroundColor,
    double iconSize = 32.0,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    double? width,
    EdgeInsetsGeometry contentPadding = AppDimens.dialogContentPadding,
    EdgeInsetsGeometry titlePadding = const EdgeInsets.only(
      left: AppDimens.paddingL,
      right: AppDimens.paddingL,
      top: AppDimens.paddingL,
    ),
    EdgeInsetsGeometry actionsPadding =
        const EdgeInsets.all(AppDimens.paddingM),
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => SltConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        isDestructive: isDestructive,
        borderRadius: borderRadius,
        showCancelButton: showCancelButton,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        iconSize: iconSize,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
        width: width,
        contentPadding: contentPadding,
        titlePadding: titlePadding,
        actionsPadding: actionsPadding,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Widget dialogContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Container(
            width: iconSize * 2,
            height: iconSize * 2,
            decoration: BoxDecoration(
              color: iconBackgroundColor ??
                  theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor ?? theme.colorScheme.primary,
            ),
          ),
          AppDimens.vGapM,
        ],
        Text(
          title,
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        AppDimens.vGapM,
        Text(
          message,
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );

    final buttonColor = isDestructive
        ? theme.colorScheme.error
        : confirmButtonColor ?? theme.colorScheme.primary;

    final actionButtons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (showCancelButton) ...[
          SltSecondaryButton(
            text: cancelText,
            onPressed: () => Navigator.of(context).pop(false),
            foregroundColor: cancelButtonColor,
          ),
          AppDimens.hGapM,
        ],
        SltPrimaryButton(
          text: confirmText,
          onPressed: () => Navigator.of(context).pop(true),
          backgroundColor: buttonColor,
        ),
      ],
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        width: width ?? AppDimens.dialogWidth,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: titlePadding,
              child: dialogContent,
            ),
            Padding(
              padding: actionsPadding,
              child: actionButtons,
            ),
          ],
        ),
      ),
    );
  }
}

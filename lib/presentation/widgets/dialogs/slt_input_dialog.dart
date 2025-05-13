import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_strings.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_secondary_button.dart';
import 'package:slt_app/presentation/widgets/inputs/slt_text_field.dart';

import '../../../core/theme/app_dimens.dart';

/// Input dialog
/// A dialog that allows user to input text
class SltInputDialog extends StatefulWidget {
  /// Title of the dialog
  final String title;

  /// Message to display
  final String? message;

  /// Hint text for the input field
  final String? hintText;

  /// Label text for the input field
  final String? labelText;

  /// Initial value for the input field
  final String? initialValue;

  /// Whether input is multiline
  final bool isMultiline;

  /// Confirm button text
  final String confirmText;

  /// Cancel button text
  final String cancelText;

  /// Keyboard type for the input field
  final TextInputType keyboardType;

  /// Validator function
  final String? Function(String?)? validator;

  /// Dialog border radius
  final double borderRadius;

  /// Whether to show the cancel button
  final bool showCancelButton;

  /// Icon to display above the title
  final IconData? icon;

  /// Icon color
  final Color? iconColor;

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

  /// Whether to auto-validate the input
  final bool autoValidate;

  /// Maximum length of input
  final int? maxLength;

  /// Maximum number of lines
  final int? maxLines;

  /// Whether to show counter
  final bool showCounter;

  const SltInputDialog({
    Key? key,
    required this.title,
    this.message,
    this.hintText,
    this.labelText,
    this.initialValue,
    this.isMultiline = false,
    this.confirmText = AppStrings.ok,
    this.cancelText = AppStrings.cancel,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.borderRadius = AppDimens.dialogBorderRadius,
    this.showCancelButton = true,
    this.icon,
    this.iconColor,
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
    this.autoValidate = false,
    this.maxLength,
    this.maxLines,
    this.showCounter = false,
  }) : super(key: key);

  /// Show the dialog
  static Future<String?> show({
    required BuildContext context,
    required String title,
    String? message,
    String? hintText,
    String? labelText,
    String? initialValue,
    bool isMultiline = false,
    String confirmText = AppStrings.ok,
    String cancelText = AppStrings.cancel,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    double borderRadius = AppDimens.dialogBorderRadius,
    bool showCancelButton = true,
    IconData? icon,
    Color? iconColor,
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
    bool autoValidate = false,
    int? maxLength,
    int? maxLines,
    bool showCounter = false,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) => SltInputDialog(
        title: title,
        message: message,
        hintText: hintText,
        labelText: labelText,
        initialValue: initialValue,
        isMultiline: isMultiline,
        confirmText: confirmText,
        cancelText: cancelText,
        keyboardType: keyboardType,
        validator: validator,
        borderRadius: borderRadius,
        showCancelButton: showCancelButton,
        icon: icon,
        iconColor: iconColor,
        iconSize: iconSize,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
        width: width,
        contentPadding: contentPadding,
        titlePadding: titlePadding,
        actionsPadding: actionsPadding,
        autoValidate: autoValidate,
        maxLength: maxLength,
        maxLines: maxLines,
        showCounter: showCounter,
      ),
    );
  }

  @override
  State<SltInputDialog> createState() => _SltInputDialogState();
}

class _SltInputDialogState extends State<SltInputDialog> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final Widget dialogHeader = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            size: widget.iconSize,
            color: widget.iconColor ?? theme.colorScheme.primary,
          ),
          AppDimens.vGapM,
        ],
        Text(
          widget.title,
          style: theme.textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        if (widget.message != null) ...[
          AppDimens.vGapS,
          Text(
            widget.message!,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    final inputField = Form(
      key: _formKey,
      child: SltTextField(
        controller: _controller,
        hintText: widget.hintText,
        labelText: widget.labelText,
        errorText: _errorText,
        keyboardType: widget.keyboardType,
        maxLines: widget.isMultiline ? widget.maxLines ?? 5 : 1,
        minLines: widget.isMultiline ? 3 : 1,
        maxLength: widget.maxLength,
        showCounter: widget.showCounter,
        autovalidateMode: widget.autoValidate
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        validator: widget.validator,
        onChanged: (value) {
          if (_errorText != null) {
            setState(() {
              _errorText = null;
            });
          }
        },
        textInputAction:
            widget.isMultiline ? TextInputAction.newline : TextInputAction.done,
        onSubmitted: widget.isMultiline ? null : (_) => _validateAndSubmit(),
      ),
    );

    final actionButtons = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (widget.showCancelButton) ...[
          SltSecondaryButton(
            text: widget.cancelText,
            onPressed: () => Navigator.of(context).pop(),
            foregroundColor: widget.cancelButtonColor,
          ),
          AppDimens.hGapM,
        ],
        SltPrimaryButton(
          text: widget.confirmText,
          onPressed: _validateAndSubmit,
          backgroundColor: widget.confirmButtonColor,
        ),
      ],
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Container(
        width: widget.width ?? AppDimens.dialogWidthLarge,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: widget.titlePadding,
              child: dialogHeader,
            ),
            Padding(
              padding: widget.contentPadding,
              child: inputField,
            ),
            Padding(
              padding: widget.actionsPadding,
              child: actionButtons,
            ),
          ],
        ),
      ),
    );
  }
}

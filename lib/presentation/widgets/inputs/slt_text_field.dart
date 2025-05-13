import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_dimens.dart';

/// Text field widget
/// A customizable text input field
class SltTextField extends StatelessWidget {
  /// Controller for the text field
  final TextEditingController? controller;

  /// Hint text to display when the field is empty
  final String? hintText;

  /// Label text to display above the field
  final String? labelText;

  /// Error text to display below the field
  final String? errorText;

  /// Helper text to display below the field
  final String? helperText;

  /// Prefix icon
  final IconData? prefixIcon;

  /// Suffix icon
  final IconData? suffixIcon;

  /// Callback when suffix icon is pressed
  final VoidCallback? onSuffixIconPressed;

  /// Keyboard type
  final TextInputType keyboardType;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Focus node
  final FocusNode? focusNode;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the field is read-only
  final bool readOnly;

  /// Whether the field is obscured (for passwords)
  final bool obscureText;

  /// Maximum number of lines
  final int? maxLines;

  /// Minimum number of lines
  final int? minLines;

  /// Maximum length of input
  final int? maxLength;

  /// Whether to show counter
  final bool showCounter;

  /// Border radius
  final double borderRadius;

  /// Text alignment
  final TextAlign textAlign;

  /// Auto validation mode
  final AutovalidateMode? autovalidateMode;

  /// Validator function
  final String? Function(String?)? validator;

  /// On changed callback
  final Function(String)? onChanged;

  /// On submitted callback
  final Function(String)? onSubmitted;

  /// On tap callback
  final VoidCallback? onTap;

  /// Content padding
  final EdgeInsetsGeometry contentPadding;

  /// Border color
  final Color? borderColor;

  /// Focus border color
  final Color? focusBorderColor;

  /// Error border color
  final Color? errorBorderColor;

  /// Fill color
  final Color? fillColor;

  /// Initial value
  final String? initialValue;

  /// Text style
  final TextStyle? style;

  const SltTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCounter = false,
    this.borderRadius = AppDimens.radiusM,
    this.textAlign = TextAlign.start,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.contentPadding = AppDimens.inputPadding,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.fillColor,
    this.initialValue,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultBorderColor = borderColor ?? theme.dividerColor;
    final defaultFocusBorderColor =
        focusBorderColor ?? theme.colorScheme.primary;
    final defaultErrorBorderColor = errorBorderColor ?? theme.colorScheme.error;
    final defaultFillColor = fillColor ?? theme.inputDecorationTheme.fillColor;

    // Build the input decoration
    final inputDecoration = InputDecoration(
      hintText: hintText,
      labelText: labelText,
      errorText: errorText,
      helperText: helperText,
      filled: true,
      fillColor: defaultFillColor,
      counter: showCounter ? null : const SizedBox.shrink(),
      contentPadding: contentPadding,

      // Prefix icon
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,

      // Suffix icon
      suffixIcon: suffixIcon != null
          ? IconButton(
              icon: Icon(suffixIcon),
              onPressed: onSuffixIconPressed,
            )
          : null,

      // Border styling
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: defaultBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: defaultBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: defaultFocusBorderColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: defaultErrorBorderColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: defaultErrorBorderColor, width: 2.0),
      ),
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      decoration: inputDecoration,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      focusNode: focusNode,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      textAlign: textAlign,
      style: style ?? theme.textTheme.bodyMedium,
      inputFormatters: inputFormatters,
      autovalidateMode: autovalidateMode,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
    );
  }
}

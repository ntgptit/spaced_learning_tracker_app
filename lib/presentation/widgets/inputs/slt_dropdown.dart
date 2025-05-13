import 'package:flutter/material.dart';

import '../../../core/theme/app_dimens.dart';

/// Dropdown widget
/// A customizable dropdown selector
class SltDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hint;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final double borderRadius;
  final bool enabled;
  final Widget? icon;
  final ButtonStyle? buttonStyle;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final Color? fillColor;
  final int elevation;
  final TextStyle? style;
  final AlignmentGeometry alignment;
  final bool isExpanded;
  final String? Function(T?)? validator;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry contentPadding;
  final double borderWidth;
  final double? iconSize;
  final bool showUnderline;

  const SltDropdown({
    Key? key,
    required this.items,
    this.value,
    this.onChanged,
    this.hint,
    this.labelText,
    this.errorText,
    this.helperText,
    this.borderRadius = AppDimens.radiusM,
    this.enabled = true,
    this.icon,
    this.buttonStyle,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.fillColor,
    this.elevation = 8,
    this.style,
    this.alignment = AlignmentDirectional.centerStart,
    this.isExpanded = true,
    this.validator,
    this.autovalidateMode,
    this.contentPadding = AppDimens.inputPadding,
    this.borderWidth = 1.0,
    this.iconSize,
    this.showUnderline = false,
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
      labelText: labelText,
      hintText: hint,
      helperText: helperText,
      errorText: errorText,
      filled: true,
      fillColor: defaultFillColor,
      contentPadding: contentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: defaultBorderColor, width: borderWidth),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: defaultBorderColor, width: borderWidth),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
            color: defaultFocusBorderColor, width: borderWidth * 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide:
            BorderSide(color: defaultErrorBorderColor, width: borderWidth),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
            color: defaultErrorBorderColor, width: borderWidth * 1.5),
      ),
    );

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          hint: hint != null ? Text(hint!) : null,
          style: style ?? theme.textTheme.bodyMedium,
          icon: icon ?? Icon(Icons.arrow_drop_down, size: iconSize),
          decoration: inputDecoration,
          elevation: elevation,
          alignment: alignment,
          isExpanded: isExpanded,
          validator: validator,
          autovalidateMode: autovalidateMode,
          borderRadius: BorderRadius.circular(borderRadius),
          dropdownColor: defaultFillColor,
          focusColor: defaultFillColor,
          iconEnabledColor: theme.colorScheme.primary,
          iconDisabledColor: theme.disabledColor,
          isDense: false,
        ),
        if (showUnderline)
          Positioned(
            left: contentPadding.horizontal / 2,
            right: contentPadding.horizontal / 2,
            bottom: 0,
            child: Container(
              height: 1,
              color: defaultBorderColor,
            ),
          ),
      ],
    );
  }
}

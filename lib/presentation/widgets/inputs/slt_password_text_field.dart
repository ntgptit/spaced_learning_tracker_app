import 'package:flutter/material.dart';
import 'package:slt_app/presentation/widgets/inputs/slt_text_field.dart';

import '../../../core/theme/app_dimens.dart';

/// Password text field widget
/// A specialized text field for passwords with show/hide functionality
class SltPasswordTextField extends StatefulWidget {
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

  /// Text input action
  final TextInputAction? textInputAction;

  /// Focus node
  final FocusNode? focusNode;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the field is read-only
  final bool readOnly;

  /// Border radius
  final double borderRadius;

  /// Auto validation mode
  final AutovalidateMode? autovalidateMode;

  /// Validator function
  final String? Function(String?)? validator;

  /// On changed callback
  final Function(String)? onChanged;

  /// On submitted callback
  final Function(String)? onSubmitted;

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

  /// Show password icon
  final IconData showPasswordIcon;

  /// Hide password icon
  final IconData hidePasswordIcon;

  /// Whether to initially show the password
  final bool initiallyVisible;

  const SltPasswordTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.textInputAction,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.borderRadius = AppDimens.radiusM,
    this.autovalidateMode,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.contentPadding = AppDimens.inputPadding,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.fillColor,
    this.initialValue,
    this.style,
    this.showPasswordIcon = Icons.visibility_outlined,
    this.hidePasswordIcon = Icons.visibility_off_outlined,
    this.initiallyVisible = false,
  }) : super(key: key);

  @override
  State<SltPasswordTextField> createState() => _SltPasswordTextFieldState();
}

class _SltPasswordTextFieldState extends State<SltPasswordTextField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = widget.initiallyVisible;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SltTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      labelText: widget.labelText,
      errorText: widget.errorText,
      helperText: widget.helperText,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      obscureText: !_isPasswordVisible,
      borderRadius: widget.borderRadius,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      contentPadding: widget.contentPadding,
      borderColor: widget.borderColor,
      focusBorderColor: widget.focusBorderColor,
      errorBorderColor: widget.errorBorderColor,
      fillColor: widget.fillColor,
      initialValue: widget.initialValue,
      style: widget.style,
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: Icons.lock_outline,
      suffixIcon: _isPasswordVisible
          ? widget.hidePasswordIcon
          : widget.showPasswordIcon,
      onSuffixIconPressed: _togglePasswordVisibility,
    );
  }
}

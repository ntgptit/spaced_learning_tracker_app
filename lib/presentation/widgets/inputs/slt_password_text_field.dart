import 'package:flutter/material.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';

class SltPasswordField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final IconData? prefixIconData;
  final Widget? prefixIcon; // Widget-based prefix icon
  final Widget? prefixWidget;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Color? labelColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final SltTextFieldSize size;

  const SltPasswordField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.prefixIconData,
    this.prefixIcon,
    this.prefixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.textInputAction = TextInputAction.done,
    this.focusNode,
    this.validator,
    this.labelColor,
    this.hintColor,
    this.errorColor,
    this.borderColor,
    this.focusedBorderColor,
    this.backgroundColor,
    this.size = SltTextFieldSize.medium,
  });

  @override
  State<SltPasswordField> createState() => _SltPasswordFieldState();
}

class _SltPasswordFieldState extends State<SltPasswordField> {
  @override
  Widget build(BuildContext context) {
    // Sửa lỗi - Không dùng dynamic mà xử lý đúng theo kiểu
    return SltTextField(
      label: widget.label,
      hint: widget.hint,
      controller: widget.controller,
      errorText: widget.errorText,
      // Sử dụng đúng typesafe: prefixIcon dùng cho IconData
      prefixIcon: widget.prefixIconData,
      // prefix dùng cho Widget
      prefix: widget.prefixIcon ?? widget.prefixWidget,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      validator: widget.validator,
      labelColor: widget.labelColor,
      hintColor: widget.hintColor,
      errorColor: widget.errorColor,
      borderColor: widget.borderColor,
      focusedBorderColor: widget.focusedBorderColor,
      backgroundColor: widget.backgroundColor,
      size: widget.size,
    );
  }
}

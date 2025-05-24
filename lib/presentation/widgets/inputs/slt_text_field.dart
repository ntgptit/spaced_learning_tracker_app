import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

enum SltTextFieldSize {
  small,
  medium, // Default
}

class SltTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
  final String? initialValue; // <<--- ADDED: New parameter
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool enabled;
  final IconData? prefixIcon;
  final Widget? prefix;
  final IconData? suffixIcon;
  final Widget? suffix;
  final VoidCallback? onSuffixIconTap;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool showCounter;
  final bool autofocus;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? fillColor;
  final Color? labelColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? iconColor;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final SltTextFieldSize size;

  const SltTextField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.helperText,
    this.initialValue, // <<--- ADDED: Initialize
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.onSuffixIconTap,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.showCounter = false,
    this.autofocus = false,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.fillColor,
    this.labelColor,
    this.hintColor,
    this.errorColor,
    this.borderColor,
    this.focusedBorderColor,
    this.iconColor,
    this.prefixIconColor,
    this.suffixIconColor,
    this.backgroundColor,
    this.contentPadding,
    this.textInputAction,
    this.onEditingComplete,
    this.onSubmitted,
    this.size = SltTextFieldSize.medium,
  });

  @override
  State<SltTextField> createState() => _SltTextFieldState();

  factory SltTextField.search({
    TextEditingController? controller,
    String? initialValue, // <<--- ADDED
    String? hint = 'Search...',
    ValueChanged<String>? onChanged,
    VoidCallback? onClear,
    FocusNode? focusNode,
    SltTextFieldSize size = SltTextFieldSize.medium,
    Color? fillColor,
  }) {
    return SltTextField(
      controller: controller,
      initialValue: initialValue,
      hint: hint,
      prefixIcon: Icons.search,
      keyboardType: TextInputType.text,
      onChanged: onChanged,
      focusNode: focusNode,
      size: size,
      fillColor: fillColor,
      suffixIcon: Icons.clear,
      onSuffixIconTap: onClear,
    );
  }

  factory SltTextField.number({
    TextEditingController? controller,
    String? initialValue, // <<--- ADDED
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    int? maxLength,
    bool allowDecimal = false,
  }) {
    return SltTextField(
      controller: controller,
      initialValue: initialValue,
      label: label,
      hint: hint,
      keyboardType: allowDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      inputFormatters: [
        if (!allowDecimal) FilteringTextInputFormatter.digitsOnly,
        if (allowDecimal)
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
      ],
      onChanged: onChanged,
      validator: validator,
      maxLength: maxLength,
      prefixIcon: Icons.numbers,
    );
  }

  factory SltTextField.multiline({
    TextEditingController? controller,
    String? initialValue, // <<--- ADDED
    String? label,
    String? hint,
    int minLines = 3,
    int maxLines = 5,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return SltTextField(
      controller: controller,
      initialValue: initialValue,
      label: label,
      hint: hint,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: TextInputType.multiline,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class _SltTextFieldState extends State<SltTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _passwordVisible = false;
  bool _hasFocus = false;
  TextSelection? _previousSelection;
  String _previousText = '';

  EdgeInsetsGeometry _getEffectiveContentPadding() {
    if (widget.contentPadding != null) {
      return widget.contentPadding!;
    }

    switch (widget.size) {
      case SltTextFieldSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingM,
          vertical: AppDimens.paddingS + 2,
        );
      case SltTextFieldSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppDimens.paddingL,
          vertical: AppDimens.paddingL,
        );
    }
  }

  double _getEffectiveIconSize() {
    switch (widget.size) {
      case SltTextFieldSize.small:
        return AppDimens.iconS;
      case SltTextFieldSize.medium:
        return AppDimens.iconM;
    }
  }

  TextStyle _getEffectiveTextStyle(ThemeData theme, ColorScheme colorScheme) {
    TextStyle baseStyle = theme.textTheme.bodyLarge!;

    if (widget.size == SltTextFieldSize.small) {
      baseStyle =
          theme.textTheme.bodyMedium ??
          theme.textTheme.bodyLarge!.copyWith(fontSize: 14);
    }
    final disabledTextColor = colorScheme.onSurface.withValues(
      alpha: 0.38,
    ); // Standard disabled opacity

    return baseStyle.copyWith(
      color: widget.enabled ? colorScheme.onSurface : disabledTextColor,
    );
  }

  TextStyle _getEffectiveLabelStyle(ThemeData theme, ColorScheme colorScheme) {
    TextStyle baseStyle = theme.textTheme.bodyLarge!;
    Color defaultLabelColor = widget.labelColor ?? colorScheme.onSurfaceVariant;

    if (widget.size == SltTextFieldSize.small) {
      baseStyle =
          theme.textTheme.bodySmall ??
          theme.textTheme.bodyLarge!.copyWith(fontSize: 12);
    }

    if (widget.errorText != null && widget.errorText!.isNotEmpty) {
      defaultLabelColor = widget.errorColor ?? colorScheme.error;
    }

    return baseStyle.copyWith(color: defaultLabelColor);
  }

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    _focusNode = widget.focusNode ?? FocusNode();
    _previousText = _controller.text;
    _controller.addListener(_onControllerChanged);
    _focusNode.addListener(_onFocusChange);
    _passwordVisible = !widget.obscureText;
  }

  void _onControllerChanged() {
    if (!mounted) return;

    final currentText = _controller.text;
    final currentSelection = _controller.selection;

    if (currentText != _previousText &&
        currentText.isNotEmpty &&
        currentSelection.baseOffset == 0 &&
        currentSelection.extentOffset == 0 &&
        _previousSelection != null &&
        _previousSelection!.baseOffset != 0) {
      if (_previousText.isNotEmpty &&
          currentText.length == _previousText.length + 1 &&
          currentText.substring(1) == _previousText) {
        final charPrepended = currentText[0];
        final correctedText = _previousText + charPrepended;
        _controller.value = TextEditingValue(
          text: correctedText,
          selection: TextSelection.collapsed(offset: correctedText.length),
        );
      } else if (_previousSelection!.isValid &&
          _previousSelection!.baseOffset <= currentText.length) {}
    }

    _previousText = _controller.text;
    _previousSelection = _controller.selection;

    widget.onChanged?.call(currentText);
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
        if (_hasFocus) {
          _previousSelection = _controller.selection;
        }
      });
    }
  }

  @override
  void didUpdateWidget(SltTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.controller != oldWidget.controller) {
      _controller.removeListener(_onControllerChanged);
      if (oldWidget.controller == null) {
        _controller.dispose(); // Dispose internally created controller
      }
      _controller =
          widget.controller ?? TextEditingController(text: widget.initialValue);
      _previousText =
          _controller.text; // Update previous text for the new controller
      _controller.addListener(_onControllerChanged);
    } else if (widget.controller == null &&
        widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
      _previousText = _controller.text;
    }

    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_onFocusChange);
      if (oldWidget.focusNode == null) {
        _focusNode.dispose(); // Dispose internally created focus node
      }
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
      _hasFocus = _focusNode.hasFocus; // Update focus state
    }

    if (widget.obscureText != oldWidget.obscureText && !widget.obscureText) {
      _passwordVisible = true;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveIconSize = _getEffectiveIconSize();
    final currentContentPadding = _getEffectiveContentPadding();
    final currentTextStyle = _getEffectiveTextStyle(theme, colorScheme);
    final currentLabelStyle = _getEffectiveLabelStyle(theme, colorScheme);

    final Color defaultIconColor =
        widget.iconColor ?? colorScheme.onSurfaceVariant;
    final Color activeIconColor = widget.iconColor ?? colorScheme.primary;
    final Color errorStateIconColor = widget.errorColor ?? colorScheme.error;

    final bool hasError =
        widget.errorText != null && widget.errorText!.isNotEmpty;

    final Color currentPrefixIconColor =
        widget.prefixIconColor ??
        (hasError
            ? errorStateIconColor
            : (_hasFocus ? activeIconColor : defaultIconColor));

    Widget? finalSuffixWidget;

    if (widget.obscureText) {
      finalSuffixWidget = InkWell(
        onTap: () {
          if (!mounted) return;
          setState(() {
            _passwordVisible = !_passwordVisible;
          });
        },
        borderRadius: BorderRadius.circular(AppDimens.radiusXXL),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingS / 2),
          child: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color:
                widget.suffixIconColor ??
                (hasError
                    ? errorStateIconColor
                    : (_hasFocus ? activeIconColor : defaultIconColor)),
            size: effectiveIconSize,
          ),
        ),
      );
    } else if (widget.suffixIcon != null) {
      finalSuffixWidget = InkWell(
        onTap: widget.onSuffixIconTap, // Ensure onSuffixIconTap is used
        borderRadius: BorderRadius.circular(AppDimens.radiusXXL),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingS / 2),
          child: Icon(
            widget.suffixIcon,
            color:
                widget.suffixIconColor ??
                (hasError
                    ? errorStateIconColor
                    : (_hasFocus ? activeIconColor : defaultIconColor)),
            size: effectiveIconSize,
          ),
        ),
      );
    } else if (widget.suffix != null) {
      finalSuffixWidget = widget.suffix;
    }

    return Container(
      color: widget.backgroundColor ?? Colors.transparent,
      child: TextFormField(
        controller: _controller,
        focusNode: _focusNode,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        textAlign: widget.textAlign,
        readOnly: widget.readOnly,
        enabled: widget.enabled,
        obscureText: widget.obscureText && !_passwordVisible,
        maxLength: widget.maxLength,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        minLines: widget.minLines,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        inputFormatters: widget.inputFormatters,
        onEditingComplete: widget.onEditingComplete,
        onFieldSubmitted: widget.onSubmitted,
        autovalidateMode: widget.autovalidateMode,
        validator: widget.validator,
        style: currentTextStyle,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          errorText: widget.errorText,
          helperText: widget.helperText,
          filled: true,
          fillColor: widget.fillColor ?? colorScheme.surfaceContainerLowest,
          contentPadding: currentContentPadding,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: AppDimens.paddingM,
                    end: widget.size == SltTextFieldSize.small
                        ? AppDimens.paddingXS
                        : AppDimens.paddingS,
                  ),
                  child: Icon(
                    widget.prefixIcon,
                    color: currentPrefixIconColor,
                    size: effectiveIconSize,
                  ),
                )
              : widget.prefix,
          suffixIcon: finalSuffixWidget,
          counterText: widget.showCounter ? null : '',
          labelStyle: currentLabelStyle,
          hintStyle:
              (widget.size == SltTextFieldSize.small
                      ? theme.textTheme.bodyMedium
                      : theme.textTheme.bodyLarge)
                  ?.copyWith(
                    color:
                        widget.hintColor ??
                        colorScheme.onSurfaceVariant.withValues(
                          alpha: AppDimens.opacityHintText,
                        ), // Use opacity from Dimens
                  ),
          errorStyle: TextStyle(
            color: widget.errorColor ?? colorScheme.error,
            fontSize: widget.size == SltTextFieldSize.small
                ? AppDimens.fontS
                : AppDimens.fontBodyS, // Use AppDimens for font size
          ),
          helperStyle:
              (widget.size == SltTextFieldSize.small
                      ? theme
                            .textTheme
                            .labelSmall // Usually helper text is smaller
                      : theme.textTheme.bodySmall)
                  ?.copyWith(color: colorScheme.onSurfaceVariant),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            borderSide: BorderSide(
              color: widget.borderColor ?? colorScheme.outline,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            borderSide: BorderSide(
              color: widget.borderColor ?? colorScheme.outline,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            borderSide: BorderSide(
              color: widget.focusedBorderColor ?? colorScheme.primary,
              width: AppDimens.borderWidthFocused,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            borderSide: BorderSide(
              color: widget.errorColor ?? colorScheme.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            borderSide: BorderSide(
              color: widget.errorColor ?? colorScheme.error,
              width: AppDimens.borderWidthFocused,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            borderSide: BorderSide(
              color: (widget.borderColor ?? colorScheme.outline).withValues(
                alpha: AppDimens.opacityDisabledOutline,
              ), // Use opacity from Dimens
            ),
          ),
        ),
      ),
    );
  }
}

// lib/presentation/widgets/common/input/sl_text_field.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

// Define the enum for text field sizes
enum SltTextFieldSize {
  small,
  medium, // Default
}

class SltTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? errorText;
  final String? helperText;
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

  // Factory constructor for a search field
  factory SltTextField.search({
    TextEditingController? controller,
    String? hint = 'Search...',
    ValueChanged<String>? onChanged,
    VoidCallback? onClear,
    FocusNode? focusNode,
    SltTextFieldSize size = SltTextFieldSize.medium,
    Color? fillColor,
  }) {
    return SltTextField(
      controller: controller,
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

  // Factory constructor for a number field
  factory SltTextField.number({
    TextEditingController? controller,
    String? label,
    String? hint,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
    int? maxLength,
    bool allowDecimal = false,
  }) {
    return SltTextField(
      controller: controller,
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

  // Factory constructor for a multiline text field
  factory SltTextField.multiline({
    TextEditingController? controller,
    String? label,
    String? hint,
    int minLines = 3,
    int maxLines = 5,
    ValueChanged<String>? onChanged,
    String? Function(String?)? validator,
  }) {
    return SltTextField(
      controller: controller,
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

  // Biến để lưu trữ vị trí con trỏ hiện tại
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

    return baseStyle.copyWith(
      color: widget.enabled
          ? colorScheme.onSurface
          : colorScheme.onSurface.withOpacity(AppDimens.opacityDisabledText),
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

    if (widget.errorText != null) {
      defaultLabelColor = widget.errorColor ?? colorScheme.error;
    }

    return baseStyle.copyWith(color: defaultLabelColor);
  }

  void _onControllerChanged() {
    // Nếu phát hiện vị trí con trỏ đã bị di chuyển đến index 0 một cách không mong muốn
    // và văn bản đã thay đổi, thì khôi phục lại vị trí con trỏ
    if (mounted && _controller.text != _previousText) {
      // Kiểm tra xem văn bản mới có phải là phần được chèn vào đầu không
      final currentText = _controller.text;
      final previousText = _previousText;

      if (currentText.length > previousText.length &&
          _controller.selection.baseOffset == 1 &&
          !currentText.startsWith(previousText) &&
          currentText.length - 1 == previousText.length) {
        // Có vẻ như một ký tự đã được chèn vào đầu văn bản
        // Ta cần di chuyển ký tự này đến cuối văn bản
        final insertedChar = currentText[0];
        final correctText = previousText + insertedChar;

        // Cập nhật controller text với vị trí con trỏ phù hợp
        _controller.value = TextEditingValue(
          text: correctText,
          selection: TextSelection.collapsed(offset: correctText.length),
        );
      }

      // Lưu lại văn bản hiện tại và vị trí con trỏ để kiểm tra ở lần thay đổi tiếp theo
      _previousText = _controller.text;
      _previousSelection = _controller.selection;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    // Lưu trữ giá trị text ban đầu
    _previousText = _controller.text;

    // Thêm listener theo dõi thay đổi trong controller
    _controller.addListener(_onControllerChanged);

    // Theo dõi trạng thái focus
    _focusNode.addListener(_onFocusChange);

    // Initialize password visibility based on obscureText
    _passwordVisible = !widget.obscureText;
  }

  void _onFocusChange() {
    if (mounted) {
      setState(() {
        _hasFocus = _focusNode.hasFocus;
        // Khi nhận focus, lưu lại vị trí con trỏ
        if (_hasFocus) {
          _previousSelection = _controller.selection;
        }
      });
    }
  }

  @override
  void didUpdateWidget(SltTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle controller changes
    if (widget.controller != oldWidget.controller) {
      // Remove listener from old controller
      _controller.removeListener(_onControllerChanged);

      if (oldWidget.controller == null) {
        // We created the controller, so we need to dispose it
        _controller.dispose();
      }

      // Use the new controller or create one
      _controller = widget.controller ?? TextEditingController();

      // Update previous text and add listener to new controller
      _previousText = _controller.text;
      _controller.addListener(_onControllerChanged);
    }

    // Handle focus node changes
    if (widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.focusNode == null) {
        // We created the focus node, so we need to remove listener and dispose
        _focusNode.removeListener(_onFocusChange);
        _focusNode.dispose();
      }

      // Use the new focus node or create one
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_onFocusChange);
      _hasFocus = _focusNode.hasFocus;
    }

    // Update password visibility if obscureText changed
    if (widget.obscureText != oldWidget.obscureText && !widget.obscureText) {
      _passwordVisible = true;
    }
  }

  @override
  void dispose() {
    // Remove controller listener
    _controller.removeListener(_onControllerChanged);

    // Only dispose controller if we created it
    if (widget.controller == null) {
      _controller.dispose();
    }

    // Only dispose focus node if we created it
    if (widget.focusNode == null) {
      _focusNode.removeListener(_onFocusChange);
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

    final Color currentPrefixIconColor =
        widget.prefixIconColor ??
        (widget.errorText != null
            ? errorStateIconColor
            : (_hasFocus ? activeIconColor : defaultIconColor));

    final Color currentSuffixIconColor =
        widget.suffixIconColor ??
        (widget.errorText != null
            ? errorStateIconColor
            : (_hasFocus ? activeIconColor : defaultIconColor));

    Widget? finalSuffixIconWidget;

    if (widget.suffixIcon != null) {
      finalSuffixIconWidget = InkWell(
        onTap: widget.onSuffixIconTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusXXL),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingS / 2),
          child: Icon(
            widget.suffixIcon,
            color:
                widget.suffixIconColor ??
                (widget.errorText != null
                    ? errorStateIconColor
                    : _hasFocus
                    ? activeIconColor
                    : defaultIconColor),
            size: effectiveIconSize,
          ),
        ),
      );
    }

    if (widget.obscureText) {
      finalSuffixIconWidget = InkWell(
        onTap: () {
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
                (widget.errorText != null
                    ? errorStateIconColor
                    : _hasFocus
                    ? activeIconColor
                    : defaultIconColor),
            size: effectiveIconSize,
          ),
        ),
      );
    }

    if (widget.suffix != null) {
      finalSuffixIconWidget = widget.suffix;
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
        onChanged: (value) {
          // Lưu lại vị trí con trỏ sau khi text thay đổi
          _previousSelection = _controller.selection;

          // Gọi callback onChanged của widget nếu có
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        onTap: () {
          // Lưu vị trí con trỏ khi người dùng tap
          _previousSelection = _controller.selection;

          // Gọi callback onTap của widget nếu có
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
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
          suffixIcon: finalSuffixIconWidget,
          counterText: widget.showCounter ? null : '',
          labelStyle: currentLabelStyle,
          hintStyle:
              (widget.size == SltTextFieldSize.small
                      ? theme.textTheme.bodyMedium
                      : theme.textTheme.bodyLarge)
                  ?.copyWith(
                    color:
                        widget.hintColor ??
                        colorScheme.onSurfaceVariant.withOpacity(
                          AppDimens.opacityHintText,
                        ),
                  ),
          errorStyle: TextStyle(
            color: widget.errorColor ?? colorScheme.error,
            fontSize: widget.size == SltTextFieldSize.small
                ? AppDimens.fontMicro
                : null,
          ),
          helperStyle:
              (widget.size == SltTextFieldSize.small
                      ? theme.textTheme.bodySmall
                      : theme.textTheme.bodyMedium)
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
              color: (widget.borderColor ?? colorScheme.outline).withOpacity(
                AppDimens.opacityDisabledOutline,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

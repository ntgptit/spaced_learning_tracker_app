import 'package:flutter/material.dart';

import '../../../core/theme/app_dimens.dart';

/// Secondary button widget
/// Used for secondary actions, often as a cancel or alternative action
class SltSecondaryButton extends StatelessWidget {
  /// Button text
  final String text;

  /// Callback function when button is pressed
  final VoidCallback? onPressed;

  /// Leading icon
  final IconData? icon;

  /// Button width (null for auto width)
  final double? width;

  /// Button height
  final double height;

  /// Text style
  final TextStyle? textStyle;

  /// Button border color
  final Color? borderColor;

  /// Button background color
  final Color? backgroundColor;

  /// Button foreground/text color
  final Color? foregroundColor;

  /// Button border radius
  final double borderRadius;

  /// Padding inside the button
  final EdgeInsetsGeometry padding;

  /// Border width
  final double borderWidth;

  /// Whether the button expands to fill width
  final bool expandToFillWidth;

  /// Whether the button is a loading state
  final bool isLoading;

  /// Whether the button is enabled
  final bool isEnabled;

  /// Whether to show an icon after the text instead of before
  final bool trailingIcon;

  /// Gap between icon and text
  final double iconGap;

  const SltSecondaryButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.width,
    this.height = AppDimens.buttonHeightM,
    this.textStyle,
    this.borderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius = AppDimens.radiusM,
    this.padding = AppDimens.buttonPadding,
    this.borderWidth = 1.0,
    this.expandToFillWidth = false,
    this.isLoading = false,
    this.isEnabled = true,
    this.trailingIcon = false,
    this.iconGap = AppDimens.gapS,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonStyle = OutlinedButton.styleFrom(
      foregroundColor: foregroundColor ?? theme.colorScheme.primary,
      backgroundColor: backgroundColor ?? Colors.transparent,
      padding: padding,
      side: BorderSide(
        color: borderColor ?? theme.colorScheme.primary,
        width: borderWidth,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      minimumSize: Size(expandToFillWidth ? double.infinity : 88, height),
      fixedSize: width != null ? Size(width!, height) : null,
      maximumSize: expandToFillWidth ? Size.fromHeight(height) : null,
    );

    final textStyleToUse = textStyle ??
        theme.textTheme.labelLarge?.copyWith(
          color: foregroundColor ?? theme.colorScheme.primary,
        );

    final buttonContent = isLoading
        ? _buildLoadingContent(context)
        : _buildButtonContent(context, textStyleToUse);

    return OutlinedButton(
      onPressed: (isEnabled && !isLoading) ? onPressed : null,
      style: buttonStyle,
      child: buttonContent,
    );
  }

  /// Build the button content with text and icon
  Widget _buildButtonContent(BuildContext context, TextStyle? textStyle) {
    if (icon == null) {
      return Text(
        text,
        style: textStyle,
        textAlign: TextAlign.center,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: trailingIcon
          ? _buildTrailingIconContent(textStyle)
          : _buildLeadingIconContent(textStyle),
    );
  }

  /// Build content with leading icon
  List<Widget> _buildLeadingIconContent(TextStyle? textStyle) {
    return [
      Icon(icon, size: textStyle?.fontSize ?? 18.0),
      SizedBox(width: iconGap),
      Text(text, style: textStyle),
    ];
  }

  /// Build content with trailing icon
  List<Widget> _buildTrailingIconContent(TextStyle? textStyle) {
    return [
      Text(text, style: textStyle),
      SizedBox(width: iconGap),
      Icon(icon, size: textStyle?.fontSize ?? 18.0),
    ];
  }

  /// Build loading indicator
  Widget _buildLoadingContent(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: textStyle?.fontSize ?? 18.0,
      width: textStyle?.fontSize ?? 18.0,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          foregroundColor ?? theme.colorScheme.primary,
        ),
      ),
    );
  }
}

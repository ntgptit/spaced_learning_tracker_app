import 'package:flutter/material.dart';

/// App bar widget
/// A customizable app bar for the app
class SltAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title text
  final String title;

  /// Leading widget
  final Widget? leading;

  /// List of action widgets
  final List<Widget>? actions;

  /// Whether to show the back button
  final bool showBackButton;

  /// Whether the app bar is centered
  final bool centerTitle;

  /// App bar elevation
  final double elevation;

  /// Background color
  final Color? backgroundColor;

  /// Foreground color (text and icons)
  final Color? foregroundColor;

  /// Title style
  final TextStyle? titleStyle;

  /// Bottom widget
  final PreferredSizeWidget? bottom;

  /// Custom height of the app bar
  final double? height;

  /// OnTap callback for the back button
  final VoidCallback? onBackPressed;

  /// Whether to allow going back with system back button/gesture
  final bool allowSystemBack;

  const SltAppBar({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.showBackButton = false,
    this.centerTitle = true,
    this.elevation = 0,
    this.backgroundColor,
    this.foregroundColor,
    this.titleStyle,
    this.bottom,
    this.height,
    this.onBackPressed,
    this.allowSystemBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget = leading;

    if (leadingWidget == null && showBackButton) {
      leadingWidget = IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: onBackPressed ??
            () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
      );
    }

    final appBar = AppBar(
      title: Text(
        title,
        style: titleStyle,
      ),
      leading: leadingWidget,
      actions: actions,
      centerTitle: centerTitle,
      elevation: elevation,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      automaticallyImplyLeading: false,
      bottom: bottom,
    );

    if (allowSystemBack || !showBackButton) {
      return appBar;
    }

    // Prevent system back gesture/button if not allowed
    // Using PopScope instead of WillPopScope (which is deprecated)
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          onBackPressed?.call();
        }
      },
      child: appBar,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        height ??
            (bottom != null
                ? kToolbarHeight + bottom!.preferredSize.height
                : kToolbarHeight),
      );
}

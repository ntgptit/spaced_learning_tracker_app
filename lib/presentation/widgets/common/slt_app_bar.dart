// lib/presentation/widgets/common/slt_app_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

/// A modern, customizable app bar that follows Material 3 design principles
/// Features include leading button customization, actions, flexible title styling,
/// and support for various configurations like search mode or transparent mode
class SltAppBar extends ConsumerWidget implements PreferredSizeWidget {
  /// Title text or widget
  final dynamic title;

  /// Leading widget - overrides the default back button
  final Widget? leading;

  /// List of action widgets displayed on the right side
  final List<Widget>? actions;

  /// Whether to show the back button when applicable
  final bool showBackButton;

  /// Whether the title should be centered
  final bool centerTitle;

  /// App bar elevation
  final double elevation;

  /// Background color - defaults to theme's primary color
  final Color? backgroundColor;

  /// Foreground color (text and icons)
  final Color? foregroundColor;

  /// Title style - overrides the default theme title style
  final TextStyle? titleStyle;

  /// Bottom widget (e.g. TabBar)
  final PreferredSizeWidget? bottom;

  /// Custom height - defaults to kToolbarHeight plus bottom height if present
  final double? height;

  /// OnTap callback for the back button
  final VoidCallback? onBackPressed;

  /// Whether to allow going back with system back button/gesture
  final bool allowSystemBack;

  /// Whether to use a transparent background with no elevation
  final bool transparent;

  /// Whether to use a prominent height for the app bar
  final bool prominent;

  /// Whether this app bar is in search mode
  final bool isSearchMode;

  /// Whether to hide the top safe area padding
  final bool hideTopPadding;

  /// System overlay style to apply
  final SystemUiOverlayStyle? systemOverlayStyle;

  const SltAppBar({
    super.key,
    this.title,
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
    this.transparent = false,
    this.prominent = false,
    this.isSearchMode = false,
    this.hideTopPadding = false,
    this.systemOverlayStyle,
  });

  // Factory constructor for a search app bar
  factory SltAppBar.search({
    Key? key,
    required Widget searchField,
    VoidCallback? onBackPressed,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
    bool allowSystemBack = true,
    SystemUiOverlayStyle? systemOverlayStyle,
  }) {
    return SltAppBar(
      key: key,
      title: searchField,
      showBackButton: true,
      onBackPressed: onBackPressed,
      actions: actions,
      bottom: bottom,
      isSearchMode: true,
      allowSystemBack: allowSystemBack,
      systemOverlayStyle: systemOverlayStyle,
    );
  }

  // Factory constructor for a transparent app bar
  factory SltAppBar.transparent({
    Key? key,
    dynamic title,
    Widget? leading,
    List<Widget>? actions,
    bool showBackButton = true,
    bool centerTitle = true,
    Color? foregroundColor,
    VoidCallback? onBackPressed,
    SystemUiOverlayStyle? systemOverlayStyle,
  }) {
    return SltAppBar(
      key: key,
      title: title,
      leading: leading,
      actions: actions,
      showBackButton: showBackButton,
      centerTitle: centerTitle,
      foregroundColor: foregroundColor ?? Colors.white,
      onBackPressed: onBackPressed,
      transparent: true,
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.light,
    );
  }

  // Factory constructor for a prominent app bar with larger height
  factory SltAppBar.prominent({
    Key? key,
    dynamic title,
    Widget? leading,
    List<Widget>? actions,
    bool showBackButton = false,
    bool centerTitle = false,
    Color? backgroundColor,
    Color? foregroundColor,
    TextStyle? titleStyle,
    PreferredSizeWidget? bottom,
  }) {
    return SltAppBar(
      key: key,
      title: title,
      leading: leading,
      actions: actions,
      showBackButton: showBackButton,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      titleStyle: titleStyle,
      bottom: bottom,
      prominent: true,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine effective background color
    final effectiveBackgroundColor = _getEffectiveBackgroundColor(colorScheme);

    // Determine effective foreground color
    final effectiveForegroundColor = _getEffectiveForegroundColor(colorScheme);

    // Calculate title padding based on search mode
    final double titleSpacing = isSearchMode
        ? 0.0
        : NavigationToolbar.kMiddleSpacing;

    // Create title widget based on provided title type
    final Widget titleWidget = _buildTitleWidget(context, theme);

    // Create leading widget based on configuration
    final Widget? leadingWidget = _buildLeadingWidget(context);

    // Create app bar
    final appBar = AppBar(
      title: titleWidget,
      leading: leadingWidget,
      actions: actions,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      elevation: transparent ? 0 : elevation,
      scrolledUnderElevation: transparent ? 0 : AppDimens.elevationXS,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      automaticallyImplyLeading: false,
      bottom: bottom,
      systemOverlayStyle: systemOverlayStyle,
      surfaceTintColor: transparent ? Colors.transparent : null,
      shadowColor: transparent ? Colors.transparent : null,
      toolbarHeight: _getToolbarHeight(),
    );

    // If system back is not allowed and we have a back button,
    // wrap with PopScope to handle back gestures
    if (!allowSystemBack && showBackButton) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (!didPop) {
            onBackPressed?.call();
          }
        },
        child: appBar,
      );
    }

    return appBar;
  }

  // Get effective background color based on configuration
  Color _getEffectiveBackgroundColor(ColorScheme colorScheme) {
    if (transparent) {
      return Colors.transparent;
    }

    return backgroundColor ?? colorScheme.surface;
  }

  // Get effective foreground color based on configuration
  Color _getEffectiveForegroundColor(ColorScheme colorScheme) {
    if (transparent) {
      return foregroundColor ?? Colors.white;
    }

    return foregroundColor ?? colorScheme.onSurface;
  }

  // Get toolbar height based on configuration
  double _getToolbarHeight() {
    if (prominent) {
      return kToolbarHeight * 1.5;
    }

    return height ?? kToolbarHeight;
  }

  // Build title widget based on provided title type
  Widget _buildTitleWidget(BuildContext context, ThemeData theme) {
    // Handle case where title is a widget
    if (title is Widget) {
      return title;
    }

    // Handle case where title is a string
    if (title is String) {
      final effectiveTitleStyle =
          titleStyle ??
          (prominent
              ? theme.textTheme.headlineSmall
              : theme.textTheme.titleLarge);

      return Text(
        title,
        style: effectiveTitleStyle,
        overflow: TextOverflow.ellipsis,
      );
    }

    // Handle case where title is null
    return const SizedBox.shrink();
  }

  // Build leading widget based on configuration
  Widget? _buildLeadingWidget(BuildContext context) {
    // Use custom leading widget if provided
    if (leading != null) {
      return leading;
    }

    // Show back button if requested
    if (showBackButton) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed:
            onBackPressed ??
            () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
        tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      );
    }

    // No leading widget
    return null;
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    final appBarHeight = height ?? kToolbarHeight;
    return Size.fromHeight(appBarHeight + bottomHeight);
  }
}

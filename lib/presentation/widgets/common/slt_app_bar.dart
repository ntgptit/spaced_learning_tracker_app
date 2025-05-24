import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final dynamic title;

  final Widget? leading;

  final List<Widget>? actions;

  final bool showBackButton;

  final bool centerTitle;

  final double elevation;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final TextStyle? titleStyle;

  final PreferredSizeWidget? bottom;

  final double? height;

  final VoidCallback? onBackPressed;

  final bool allowSystemBack;

  final bool transparent;

  final bool prominent;

  final bool isSearchMode;

  final bool hideTopPadding;

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

    final effectiveBackgroundColor = _getEffectiveBackgroundColor(colorScheme);

    final effectiveForegroundColor = _getEffectiveForegroundColor(colorScheme);

    final double titleSpacing = isSearchMode
        ? 0.0
        : NavigationToolbar.kMiddleSpacing;

    final Widget titleWidget = _buildTitleWidget(context, theme);

    final Widget? leadingWidget = _buildLeadingWidget(context);

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

  Color _getEffectiveBackgroundColor(ColorScheme colorScheme) {
    if (transparent) {
      return Colors.transparent;
    }

    return backgroundColor ?? colorScheme.surface;
  }

  Color _getEffectiveForegroundColor(ColorScheme colorScheme) {
    if (transparent) {
      return foregroundColor ?? Colors.white;
    }

    return foregroundColor ?? colorScheme.onSurface;
  }

  double _getToolbarHeight() {
    if (prominent) {
      return kToolbarHeight * 1.5;
    }

    return height ?? kToolbarHeight;
  }

  Widget _buildTitleWidget(BuildContext context, ThemeData theme) {
    if (title is Widget) {
      return title;
    }

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

    return const SizedBox.shrink();
  }

  Widget? _buildLeadingWidget(BuildContext context) {
    if (leading != null) {
      return leading;
    }

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

    return null;
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    final appBarHeight = height ?? kToolbarHeight;
    return Size.fromHeight(appBarHeight + bottomHeight);
  }
}

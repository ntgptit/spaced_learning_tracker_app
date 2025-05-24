import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

import '../buttons/slt_dialog_button_bar.dart';
import '../buttons/slt_primary_button.dart';

class SltFullScreenDialog extends ConsumerWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final VoidCallback? onClose; // If null, a default pop action is used
  final bool showAppBar; // Control AppBar visibility
  final Color? backgroundColor;
  final IconData? leadingIcon; // For AppBar leading
  final VoidCallback? onLeadingIconPressed;
  final List<Widget>? appBarActions; // Actions for AppBar
  final bool showAppBarDivider;
  final bool useSafeArea;
  final bool resizeToAvoidBottomInset;
  final bool centerTitle;
  final Widget? floatingActionButton;
  final EdgeInsetsGeometry bodyPadding; // Renamed for clarity
  final PreferredSizeWidget? customAppBar; // Allow custom AppBar

  const SltFullScreenDialog({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.onClose,
    this.showAppBar = true,
    this.backgroundColor,
    this.leadingIcon = Icons.close_rounded, // Default to close icon
    this.onLeadingIconPressed,
    this.appBarActions,
    this.showAppBarDivider = true,
    this.useSafeArea = true, // Default to true
    this.resizeToAvoidBottomInset = true,
    this.centerTitle = false, // M3 often starts titles from left
    this.floatingActionButton,
    this.bodyPadding = const EdgeInsets.all(AppDimens.paddingL),
    this.customAppBar,
  });

  factory SltFullScreenDialog.info({
    required String title,
    required Widget contentBody,
    String closeButtonText = 'Done',
    VoidCallback? onCloseAction,
  }) {
    return SltFullScreenDialog(
      title: title,
      body: contentBody,
      actions: [
        SltPrimaryButton(
          text: closeButtonText,
          onPressed: onCloseAction ?? () {}, // Handle in show method
        ),
      ],
      centerTitle: true,
    );
  }

  factory SltFullScreenDialog.form({
    required String title,
    required Widget formBody,
    required List<Widget> formActions, // e.g., Save, Cancel buttons
    bool resizeToAvoidBottomInset = true,
    IconData leadingIcon = Icons.arrow_back_rounded, // Back arrow for forms
  }) {
    return SltFullScreenDialog(
      title: title,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        child: formBody,
      ),
      actions: formActions,
      leadingIcon: leadingIcon,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      showAppBarDivider: true,
    );
  }

  factory SltFullScreenDialog.detail({
    required String title,
    required Widget detailBody,
    List<Widget>? appBarActions, // Actions specific to the detail view
    IconData leadingIcon = Icons.arrow_back_rounded,
  }) {
    return SltFullScreenDialog(
      title: title,
      body: detailBody,
      appBarActions: appBarActions,
      leadingIcon: leadingIcon,
      centerTitle: false, // Titles often start left in detail views
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBackgroundColor =
        backgroundColor ?? colorScheme.surface; // M3 surface

    final Widget mainBody = Column(
      children: [
        if (showAppBarDivider && showAppBar && customAppBar == null)
          const Divider(height: 1, thickness: 1),
        Expanded(
          child: Padding(padding: bodyPadding, child: body),
        ),
        if (actions != null && actions!.isNotEmpty)
          _buildActionsBar(context, theme, colorScheme),
      ],
    );

    return Scaffold(
      appBar: _buildAppBar(
        context,
        theme,
        colorScheme,
        effectiveBackgroundColor,
      ),
      body: useSafeArea ? SafeArea(child: mainBody) : mainBody,
      backgroundColor: effectiveBackgroundColor,
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  Widget _buildActionsBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: AppDimens.elevationS, // 2.0
            offset: const Offset(0, -1), // Shadow above
          ),
        ],
      ),
      padding: EdgeInsets.only(
        left: AppDimens.paddingL,
        right: AppDimens.paddingL,
        top: AppDimens.paddingS,
        bottom:
            AppDimens.paddingM +
            (useSafeArea ? MediaQuery.of(context).padding.bottom : 0),
      ),
      child: SltDialogButtonBar(
        alignment: MainAxisAlignment.end,
        spacing: AppDimens.spaceM,
        buttons: actions ?? [],
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    Color effectiveBackgroundColor,
  ) {
    if (!showAppBar) {
      return null;
    }

    return customAppBar ??
        AppBar(
          title: Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          centerTitle: centerTitle,
          leading: IconButton(
            icon: Icon(leadingIcon, color: colorScheme.onSurfaceVariant),
            onPressed:
                onLeadingIconPressed ??
                onClose ??
                () => Navigator.of(context).pop(),
            tooltip: 'Close',
          ),
          actions: appBarActions,
          backgroundColor: effectiveBackgroundColor,
          elevation: 0,
          surfaceTintColor: Colors.transparent, // M3
        );
  }

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required Widget body,
    List<Widget>? actions,
    VoidCallback? onClose,
    bool showAppBar = true,
    Color? backgroundColor,
    IconData? leadingIcon = Icons.close_rounded,
    VoidCallback? onLeadingIconPressed,
    List<Widget>? appBarActions,
    bool showAppBarDivider = true,
    bool useSafeArea = true,
    bool resizeToAvoidBottomInset = true,
    bool centerTitle = false,
    Widget? floatingActionButton,
    EdgeInsetsGeometry? bodyPadding,
    PreferredSizeWidget? customAppBar,
  }) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute<T>(
        fullscreenDialog: true, // This makes it a full-screen dialog route
        builder: (BuildContext context) => SltFullScreenDialog(
          title: title,
          body: body,
          actions: actions,
          onClose: onClose,
          showAppBar: showAppBar,
          backgroundColor: backgroundColor,
          leadingIcon: leadingIcon,
          onLeadingIconPressed: onLeadingIconPressed,
          appBarActions: appBarActions,
          showAppBarDivider: showAppBarDivider,
          useSafeArea: useSafeArea,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          centerTitle: centerTitle,
          floatingActionButton: floatingActionButton,
          bodyPadding: bodyPadding ?? const EdgeInsets.all(AppDimens.paddingL),
          customAppBar: customAppBar,
        ),
      ),
    );
  }
}

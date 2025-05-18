// lib/presentation/widgets/common/slt_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

/// A custom scaffold widget that provides a consistent look and feel across the app
/// with additional features like bottom bar integration, loading state handling,
/// and proper safe area configuration.
class SltScaffold extends StatelessWidget {
  /// The primary content of the scaffold
  final Widget body;

  /// Optional app bar for the scaffold
  final PreferredSizeWidget? appBar;

  /// Optional floating action button
  final Widget? floatingActionButton;

  /// Optional bottom navigation bar
  final Widget? bottomNavigationBar;

  /// Optional drawer widget
  final Widget? drawer;

  /// Optional endDrawer widget (drawer that opens from the right)
  final Widget? endDrawer;

  /// Background color for the scaffold
  final Color? backgroundColor;

  /// System overlay style (status bar and navigation bar settings)
  final SystemUiOverlayStyle? systemOverlayStyle;

  /// Whether to resize the scaffold when the keyboard appears
  final bool resizeToAvoidBottomInset;

  /// Whether to show a loading indicator
  final bool isLoading;

  /// Message to display while loading
  final String? loadingMessage;

  /// Whether to use safe area for the body
  final bool useSafeArea;

  /// Whether to include bottom padding in safe area
  final bool includeBottomSafeArea;

  /// Whether to extendBodyBehindAppBar
  final bool extendBodyBehindAppBar;

  /// Whether to extend the body below the bottom navigation bar
  final bool extendBody;

  /// Custom loading widget to show when isLoading is true
  final Widget? loadingWidget;

  /// Optional global key for the scaffold
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// Optional background color for the loading overlay
  final Color? loadingOverlayColor;

  /// Optional FloatingActionButtonLocation
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Optional FloatingActionButtonAnimator
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// Optional persistent footer buttons
  final List<Widget>? persistentFooterButtons;

  /// Optional bottom sheet to display
  final Widget? bottomSheet;

  /// Optional primary flag
  final bool? primary;

  /// Optional drawerScrimColor for drawer
  final Color? drawerScrimColor;

  /// Optional drawerEdgeDragWidth
  final double? drawerEdgeDragWidth;

  /// Optional drawerEnableOpenDragGesture
  final bool drawerEnableOpenDragGesture;

  /// Optional endDrawerEnableOpenDragGesture
  final bool endDrawerEnableOpenDragGesture;

  /// Create a custom scaffold with consistent styling and additional features
  const SltScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.resizeToAvoidBottomInset = true,
    this.isLoading = false,
    this.loadingMessage,
    this.useSafeArea = true,
    this.includeBottomSafeArea = true,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    this.loadingWidget,
    this.scaffoldKey,
    this.loadingOverlayColor,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.bottomSheet,
    this.primary,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Define the main scaffold body content
    Widget content = body;

    // Apply safe area if required
    if (useSafeArea) {
      content = SafeArea(bottom: includeBottomSafeArea, child: content);
    }

    // Create the scaffold with standard and custom properties
    Widget scaffold = Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: content,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor ?? theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
      persistentFooterButtons: persistentFooterButtons,
      bottomSheet: bottomSheet,
      primary: primary ?? true,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
    );

    // If loading, show a loading overlay
    if (isLoading) {
      scaffold = Stack(
        children: [
          scaffold,
          // Loading overlay
          ModalBarrier(
            dismissible: false,
            color: loadingOverlayColor ?? Colors.black.withValues(alpha: 0.3),
          ),
          // Loading indicator
          Center(child: loadingWidget ?? _buildDefaultLoadingWidget()),
        ],
      );
    }

    // Apply system UI overlay style if provided
    return systemOverlayStyle != null
        ? AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemOverlayStyle!,
            child: scaffold,
          )
        : scaffold;
  }

  /// Creates a default loading widget with a circular progress indicator
  Widget _buildDefaultLoadingWidget() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (loadingMessage != null) ...[
            const SizedBox(height: AppDimens.spaceM),
            Text(
              loadingMessage!,
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}

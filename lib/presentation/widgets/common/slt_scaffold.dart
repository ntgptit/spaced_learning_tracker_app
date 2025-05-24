import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';

class SltScaffold extends StatelessWidget {
  final Widget body;

  final PreferredSizeWidget? appBar;

  final Widget? floatingActionButton;

  final Widget? bottomNavigationBar;

  final Widget? drawer;

  final Widget? endDrawer;

  final Color? backgroundColor;

  final SystemUiOverlayStyle? systemOverlayStyle;

  final bool resizeToAvoidBottomInset;

  final bool isLoading;

  final String? loadingMessage;

  final bool useSafeArea;

  final bool includeBottomSafeArea;

  final bool extendBodyBehindAppBar;

  final bool extendBody;

  final Widget? loadingWidget;

  final GlobalKey<ScaffoldState>? scaffoldKey;

  final Color? loadingOverlayColor;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  final List<Widget>? persistentFooterButtons;

  final Widget? bottomSheet;

  final bool? primary;

  final Color? drawerScrimColor;

  final double? drawerEdgeDragWidth;

  final bool drawerEnableOpenDragGesture;

  final bool endDrawerEnableOpenDragGesture;

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

    Widget content = body;

    if (useSafeArea) {
      content = SafeArea(bottom: includeBottomSafeArea, child: content);
    }

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

    if (isLoading) {
      scaffold = Stack(
        children: [
          scaffold,
          ModalBarrier(
            dismissible: false,
            color: loadingOverlayColor ?? Colors.black.withValues(alpha: 0.3),
          ),
          Center(child: loadingWidget ?? _buildDefaultLoadingWidget()),
        ],
      );
    }

    return systemOverlayStyle != null
        ? AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemOverlayStyle!,
            child: scaffold,
          )
        : scaffold;
  }

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

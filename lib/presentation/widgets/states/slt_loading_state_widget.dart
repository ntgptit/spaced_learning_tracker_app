import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_dimens.dart';
import '../common/slt_app_bar.dart';

enum LoadingIndicatorType {
  circular,
  pulse,
  threeBounce,
  wave,
  fadingCircle,
  circularProgress,
}

enum SltLoadingSize { small, medium, large }

class SltLoadingStateWidget extends ConsumerWidget {
  final String? message;
  final LoadingIndicatorType type;
  final SltLoadingSize size;
  final Color? color;
  final bool fullScreen;
  final Widget? backgroundWidget;
  final bool dismissible;
  final VoidCallback? onDismiss;
  final bool showAppBar;
  final String? appBarTitle;

  const SltLoadingStateWidget({
    super.key,
    this.message,
    this.type = LoadingIndicatorType.threeBounce,
    this.size = SltLoadingSize.medium,
    this.color,
    this.fullScreen = false,
    this.backgroundWidget,
    this.dismissible = false,
    this.onDismiss,
    this.showAppBar = false,
    this.appBarTitle,
  });

  factory SltLoadingStateWidget.fullScreen({
    String? message,
    Color? color,
    LoadingIndicatorType type = LoadingIndicatorType.fadingCircle,
    Widget? background,
    bool dismissible = false,
    VoidCallback? onDismiss,
    bool showAppBar = false,
    String? appBarTitle,
  }) {
    return SltLoadingStateWidget(
      message: message,
      type: type,
      size: SltLoadingSize.large,
      color: color,
      fullScreen: true,
      backgroundWidget: background,
      dismissible: dismissible,
      onDismiss: onDismiss,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle,
    );
  }

  factory SltLoadingStateWidget.small({
    Color? color,
    LoadingIndicatorType type = LoadingIndicatorType.threeBounce,
  }) {
    return SltLoadingStateWidget(
      size: SltLoadingSize.small,
      type: type,
      color: color,
    );
  }

  factory SltLoadingStateWidget.withMessage(
    String message, {
    LoadingIndicatorType type = LoadingIndicatorType.threeBounce,
    Color? color,
    bool showAppBar = false,
    String? appBarTitle,
  }) {
    return SltLoadingStateWidget(
      message: message,
      type: type,
      color: color,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle,
    );
  }

  double _getSizeValue() {
    switch (size) {
      case SltLoadingSize.small:
        return AppDimens.circularProgressSize;
      case SltLoadingSize.medium:
        return AppDimens.circularProgressSizeL;
      case SltLoadingSize.large:
        return AppDimens.iconXXL;
    }
  }

  Widget _buildLoadingIndicator(double indicatorSize, Color indicatorColor) {
    switch (type) {
      case LoadingIndicatorType.circular:
        return SpinKitCircle(color: indicatorColor, size: indicatorSize);
      case LoadingIndicatorType.pulse:
        return SpinKitPulse(color: indicatorColor, size: indicatorSize);
      case LoadingIndicatorType.threeBounce:
        return FittedBox(
          child: SpinKitThreeBounce(
            color: indicatorColor,
            size: indicatorSize * 0.7,
          ),
        );
      case LoadingIndicatorType.wave:
        return SpinKitWave(color: indicatorColor, size: indicatorSize * 0.8);
      case LoadingIndicatorType.fadingCircle:
        return SpinKitFadingCircle(color: indicatorColor, size: indicatorSize);
      case LoadingIndicatorType.circularProgress:
        return SizedBox(
          width: indicatorSize,
          height: indicatorSize,
          child: CircularProgressIndicator(
            strokeWidth: indicatorSize / 10,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final indicatorColor = color ?? colorScheme.primary;
    final double actualIndicatorSize = _getSizeValue();

    final Widget loadingIndicator = _buildLoadingIndicator(
      actualIndicatorSize,
      indicatorColor,
    );

    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: actualIndicatorSize,
          height: actualIndicatorSize,
          child: loadingIndicator,
        ),
        if (message != null) ...[
          const SizedBox(height: AppDimens.spaceM),
          Text(
            message!,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    final Widget centeredContent = Center(child: content);

    if (showAppBar) {
      return Scaffold(
        appBar: SltAppBar(
          title: appBarTitle ?? 'Loading',
          showBackButton: dismissible,
          onBackPressed: () {
            if (onDismiss != null) {
              onDismiss!();
              return;
            }

            context.pop();
          },
          centerTitle: false,
        ),
        body: fullScreen
            ? Stack(
                children: [
                  backgroundWidget ??
                      Container(
                        color: colorScheme.surface.withValues(
                          alpha: AppDimens.opacityHigh,
                        ),
                      ),
                  centeredContent,
                ],
              )
            : centeredContent,
      );
    }

    if (!fullScreen) {
      return centeredContent;
    }

    return Stack(
      children: [
        backgroundWidget ??
            Container(
              color: colorScheme.surface.withValues(
                alpha: AppDimens.opacityHigh,
              ),
            ),
        centeredContent,
        if (dismissible && onDismiss != null)
          Positioned(
            top: AppDimens.paddingXL,
            right: AppDimens.paddingL,
            child: IconButton(
              icon: Icon(Icons.close, color: colorScheme.onSurface),
              onPressed: onDismiss,
              tooltip: 'Dismiss',
            ),
          ),
      ],
    );
  }
}

class SltLoadingIndicator extends ConsumerWidget {
  final double size;
  final Color? color;
  final LoadingIndicatorType type;

  const SltLoadingIndicator({
    super.key,
    this.size = AppDimens.circularProgressSizeL,
    this.color,
    this.type = LoadingIndicatorType.threeBounce,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final indicatorColor = color ?? colorScheme.primary;

    switch (type) {
      case LoadingIndicatorType.circular:
        return SpinKitCircle(color: indicatorColor, size: size);
      case LoadingIndicatorType.pulse:
        return SpinKitPulse(color: indicatorColor, size: size);
      case LoadingIndicatorType.threeBounce:
        return FittedBox(
          child: SpinKitThreeBounce(color: indicatorColor, size: size * 0.7),
        );
      case LoadingIndicatorType.wave:
        return SpinKitWave(color: indicatorColor, size: size * 0.8);
      case LoadingIndicatorType.fadingCircle:
        return SpinKitFadingCircle(color: indicatorColor, size: size);
      case LoadingIndicatorType.circularProgress:
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: size / 10,
            valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
          ),
        );
    }
  }
}

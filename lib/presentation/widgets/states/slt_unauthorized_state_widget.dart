import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_dimens.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';
import '../common/slt_app_bar.dart';

class SlUnauthorizedStateWidget extends ConsumerWidget {
  final String title;
  final String message;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonPressed;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonPressed;
  final bool showIcon;
  final IconData icon;
  final bool showAppBar;
  final String? appBarTitle;
  final VoidCallback? onNavigateBack;

  const SlUnauthorizedStateWidget({
    super.key,
    this.title = 'Access Denied',
    this.message = 'You don\'t have permission to access this content.',
    this.primaryButtonText = 'Login',
    required this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.showIcon = true,
    this.icon = Icons.lock_outline_rounded,
    this.showAppBar = false,
    this.appBarTitle,
    this.onNavigateBack,
  });

  factory SlUnauthorizedStateWidget.sessionExpired({
    Key? key,
    required VoidCallback onLoginAgain,
    String title = 'Session Expired',
    String message =
        'Your session has expired. Please log in again to continue.',
    bool showAppBar = false,
    String? appBarTitle,
  }) {
    return SlUnauthorizedStateWidget(
      key: key,
      title: title,
      message: message,
      primaryButtonText: 'Login Again',
      onPrimaryButtonPressed: onLoginAgain,
      icon: Icons.refresh_rounded,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
    );
  }

  factory SlUnauthorizedStateWidget.requiresLogin({
    Key? key,
    required VoidCallback onLogin,
    VoidCallback? onGoBack,
    String title = 'Login Required',
    String message = 'You need to be logged in to access this feature.',
    String primaryButtonText = 'Login',
    String? goBackButtonText = 'Go Back',
    bool showAppBar = false,
    String? appBarTitle,
  }) {
    return SlUnauthorizedStateWidget(
      key: key,
      title: title,
      message: message,
      primaryButtonText: primaryButtonText,
      onPrimaryButtonPressed: onLogin,
      secondaryButtonText: onGoBack != null ? goBackButtonText : null,
      onSecondaryButtonPressed: onGoBack,
      icon: Icons.login_rounded,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onGoBack,
    );
  }

  factory SlUnauthorizedStateWidget.insufficientPermissions({
    Key? key,
    VoidCallback? onRequestAccess,
    VoidCallback? onGoBack,
    String title = 'Access Restricted',
    String message =
        'You don\'t have sufficient permissions for this action or content.',
    String defaultPrimaryButtonText = 'Go Back',
    bool showAppBar = false,
    String? appBarTitle,
  }) {
    final bool canRequestAccess = onRequestAccess != null;
    final String effectivePrimaryText = canRequestAccess
        ? 'Request Access'
        : defaultPrimaryButtonText;
    final VoidCallback effectivePrimaryAction = canRequestAccess
        ? onRequestAccess
        : (onGoBack ?? () {});

    return SlUnauthorizedStateWidget(
      key: key,
      title: title,
      message: message,
      primaryButtonText: effectivePrimaryText,
      onPrimaryButtonPressed: effectivePrimaryAction,
      secondaryButtonText: canRequestAccess && onGoBack != null
          ? 'Go Back'
          : null,
      onSecondaryButtonPressed: canRequestAccess ? onGoBack : null,
      icon: Icons.gpp_maybe_outlined,
      showAppBar: showAppBar,
      appBarTitle: appBarTitle ?? title,
      onNavigateBack: onGoBack,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final iconContainerColor = colorScheme.secondaryContainer;
    final onIconContainerColor = colorScheme.onSecondaryContainer;

    Widget unauthorizedContent = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showIcon) ...[
          Container(
            width: AppDimens.iconXXL,
            height: AppDimens.iconXXL,
            decoration: BoxDecoration(
              color: iconContainerColor.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: AppDimens.iconXL,
              color: onIconContainerColor,
            ),
          ),
          const SizedBox(height: AppDimens.spaceXL),
        ],
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spaceM),
        Text(
          message,
          style: textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spaceXL),
        SltPrimaryButton(
          text: primaryButtonText,
          onPressed: onPrimaryButtonPressed,
        ),
        if (secondaryButtonText != null &&
            onSecondaryButtonPressed != null) ...[
          const SizedBox(height: AppDimens.spaceM),
          SltTextButton(
            text: secondaryButtonText!,
            onPressed: onSecondaryButtonPressed!,
          ),
        ],
        if (secondaryButtonText == null &&
            onSecondaryButtonPressed == null &&
            onNavigateBack != null &&
            !showAppBar) ...[
          const SizedBox(height: AppDimens.spaceM),
          SltTextButton(
            text: 'Go Back',
            onPressed: onNavigateBack!,
            foregroundColor: colorScheme.primary,
          ),
        ],
      ],
    );

    if (showAppBar) {
      return Scaffold(
        appBar: SltAppBar(
          title: appBarTitle ?? title,
          showBackButton: true,
          onBackPressed: () {
            if (onNavigateBack != null) {
              onNavigateBack!();
              return;
            }

            if (onSecondaryButtonPressed != null) {
              onSecondaryButtonPressed!();
              return;
            }

            context.pop();
          },
          centerTitle: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingXL),
            child: unauthorizedContent,
          ),
        ),
      );
    }

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingXL),
          child: unauthorizedContent,
        ),
      ),
    );
  }
}

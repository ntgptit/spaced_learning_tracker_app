import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_text_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_password_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_success_state_widget.dart';

import '../../../core/router/app_router.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String resetToken;

  const ResetPasswordScreen({super.key, required this.resetToken});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: AppDimens.durationMedium2),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: AppDimens.durationMedium4),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resetPasswordForm = ref.watch(resetPasswordFormStateProvider);
    final authState = ref.watch(authStateProvider);
    final authError = ref.watch(authErrorProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    if (authState.hasValue && authState.value == true && !authState.isLoading) {
      return SltSuccessStateWidget(
        title: 'Password Reset Successfully',
        message:
            'Your password has been reset successfully. You can now sign in with your new password.',
        primaryButtonText: 'Sign In Now',
        onPrimaryButtonPressed: () => context.go(AppRoutes.login),
        icon: Icons.check_circle_outline_rounded,
        accentColor: colorScheme.primary,
        showAppBar: true,
        appBarTitle: 'Password Reset Complete',
      );
    }

    return SltScaffold(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: colorScheme.surface,
        systemNavigationBarIconBrightness: theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      appBar: SltAppBar(
        title: '',
        backgroundColor: Colors.transparent,
        elevation: 0,
        showBackButton: true,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: theme.brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        ),
        onBackPressed: () => context.pop(),
      ),
      body: authState.isLoading
          ? const SltLoadingStateWidget(
              message: 'Resetting your password...',
              type: LoadingIndicatorType.fadingCircle,
            )
          : SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        size.height -
                        MediaQuery.of(context).padding.top -
                        kToolbarHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsivePadding.horizontal,
                      vertical: AppDimens.paddingL,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeroSection(context, theme, colorScheme),
                            SizedBox(height: AppDimens.spaceXXL),

                            if (authError != null) ...[
                              SltErrorStateWidget(
                                title: 'Reset Failed',
                                message: authError,
                                compact: true,
                                accentColor: colorScheme.error,
                              ),
                              SizedBox(height: AppDimens.spaceL),
                            ],

                            _buildPasswordForm(
                              context,
                              theme,
                              colorScheme,
                              resetPasswordForm,
                            ),
                            SizedBox(height: AppDimens.spaceL),

                            _buildPasswordRequirements(
                              context,
                              theme,
                              colorScheme,
                              resetPasswordForm,
                            ),
                            SizedBox(height: AppDimens.spaceXXL),

                            _buildActionButtons(context, theme, colorScheme),
                            SizedBox(height: AppDimens.spaceL),

                            _buildFooterLinks(context, theme, colorScheme),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Container(
          width: AppDimens.iconXXL * 1.3,
          height: AppDimens.iconXXL * 1.3,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.primary.withValues(alpha: 0.8),
                colorScheme.tertiary,
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: AppDimens.shadowRadiusL,
                offset: const Offset(0, AppDimens.shadowOffsetM),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_person_rounded,
            size: AppDimens.iconXL,
            color: Colors.white,
          ),
        ),
        SizedBox(height: AppDimens.spaceXL),

        Text(
          'Create New Password',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.spaceM),

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.paddingL,
            vertical: AppDimens.paddingM,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(AppDimens.radiusL),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Text(
            'Your new password must be different from your previous password and meet our security requirements.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordForm(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    ResetPasswordFormModel resetPasswordForm,
  ) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
            colorScheme.primaryContainer.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimens.paddingS),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimens.radiusM),
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: colorScheme.primary,
                  size: AppDimens.iconM,
                ),
              ),
              SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Password',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: AppDimens.spaceXS),
                    Text(
                      'Create a strong and secure password',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.spaceL),

          SltPasswordField(
            label: 'New Password',
            hint: 'Enter your new password',
            prefixIconData: Icons.lock_outline_rounded,
            errorText: resetPasswordForm.passwordError,
            onChanged: (value) => ref
                .read(resetPasswordFormStateProvider.notifier)
                .updatePassword(value),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: AppDimens.spaceL),

          SltPasswordField(
            label: 'Confirm New Password',
            hint: 'Confirm your new password',
            prefixIconData: Icons.lock_outline_rounded,
            errorText: resetPasswordForm.confirmPasswordError,
            onChanged: (value) => ref
                .read(resetPasswordFormStateProvider.notifier)
                .updateConfirmPassword(value),
            onEditingComplete: () => _handleResetPassword(context, ref),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirements(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    ResetPasswordFormModel resetPasswordForm,
  ) {
    final password = resetPasswordForm.password;

    return Container(
      padding: EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.tertiaryContainer.withValues(alpha: 0.3),
            colorScheme.secondaryContainer.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimens.paddingS),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimens.radiusS),
                ),
                child: Icon(
                  Icons.security_rounded,
                  color: colorScheme.tertiary,
                  size: AppDimens.iconM,
                ),
              ),
              SizedBox(width: AppDimens.spaceM),
              Text(
                'Password Requirements',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.tertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.spaceL),

          Wrap(
            spacing: AppDimens.spaceM,
            runSpacing: AppDimens.spaceM,
            children: [
              _buildRequirementChip(
                context,
                theme,
                colorScheme,
                'At least 8 characters',
                password.length >= 8,
              ),
              _buildRequirementChip(
                context,
                theme,
                colorScheme,
                'Uppercase letter',
                password.contains(RegExp(r'[A-Z]')),
              ),
              _buildRequirementChip(
                context,
                theme,
                colorScheme,
                'Lowercase letter',
                password.contains(RegExp(r'[a-z]')),
              ),
              _buildRequirementChip(
                context,
                theme,
                colorScheme,
                'Number',
                password.contains(RegExp(r'[0-9]')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementChip(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    String requirement,
    bool isMet,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.paddingM,
        vertical: AppDimens.paddingS,
      ),
      decoration: BoxDecoration(
        color: isMet
            ? colorScheme.primary.withValues(alpha: 0.1)
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(
          color: isMet
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: AppDimens.iconS,
            color: isMet ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
          SizedBox(width: AppDimens.spaceS),
          Text(
            requirement,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isMet ? colorScheme.primary : colorScheme.onSurfaceVariant,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return SltPrimaryButton(
      text: 'Reset Password',
      prefixIcon: Icons.lock_reset_rounded,
      isFullWidth: true,
      onPressed: () => _handleResetPassword(context, ref),
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: AppDimens.elevationS,
    );
  }

  Widget _buildFooterLinks(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Remember your password?',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        SltTextButton(
          text: 'Sign In',
          onPressed: () => context.go(AppRoutes.login),
          foregroundColor: colorScheme.primary,
        ),
      ],
    );
  }

  Future<void> _handleResetPassword(BuildContext context, WidgetRef ref) async {
    HapticFeedback.lightImpact();
    ref.read(authErrorProvider.notifier).clearError();
    final success = await ref
        .read(resetPasswordFormStateProvider.notifier)
        .submitResetPassword(widget.resetToken);

    if (success) {
      HapticFeedback.heavyImpact();
    }
  }
}

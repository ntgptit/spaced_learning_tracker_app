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
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_success_state_widget.dart';

import '../../../core/router/app_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen>
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
    final forgotPasswordForm = ref.watch(forgotPasswordFormStateProvider);
    final authState = ref.watch(authStateProvider);
    final authError = ref.watch(authErrorProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    if (forgotPasswordForm.isEmailSent) {
      return SltSuccessStateWidget(
        title: 'Reset Link Sent',
        message:
            'We\'ve sent a password reset link to ${forgotPasswordForm.email}. Please check your email and follow the instructions to reset your password.',
        primaryButtonText: 'Back to Login',
        onPrimaryButtonPressed: () => context.go(AppRoutes.login),
        secondaryButtonText: 'Resend Email',
        onSecondaryButtonPressed: () => _handleResendEmail(context, ref),
        icon: Icons.mark_email_read_rounded,
        accentColor: colorScheme.tertiary,
        showAppBar: true,
        appBarTitle: 'Password Reset',
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
              message: 'Sending reset email...',
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

                            _buildEmailForm(
                              context,
                              theme,
                              colorScheme,
                              forgotPasswordForm,
                            ),
                            SizedBox(height: AppDimens.spaceXXL),

                            _buildActionButtons(context, theme, colorScheme),
                            SizedBox(height: AppDimens.spaceL),

                            _buildFooterLinks(context, theme, colorScheme),
                            SizedBox(height: AppDimens.spaceXXL),

                            _buildHelpSection(context, theme, colorScheme),
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
                colorScheme.tertiary,
                colorScheme.tertiary.withValues(alpha: 0.8),
                colorScheme.primary,
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.tertiary.withValues(alpha: 0.3),
                blurRadius: AppDimens.shadowRadiusL,
                offset: const Offset(0, AppDimens.shadowOffsetM),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_reset_rounded,
            size: AppDimens.iconXL,
            color: Colors.white,
          ),
        ),
        SizedBox(height: AppDimens.spaceXL),

        Text(
          'Forgot Password?',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.spaceM),

        Text(
          'Don\'t worry! It happens to the best of us. Enter your email address and we\'ll send you a link to reset your password.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailForm(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    ForgotPasswordFormModel forgotPasswordForm,
  ) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
            colorScheme.tertiaryContainer.withValues(alpha: 0.2),
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
                  color: colorScheme.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimens.radiusM),
                ),
                child: Icon(
                  Icons.email_outlined,
                  color: colorScheme.tertiary,
                  size: AppDimens.iconM,
                ),
              ),
              SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Address',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.tertiary,
                      ),
                    ),
                    SizedBox(height: AppDimens.spaceXS),
                    Text(
                      'Enter the email associated with your account',
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

          SltTextField(
            label: 'Email Address',
            hint: 'Enter your email address',
            prefixIcon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            errorText: forgotPasswordForm.emailError,
            onChanged: (value) => ref
                .read(forgotPasswordFormStateProvider.notifier)
                .updateEmail(value),
            onSubmitted: (_) => _handleSendResetEmail(context, ref),
            textInputAction: TextInputAction.send,
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
      text: 'Send Reset Link',
      prefixIcon: Icons.send_rounded,
      isFullWidth: true,
      onPressed: () => _handleSendResetEmail(context, ref),
      backgroundColor: colorScheme.tertiary,
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

  Widget _buildHelpSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.2),
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
        children: [
          Container(
            padding: EdgeInsets.all(AppDimens.paddingM),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.help_center_rounded,
              color: colorScheme.primary,
              size: AppDimens.iconL,
            ),
          ),
          SizedBox(height: AppDimens.spaceM),

          Text(
            'Need Help?',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.spaceS),

          Text(
            'If you don\'t receive the email within a few minutes, please check your spam folder or contact our support team for assistance.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.spaceL),

          Row(
            children: [
              Expanded(
                child: _buildHelpCard(
                  context,
                  theme,
                  colorScheme,
                  Icons.mail_outline_rounded,
                  'Check Spam',
                  'Look in your spam or junk folder',
                ),
              ),
              SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: _buildHelpCard(
                  context,
                  theme,
                  colorScheme,
                  Icons.support_agent_rounded,
                  'Contact Support',
                  'Get help from our team',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCard(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: colorScheme.primary, size: AppDimens.iconM),
          SizedBox(height: AppDimens.spaceS),
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimens.spaceXS),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Future<void> _handleSendResetEmail(
    BuildContext context,
    WidgetRef ref,
  ) async {
    HapticFeedback.lightImpact();
    ref.read(authErrorProvider.notifier).clearError();
    final success = await ref
        .read(forgotPasswordFormStateProvider.notifier)
        .submitForgotPassword();

    if (success) {
      HapticFeedback.heavyImpact();
    }
  }

  Future<void> _handleResendEmail(BuildContext context, WidgetRef ref) async {
    ref.read(forgotPasswordFormStateProvider.notifier).resetEmailSentState();
    await _handleSendResetEmail(context, ref);
  }
}

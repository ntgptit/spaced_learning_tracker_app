// lib/presentation/screens/auth/forgot_password_screen.dart
import 'package:flutter/material.dart';
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

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch forgot password state
    final forgotPasswordForm = ref.watch(forgotPasswordFormStateProvider);
    final authState = ref.watch(authStateProvider);
    final authError = ref.watch(authErrorProvider);

    // Get theme data
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Show success state if email was sent successfully
    if (forgotPasswordForm.isEmailSent) {
      return SltSuccessStateWidget(
        title: 'Email Sent Successfully',
        message: 'We have sent a password reset link to ${forgotPasswordForm.email}. Please check your email and follow the instructions.',
        primaryButtonText: 'Back to Login',
        onPrimaryButtonPressed: () => context.go(AppRoutes.login),
        secondaryButtonText: 'Resend Email',
        onSecondaryButtonPressed: () => _handleResendEmail(context, ref),
        icon: Icons.email_outlined,
        showAppBar: true,
        appBarTitle: 'Password Reset',
      );
    }

    return SltScaffold(
      appBar: const SltAppBar(
        title: 'Reset Password',
        centerTitle: true,
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: authState.isLoading
              ? const SltLoadingStateWidget(message: 'Sending reset email...')
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Icon and Title
                      Center(
                        child: Container(
                          width: AppDimens.iconXXL,
                          height: AppDimens.iconXXL,
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.lock_reset_rounded,
                            size: AppDimens.iconXL,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceL),
                      
                      Text(
                        'Forgot Password?',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppDimens.spaceS),
                      
                      Text(
                        'Don\'t worry! Enter your email address and we\'ll send you a link to reset your password.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppDimens.spaceXL),

                      // Display error if any
                      if (authError != null) ...[
                        SltErrorStateWidget(
                          title: 'Reset Failed',
                          message: authError,
                          compact: true,
                        ),
                        const SizedBox(height: AppDimens.spaceL),
                      ],

                      // Email Form
                      SltTextField(
                        label: 'Email Address',
                        hint: 'Enter your email address',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        errorText: forgotPasswordForm.emailError,
                        onChanged: (value) => ref
                            .read(forgotPasswordFormStateProvider.notifier)
                            .updateEmail(value),
                        onSubmitted: (_) => _handleSendResetEmail(context, ref),
                      ),
                      const SizedBox(height: AppDimens.spaceXL),

                      // Send Reset Email Button
                      SltPrimaryButton(
                        text: 'Send Reset Link',
                        prefixIcon: Icons.send_rounded,
                        isFullWidth: true,
                        onPressed: () => _handleSendResetEmail(context, ref),
                      ),
                      const SizedBox(height: AppDimens.spaceL),

                      // Back to Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Remember your password?',
                            style: theme.textTheme.bodyMedium,
                          ),
                          SltTextButton(
                            text: 'Login',
                            onPressed: () => context.go(AppRoutes.login),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppDimens.spaceXL),

                      // Additional Help Text
                      Container(
                        padding: const EdgeInsets.all(AppDimens.paddingM),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(AppDimens.radiusM),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              color: colorScheme.primary,
                              size: AppDimens.iconM,
                            ),
                            const SizedBox(height: AppDimens.spaceS),
                            Text(
                              'Need Help?',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppDimens.spaceXS),
                            Text(
                              'If you don\'t receive the email within a few minutes, please check your spam folder or contact our support team.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _handleSendResetEmail(BuildContext context, WidgetRef ref) async {
    // Clear any previous errors
    ref.read(authErrorProvider.notifier).clearError();

    // Attempt to send reset email
    final success = await ref
        .read(forgotPasswordFormStateProvider.notifier)
        .submitForgotPassword();

    // Success state will be automatically shown by the widget rebuild
    if (!success && context.mounted) {
      // Error will be displayed automatically through authError provider
    }
  }

  Future<void> _handleResendEmail(BuildContext context, WidgetRef ref) async {
    // Reset the form state to allow resending
    ref.read(forgotPasswordFormStateProvider.notifier).resetEmailSentState();
    
    // Send email again
    await _handleSendResetEmail(context, ref);
  }
}
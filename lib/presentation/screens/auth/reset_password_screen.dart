// lib/presentation/screens/auth/reset_password_screen.dart
import 'package:flutter/material.dart';
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

class ResetPasswordScreen extends ConsumerWidget {
  final String resetToken;

  const ResetPasswordScreen({
    super.key,
    required this.resetToken,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch reset password state
    final resetPasswordForm = ref.watch(resetPasswordFormStateProvider);
    final authState = ref.watch(authStateProvider);
    final authError = ref.watch(authErrorProvider);

    // Get theme data
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Show success state if password was reset successfully
    if (authState.hasValue && authState.value == true && !authState.isLoading) {
      return SltSuccessStateWidget(
        title: 'Password Reset Successfully',
        message: 'Your password has been reset successfully. You can now login with your new password.',
        primaryButtonText: 'Go to Login',
        onPrimaryButtonPressed: () => context.go(AppRoutes.login),
        icon: Icons.check_circle_outline_rounded,
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
              ? const SltLoadingStateWidget(message: 'Resetting your password...')
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
                            Icons.lock_person_rounded,
                            size: AppDimens.iconXL,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceL),
                      
                      Text(
                        'Create New Password',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppDimens.spaceS),
                      
                      Text(
                        'Your new password must be different from your previous password and meet our security requirements.',
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

                      // Password Form
                      SltPasswordField(
                        label: 'New Password',
                        hint: 'Enter your new password',
                        prefixIconData: Icons.lock_outline,
                        errorText: resetPasswordForm.passwordError,
                        onChanged: (value) => ref
                            .read(resetPasswordFormStateProvider.notifier)
                            .updatePassword(value),
                      ),
                      const SizedBox(height: AppDimens.spaceL),

                      SltPasswordField(
                        label: 'Confirm New Password',
                        hint: 'Confirm your new password',
                        prefixIconData: Icons.lock_outline,
                        errorText: resetPasswordForm.confirmPasswordError,
                        onChanged: (value) => ref
                            .read(resetPasswordFormStateProvider.notifier)
                            .updateConfirmPassword(value),
                        onEditingComplete: () => _handleResetPassword(context, ref),
                      ),
                      const SizedBox(height: AppDimens.spaceM),

                      // Password Requirements
                      _buildPasswordRequirements(context, theme, colorScheme),
                      const SizedBox(height: AppDimens.spaceXL),

                      // Reset Password Button
                      SltPrimaryButton(
                        text: 'Reset Password',
                        prefixIcon: Icons.lock_reset_rounded,
                        isFullWidth: true,
                        onPressed: () => _handleResetPassword(context, ref),
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
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: colorScheme.primary,
                size: AppDimens.iconS,
              ),
              const SizedBox(width: AppDimens.spaceS),
              Text(
                'Password Requirements',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceS),
          _buildRequirementItem(
            context,
            theme,
            colorScheme,
            'At least 8 characters long',
            Icons.check_circle_outline_rounded,
          ),
          _buildRequirementItem(
            context,
            theme,
            colorScheme,
            'Contains both uppercase and lowercase letters',
            Icons.check_circle_outline_rounded,
          ),
          _buildRequirementItem(
            context,
            theme,
            colorScheme,
            'Contains at least one number',
            Icons.check_circle_outline_rounded,
          ),
          _buildRequirementItem(
            context,
            theme,
            colorScheme,
            'Contains at least one special character',
            Icons.check_circle_outline_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    String text,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.spaceXS),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppDimens.iconXS,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppDimens.spaceS),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleResetPassword(BuildContext context, WidgetRef ref) async {
    // Clear any previous errors
    ref.read(authErrorProvider.notifier).clearError();

    // Attempt to reset password
    final success = await ref
        .read(resetPasswordFormStateProvider.notifier)
        .submitResetPassword(resetToken);

    // Success state will be automatically shown by the widget rebuild
    if (!success && context.mounted) {
      // Error will be displayed automatically through authError provider
    }
  }
}
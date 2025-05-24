// lib/presentation/screens/auth/register_screen.dart
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
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../core/router/app_router.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch auth state for loading and error
    final authState = ref.watch(authStateProvider);
    final registerForm = ref.watch(registerFormStateProvider);
    final authError = ref.watch(authErrorProvider);

    // Get theme data
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SltScaffold(
      appBar: const SltAppBar(
        title: 'Create Account',
        centerTitle: true,
        showBackButton: true,
      ),
      body: SafeArea(
        child: authState.isLoading
            ? const SltLoadingStateWidget(message: 'Creating your account...')
            : SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimens.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section
                    _buildHeader(context, theme, colorScheme),
                    const SizedBox(height: AppDimens.spaceXL),

                    // Error Display
                    if (authError != null) ...[
                      SltErrorStateWidget(
                        title: 'Registration Failed',
                        message: authError,
                        compact: true,
                        onRetry: () =>
                            ref.read(authErrorProvider.notifier).clearError(),
                      ),
                      const SizedBox(height: AppDimens.spaceL),
                    ],

                    // Registration Form
                    _buildPersonalInfoSection(
                      context,
                      theme,
                      ref,
                      registerForm,
                    ),
                    const SizedBox(height: AppDimens.spaceL),

                    _buildAccountInfoSection(context, theme, ref, registerForm),
                    const SizedBox(height: AppDimens.spaceL),

                    _buildPasswordSection(context, theme, ref, registerForm),
                    const SizedBox(height: AppDimens.spaceM),

                    // Password Strength Indicator
                    _buildPasswordStrengthIndicator(
                      context,
                      theme,
                      colorScheme,
                      registerForm,
                    ),
                    const SizedBox(height: AppDimens.spaceXL),

                    // Terms and Conditions
                    _buildTermsSection(context, theme, colorScheme),
                    const SizedBox(height: AppDimens.spaceL),

                    // Register Button
                    SltPrimaryButton(
                      text: 'Create Account',
                      prefixIcon: Icons.person_add_alt_1_rounded,
                      isFullWidth: true,
                      onPressed: () => _handleRegister(context, ref),
                    ),
                    const SizedBox(height: AppDimens.spaceL),

                    // Login Link
                    _buildLoginLink(context, theme),
                    const SizedBox(height: AppDimens.spaceL),

                    // Additional Help
                    _buildHelpSection(context, theme, colorScheme),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        // Icon
        Container(
          width: AppDimens.iconXXL,
          height: AppDimens.iconXXL,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person_add_alt_rounded,
            size: AppDimens.iconXL,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(height: AppDimens.spaceL),

        // Title and subtitle
        Text(
          'Join Our Community',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spaceS),
        Text(
          'Create your account to start your learning journey',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
    RegisterFormModel registerForm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),

        // First Name and Last Name row
        Row(
          children: [
            Expanded(
              child: SltTextField(
                label: 'First Name',
                hint: 'Enter first name',
                prefixIcon: Icons.person_outline,
                errorText: registerForm.firstNameError,
                onChanged: (value) => ref
                    .read(registerFormStateProvider.notifier)
                    .updateFirstName(value),
              ),
            ),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: SltTextField(
                label: 'Last Name',
                hint: 'Enter last name',
                prefixIcon: Icons.person_outline,
                errorText: registerForm.lastNameError,
                onChanged: (value) => ref
                    .read(registerFormStateProvider.notifier)
                    .updateLastName(value),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAccountInfoSection(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
    RegisterFormModel registerForm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),

        // Username
        SltTextField(
          label: 'Username',
          hint: 'Choose a unique username',
          prefixIcon: Icons.account_circle_outlined,
          errorText: registerForm.usernameError,
          onChanged: (value) => ref
              .read(registerFormStateProvider.notifier)
              .updateUsername(value),
        ),
        const SizedBox(height: AppDimens.spaceL),

        // Email
        SltTextField(
          label: 'Email Address',
          hint: 'Enter your email address',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          errorText: registerForm.emailError,
          onChanged: (value) =>
              ref.read(registerFormStateProvider.notifier).updateEmail(value),
        ),
      ],
    );
  }

  Widget _buildPasswordSection(
    BuildContext context,
    ThemeData theme,
    WidgetRef ref,
    RegisterFormModel registerForm,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Setup',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),

        // Password
        SltPasswordField(
          label: 'Password',
          hint: 'Create a strong password',
          prefixIconData: Icons.lock_outline,
          errorText: registerForm.passwordError,
          onChanged: (value) => ref
              .read(registerFormStateProvider.notifier)
              .updatePassword(value),
        ),
        const SizedBox(height: AppDimens.spaceL),

        // Confirm Password
        SltPasswordField(
          label: 'Confirm Password',
          hint: 'Confirm your password',
          prefixIconData: Icons.lock_outline,
          errorText: registerForm.confirmPasswordError,
          onChanged: (value) => ref
              .read(registerFormStateProvider.notifier)
              .updateConfirmPassword(value),
        ),
      ],
    );
  }

  Widget _buildPasswordStrengthIndicator(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    RegisterFormModel registerForm,
  ) {
    final password = registerForm.password;
    final strength = _calculatePasswordStrength(password);

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
                Icons.security_rounded,
                color: _getStrengthColor(strength, colorScheme),
                size: AppDimens.iconS,
              ),
              const SizedBox(width: AppDimens.spaceS),
              Text(
                'Password Strength: ${_getStrengthText(strength)}',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getStrengthColor(strength, colorScheme),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceS),

          // Strength bar
          LinearProgressIndicator(
            value: strength / 4,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getStrengthColor(strength, colorScheme),
            ),
            minHeight: 4,
          ),
          const SizedBox(height: AppDimens.spaceS),

          // Requirements
          _buildPasswordRequirement(
            context,
            theme,
            colorScheme,
            'At least 8 characters',
            password.length >= 8,
          ),
          _buildPasswordRequirement(
            context,
            theme,
            colorScheme,
            'Contains uppercase letter',
            password.contains(RegExp(r'[A-Z]')),
          ),
          _buildPasswordRequirement(
            context,
            theme,
            colorScheme,
            'Contains lowercase letter',
            password.contains(RegExp(r'[a-z]')),
          ),
          _buildPasswordRequirement(
            context,
            theme,
            colorScheme,
            'Contains number',
            password.contains(RegExp(r'[0-9]')),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirement(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    String requirement,
    bool isMet,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.spaceXS),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: AppDimens.iconXS,
            color: isMet ? colorScheme.tertiary : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppDimens.spaceS),
          Text(
            requirement,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isMet
                  ? colorScheme.tertiary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          children: [
            const TextSpan(text: 'By creating an account, you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?', style: theme.textTheme.bodyMedium),
        SltTextButton(text: 'Login', onPressed: () => context.pop()),
      ],
    );
  }

  Widget _buildHelpSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.help_outline_rounded,
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
            'If you need assistance creating your account, please contact our support team.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  int _calculatePasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;

    return strength;
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return 'Weak';
    }
  }

  Color _getStrengthColor(int strength, ColorScheme colorScheme) {
    switch (strength) {
      case 0:
      case 1:
        return colorScheme.error;
      case 2:
        return Colors.orange;
      case 3:
        return colorScheme.tertiary;
      case 4:
        return colorScheme.primary;
      default:
        return colorScheme.error;
    }
  }

  Future<void> _handleRegister(BuildContext context, WidgetRef ref) async {
    // Clear any previous errors
    ref.read(authErrorProvider.notifier).clearError();

    // Attempt registration
    final success = await ref
        .read(registerFormStateProvider.notifier)
        .submitRegistration();

    // Navigate to home if successful
    if (success && context.mounted) {
      context.go(AppRoutes.main);
    }
  }
}

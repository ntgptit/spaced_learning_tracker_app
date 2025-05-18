import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/router/app_routes.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_text_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../widgets/common/slt_scaffold.dart';
import '../../widgets/inputs/slt_password_text_field.dart';

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
        title: 'Register',
        centerTitle: true,
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: authState.isLoading
              ? const SltLoadingStateWidget(message: 'Creating your account...')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title and description
                    Text(
                      'Create Account',
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimens.spaceS),
                    Text(
                      'Fill in the form to create your account',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimens.spaceXL),

                    // Display error if any
                    if (authError != null) ...[
                      SltErrorStateWidget(
                        title: 'Registration Failed',
                        message: authError,
                        compact: true,
                      ),
                      const SizedBox(height: AppDimens.spaceL),
                    ],

                    // Registration Form
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
                    const SizedBox(height: AppDimens.spaceL),

                    // Username
                    SltTextField(
                      label: 'Username',
                      hint: 'Choose a username',
                      prefixIcon: Icons.account_circle_outlined,
                      errorText: registerForm.usernameError,
                      onChanged: (value) => ref
                          .read(registerFormStateProvider.notifier)
                          .updateUsername(value),
                    ),
                    const SizedBox(height: AppDimens.spaceL),

                    // Email
                    SltTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      errorText: registerForm.emailError,
                      onChanged: (value) => ref
                          .read(registerFormStateProvider.notifier)
                          .updateEmail(value),
                    ),
                    const SizedBox(height: AppDimens.spaceL),

                    // Password
                    SltPasswordField(
                      label: 'Password',
                      hint: 'Create a password',
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
                    const SizedBox(height: AppDimens.spaceXL),

                    // Register Button
                    SltPrimaryButton(
                      text: 'Create Account',
                      prefixIcon: Icons.person_add_alt_1_rounded,
                      isFullWidth: true,
                      onPressed: () => _handleRegister(context, ref),
                    ),
                    const SizedBox(height: AppDimens.spaceL),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: theme.textTheme.bodyMedium,
                        ),
                        SltTextButton(
                          text: 'Login',
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
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
      context.go(AppRoutes.home);
    }
  }
}

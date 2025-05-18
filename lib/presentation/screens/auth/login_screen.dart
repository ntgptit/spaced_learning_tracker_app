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

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch auth state for loading and error
    final authState = ref.watch(authStateProvider);
    final loginForm = ref.watch(loginFormStateProvider);
    final authError = ref.watch(authErrorProvider);

    // Get theme data
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SltScaffold(
      appBar: const SltAppBar(title: 'Login', centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: authState.isLoading
              ? const SltLoadingStateWidget(message: 'Logging in...')
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App Logo and Title
                    Center(
                      child: Icon(
                        Icons.school_rounded,
                        size: AppDimens.iconXXL,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceM),
                    Text(
                      'Welcome Back',
                      style: theme.textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimens.spaceS),
                    Text(
                      'Enter your credentials to continue',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimens.spaceXL),

                    // Display error if any
                    if (authError != null) ...[
                      SltErrorStateWidget(
                        title: 'Login Failed',
                        message: authError,
                        compact: true,
                      ),
                      const SizedBox(height: AppDimens.spaceL),
                    ],

                    // Login Form
                    SltTextField(
                      label: 'Username or Email',
                      hint: 'Enter your username or email',
                      prefixIcon: Icons.person_outline,
                      errorText: loginForm.usernameOrEmailError,
                      onChanged: (value) => ref
                          .read(loginFormStateProvider.notifier)
                          .updateUsernameOrEmail(value),
                    ),
                    const SizedBox(height: AppDimens.spaceL),

                    SltPasswordField(
                      label: 'Password',
                      hint: 'Enter your password',
                      prefixIconData: Icons.lock_outline,
                      errorText: loginForm.passwordError,
                      onChanged: (value) => ref
                          .read(loginFormStateProvider.notifier)
                          .updatePassword(value),
                    ),
                    const SizedBox(height: AppDimens.spaceXL),

                    // Login Button
                    SltPrimaryButton(
                      text: 'Login',
                      prefixIcon: Icons.login_rounded,
                      isFullWidth: true,
                      onPressed: () => _handleLogin(context, ref),
                    ),
                    const SizedBox(height: AppDimens.spaceL),

                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: theme.textTheme.bodyMedium,
                        ),
                        SltTextButton(
                          text: 'Register',
                          onPressed: () => context.push(AppRoutes.register),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context, WidgetRef ref) async {
    // Clear any previous errors
    ref.read(authErrorProvider.notifier).clearError();

    // Attempt login
    final success = await ref
        .read(loginFormStateProvider.notifier)
        .submitLogin();

    // Navigate to home if successful
    if (success && context.mounted) {
      context.go(AppRoutes.home);
    }
  }
}

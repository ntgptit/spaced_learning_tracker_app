// lib/presentation/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/auth/slt_biometric_auth.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_text_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_password_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../core/router/app_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _showBiometricSection = false;

  @override
  void initState() {
    super.initState();
    // Check biometric availability after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometricAvailability();
    });
  }

  Future<void> _checkBiometricAvailability() async {
    final availability = await ref.read(biometricAvailabilityProvider.future);
    if (mounted && availability == BiometricAuthState.available) {
      setState(() {
        _showBiometricSection = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
              : SingleChildScrollView(
                  child: Column(
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

                      // Biometric Authentication Section
                      if (_showBiometricSection) ...[
                        _buildBiometricSection(context, theme, colorScheme),
                        const SizedBox(height: AppDimens.spaceL),
                        _buildDivider(context, theme, colorScheme),
                        const SizedBox(height: AppDimens.spaceL),
                      ],

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
                        onEditingComplete: () => _handleLogin(context, ref),
                      ),
                      const SizedBox(height: AppDimens.spaceM),

                      // Forgot Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: SltTextButton(
                          text: 'Forgot Password?',
                          onPressed: () =>
                              context.push(AppRoutes.forgotPassword),
                          foregroundColor: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: AppDimens.spaceL),

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
      ),
    );
  }

  Widget _buildBiometricSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingM),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Quick Login',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppDimens.spaceS),
          SltBiometricAuth(
            title: 'Use Biometric Authentication',
            subtitle: 'Authenticate quickly with your fingerprint or face',
            onSuccess: () => _handleBiometricSuccess(context, ref),
            onError: () => _handleBiometricError(context),
            onAlternativeLogin: () => _focusOnPasswordField(),
            showAlternativeLogin: false,
            primaryColor: colorScheme.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: colorScheme.outlineVariant, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingM),
          child: Text(
            'or login with password',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: colorScheme.outlineVariant, thickness: 1),
        ),
      ],
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
      context.go(AppRoutes.main);
    }
  }

  Future<void> _handleBiometricSuccess(
    BuildContext context,
    WidgetRef ref,
  ) async {
    // In a real app, you would retrieve stored credentials and auto-login
    // For now, we'll simulate a successful biometric login

    // Show a brief loading state
    ref.read(authStateProvider.notifier).state = const AsyncValue.loading();

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Simulate successful authentication
    ref.read(authStateProvider.notifier).state = const AsyncValue.data(true);

    if (context.mounted) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Biometric authentication successful!'),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(AppDimens.paddingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
          ),
        ),
      );

      // Navigate to main screen
      context.go(AppRoutes.main);
    }
  }

  void _handleBiometricError(BuildContext context) {
    // Error handling is already done in the SltBiometricAuth widget
    // This is just for additional app-specific error handling if needed
  }

  void _focusOnPasswordField() {
    // Scroll to password field or set focus
    // This would require FocusNode management for the password field
  }
}

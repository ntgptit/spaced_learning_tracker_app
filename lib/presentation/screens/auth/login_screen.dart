// lib/presentation/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/constants/app_constants.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/screens/auth/register_screen.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider);
    final authError = ref.watch(authErrorProvider);
    final formState = ref.watch(loginFormStateProvider);
    final formNotifier = ref.read(loginFormStateProvider.notifier);

    // Controllers for text fields - populated with current state values
    final usernameOrEmailController = TextEditingController(
      text: formState.usernameOrEmail,
    );
    final passwordController = TextEditingController(text: formState.password);

    // Handle login submission
    Future<void> handleLogin() async {
      final success = await formNotifier.submitLogin();
      if (success && context.mounted) {
        GoRouter.of(context).go('/');
      }
    }

    if (authState.isLoading) {
      return SlLoadingStateWidget.fullScreen(message: 'Logging in...');
    }

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.paddingXXL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(theme),
                if (authError != null) _buildErrorWidget(authError, theme, ref),
                const SizedBox(height: AppDimens.spaceL),
                _buildFormFields(
                  theme,
                  formState,
                  formNotifier,
                  usernameOrEmailController,
                  passwordController,
                  handleLogin,
                ),
                const SizedBox(height: AppDimens.spaceXL),
                _buildActions(context, theme, handleLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      children: [
        Text(
          AppConstants.appName,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spaceS),
        Text(
          'Login to your account',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorWidget(
    String errorMessage,
    ThemeData theme,
    WidgetRef ref,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimens.paddingL),
      child: SlErrorStateWidget(
        title: 'Login Failed',
        message: errorMessage,
        compact: true,
        onRetry: () => ref.read(authErrorProvider.notifier).clearError(),
        icon: Icons.login_outlined,
        accentColor: theme.colorScheme.error,
      ),
    );
  }

  Widget _buildFormFields(
    ThemeData theme,
    LoginFormModel formState,
    LoginFormState formNotifier,
    TextEditingController usernameOrEmailController,
    TextEditingController passwordController,
    VoidCallback handleLogin,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SLTextField(
          label: 'Username or Email',
          hint: 'Enter your username or email',
          controller: usernameOrEmailController,
          keyboardType: TextInputType.text,
          errorText: formState.usernameOrEmailError,
          prefixIcon: Icons.person,
          onChanged: (value) => formNotifier.updateUsernameOrEmail(value),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimens.spaceL),
        SLPasswordField(
          label: 'Password',
          hint: 'Enter your password',
          controller: passwordController,
          errorText: formState.passwordError,
          prefixIconData: Icons.lock_outline,
          onChanged: (value) => formNotifier.updatePassword(value),
          textInputAction: TextInputAction.done,
          onEditingComplete: handleLogin,
        ),
      ],
    );
  }

  Widget _buildActions(
    BuildContext context,
    ThemeData theme,
    VoidCallback handleLogin,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SltPrimaryButton(
          text: 'Login',
          onPressed: handleLogin,
          isFullWidth: true,
          size: SltButtonSize.large,
        ),
        const SizedBox(height: AppDimens.spaceL),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SltTextButton(
              text: 'Register',
              onPressed: () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const RegisterScreen())),
              foregroundColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ],
    );
  }
}

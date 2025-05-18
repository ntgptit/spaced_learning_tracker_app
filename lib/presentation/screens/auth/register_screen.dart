// lib/presentation/screens/auth/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/constants/app_constants.dart';
import 'package:spaced_learning_app/core/navigation/navigation_helper.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/common/button/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/button/slt_text_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/input/slt_password_field.dart';
import 'package:spaced_learning_app/presentation/widgets/common/input/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/common/state/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/common/state/slt_loading_state_widget.dart';

import '../../widgets/common/button/slt_button_base.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authStateProvider);
    final authError = ref.watch(authErrorProvider);
    final formState = ref.watch(registerFormStateProvider);
    final formNotifier = ref.read(registerFormStateProvider.notifier);

    // Controllers for text fields - populated with current state values
    final firstNameController = TextEditingController(
      text: formState.firstName,
    );
    final lastNameController = TextEditingController(text: formState.lastName);
    final usernameController = TextEditingController(text: formState.username);
    final emailController = TextEditingController(text: formState.email);
    final passwordController = TextEditingController(text: formState.password);
    final confirmPasswordController = TextEditingController(
      text: formState.confirmPassword,
    );

    // Handle registration submission
    Future<void> handleRegister() async {
      final success = await formNotifier.submitRegistration();
      if (success && context.mounted) {
        NavigationHelper.clearStackAndGo(context, '/');
      }
    }

    if (authState.isLoading) {
      return SlLoadingStateWidget.fullScreen(
        message: 'Creating your account...',
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.paddingXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(theme),
              if (authError != null) _buildErrorWidget(authError, theme, ref),
              const SizedBox(height: AppDimens.spaceL),
              _buildPersonalInfoFields(
                theme,
                formState,
                formNotifier,
                firstNameController,
                lastNameController,
              ),
              const SizedBox(height: AppDimens.spaceL),
              _buildAccountFields(
                theme,
                formState,
                formNotifier,
                usernameController,
                emailController,
                passwordController,
                confirmPasswordController,
              ),
              const SizedBox(height: AppDimens.spaceXL),
              _buildActions(context, theme, handleRegister),
            ],
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
          'Create your account',
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
        title: 'Registration Failed',
        message: errorMessage,
        compact: true,
        onRetry: () => ref.read(authErrorProvider.notifier).clearError(),
        icon: Icons.person_add_alt_1_outlined,
        accentColor: theme.colorScheme.error,
      ),
    );
  }

  Widget _buildPersonalInfoFields(
    ThemeData theme,
    RegisterFormModel formState,
    RegisterFormState formNotifier,
    TextEditingController firstNameController,
    TextEditingController lastNameController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),
        SLTextField(
          label: 'First Name',
          hint: 'Enter your first name',
          controller: firstNameController,
          keyboardType: TextInputType.name,
          errorText: formState.firstNameError,
          prefixIcon: Icons.person,
          onChanged: (value) => formNotifier.updateFirstName(value),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimens.spaceM),
        SLTextField(
          label: 'Last Name',
          hint: 'Enter your last name',
          controller: lastNameController,
          keyboardType: TextInputType.name,
          errorText: formState.lastNameError,
          prefixIcon: Icons.person,
          onChanged: (value) => formNotifier.updateLastName(value),
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildAccountFields(
    ThemeData theme,
    RegisterFormModel formState,
    RegisterFormState formNotifier,
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),
        SLTextField(
          label: 'Username',
          hint: 'Enter your username',
          controller: usernameController,
          keyboardType: TextInputType.text,
          errorText: formState.usernameError,
          prefixIcon: Icons.account_circle,
          onChanged: (value) => formNotifier.updateUsername(value),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimens.spaceM),
        SLTextField(
          label: 'Email',
          hint: 'Enter your email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          errorText: formState.emailError,
          prefixIcon: Icons.email,
          onChanged: (value) => formNotifier.updateEmail(value),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimens.spaceM),
        SLPasswordField(
          label: 'Password',
          hint: 'Enter your password',
          controller: passwordController,
          errorText: formState.passwordError,
          prefixIconData: Icons.lock_outline,
          onChanged: (value) => formNotifier.updatePassword(value),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppDimens.spaceM),
        SLPasswordField(
          label: 'Confirm Password',
          hint: 'Confirm your password',
          controller: confirmPasswordController,
          errorText: formState.confirmPasswordError,
          prefixIconData: Icons.lock_outline,
          onChanged: (value) => formNotifier.updateConfirmPassword(value),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildActions(
    BuildContext context,
    ThemeData theme,
    VoidCallback handleRegister,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SltPrimaryButton(
          text: 'Register',
          onPressed: handleRegister,
          isFullWidth: true,
          size: SltButtonSize.large,
        ),
        const SizedBox(height: AppDimens.spaceL),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SltTextButton(
              text: 'Login',
              onPressed: () => Navigator.of(context).pop(),
              foregroundColor: theme.colorScheme.primary,
            ),
          ],
        ),
      ],
    );
  }
}

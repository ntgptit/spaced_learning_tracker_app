import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slt_app/core/constants/app_assets.dart';
import 'package:slt_app/core/di/dependency_injection.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:slt_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:slt_app/presentation/widgets/inputs/slt_password_text_field.dart';
import 'package:slt_app/presentation/widgets/inputs/slt_text_field.dart';

import '../../../core/services/slt_ui_notifier_service.dart';
import '../../../core/theme/app_dimens.dart';
import '../../viewmodels/auth/register_view_model.dart';

/// Register screen
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _uiNotifier = DependencyInjection.locator<UiNotifierService>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    final registerViewModel = ref.read(registerViewModelProvider.notifier);

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final success = await registerViewModel.register(
      name: name,
      email: email,
      password: password,
    );

    // Check if the widget is still mounted after the async operation
    if (!mounted) return;

    if (success) {
      _uiNotifier.showSuccessSnackBar(
        context,
        'Registration successful. Please login.',
      );

      // Navigate back to login screen
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const SltAppBar(
        title: 'Create Account',
        showBackButton: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: AppDimens.screenPadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo and title
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        AppAssets.logoLightMode,
                        height: 60,
                        width: 60,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Join Us',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create a new account',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color:
                              theme.colorScheme.onBackground.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Error message
                if (registerState.errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.error.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      registerState.errorMessage!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Name field
                SltTextField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  textInputAction: TextInputAction.next,
                  validator:
                      ref.read(registerViewModelProvider.notifier).validateName,
                  onChanged: (_) =>
                      ref.read(registerViewModelProvider.notifier).clearError(),
                  enabled: !registerState.isLoading,
                ),

                const SizedBox(height: 16),

                // Email field
                SltTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: ref
                      .read(registerViewModelProvider.notifier)
                      .validateEmail,
                  onChanged: (_) =>
                      ref.read(registerViewModelProvider.notifier).clearError(),
                  enabled: !registerState.isLoading,
                ),

                const SizedBox(height: 16),

                // Password field
                SltPasswordTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Create a password',
                  validator: ref
                      .read(registerViewModelProvider.notifier)
                      .validatePassword,
                  onChanged: (_) =>
                      ref.read(registerViewModelProvider.notifier).clearError(),
                  textInputAction: TextInputAction.next,
                  enabled: !registerState.isLoading,
                  initiallyVisible: registerState.isPasswordVisible,
                ),

                const SizedBox(height: 16),

                // Confirm password field
                SltPasswordTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  validator: (value) => ref
                      .read(registerViewModelProvider.notifier)
                      .validateConfirmPassword(value, _passwordController.text),
                  onChanged: (_) =>
                      ref.read(registerViewModelProvider.notifier).clearError(),
                  textInputAction: TextInputAction.done,
                  enabled: !registerState.isLoading,
                  initiallyVisible: registerState.isConfirmPasswordVisible,
                  onSubmitted: (_) => _register(),
                ),

                const SizedBox(height: 24),

                // Terms and conditions
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: true, // Should be a state variable in real app
                        onChanged: (value) {
                          // Implement terms agreement logic
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Register button
                SltPrimaryButton(
                  text: 'Create Account',
                  onPressed: registerState.isLoading ? null : _register,
                  expandToFillWidth: true,
                  isLoading: registerState.isLoading,
                  height: 50,
                ),

                const SizedBox(height: 24),

                // Login option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: registerState.isLoading
                          ? null
                          : () {
                              // Navigate back to login screen
                              Navigator.of(context).pop();
                            },
                      child: const Text('Login'),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

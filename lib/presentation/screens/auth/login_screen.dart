import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slt_app/core/constants/app_assets.dart';
import 'package:slt_app/core/di/dependency_injection.dart';
import 'package:slt_app/core/router/app_routes.dart';
import 'package:slt_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:slt_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:slt_app/presentation/widgets/inputs/slt_password_text_field.dart';
import 'package:slt_app/presentation/widgets/inputs/slt_text_field.dart';

import '../../../core/services/slt_ui_notifier_service.dart';
import '../../../core/theme/app_dimens.dart';
import '../../viewmodels/auth/login_view_model.dart';

/// Login screen
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _uiNotifier = DependencyInjection.locator<UiNotifierService>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final loginViewModel = ref.read(loginViewModelProvider.notifier);

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Hide keyboard
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Store whether this widget is mounted before the async gap
    bool isSuccessful = await loginViewModel.login(email, password);

    // Check if the widget is still mounted after the async operation
    if (!mounted) return;

    if (isSuccessful) {
      _uiNotifier.showSuccessSnackBar(
        context,
        'Login successful',
      );

      // Navigate to home screen
      AppRoutes.navigateReplacementTo(context, AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: const SltAppBar(
        title: 'Login',
        showBackButton: false,
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
                      const SizedBox(height: 40),
                      Image.asset(
                        AppAssets.logoLightMode,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome Back',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to continue',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Error message
                if (loginState.errorMessage != null) ...[
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
                      loginState.errorMessage!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Email field
                SltTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator:
                      ref.read(loginViewModelProvider.notifier).validateEmail,
                  onChanged: (_) =>
                      ref.read(loginViewModelProvider.notifier).clearError(),
                  enabled: !loginState.isLoading,
                ),

                const SizedBox(height: 16),

                // Password field
                SltPasswordTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validator: ref
                      .read(loginViewModelProvider.notifier)
                      .validatePassword,
                  onChanged: (_) =>
                      ref.read(loginViewModelProvider.notifier).clearError(),
                  textInputAction: TextInputAction.done,
                  enabled: !loginState.isLoading,
                  initiallyVisible: loginState.isPasswordVisible,
                  onSubmitted: (_) => _login(),
                ),

                const SizedBox(height: 8),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: loginState.isLoading
                        ? null
                        : () {
                            // Navigate to forgot password screen
                          },
                    child: const Text('Forgot Password?'),
                  ),
                ),

                const SizedBox(height: 24),

                // Login button
                SltPrimaryButton(
                  text: 'Login',
                  onPressed: loginState.isLoading ? null : _login,
                  expandToFillWidth: true,
                  isLoading: loginState.isLoading,
                  height: 50,
                ),

                const SizedBox(height: 24),

                // Register option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: loginState.isLoading
                          ? null
                          : () {
                              // Navigate to register screen
                              AppRoutes.navigateTo(context, AppRoutes.register);
                            },
                      child: const Text('Register'),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Social login options
                if (!loginState.isLoading) ...[
                  const Center(
                    child: Text('- OR -'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Google login
                      _buildSocialLoginButton(
                        onPressed: () {
                          // Implement Google login
                        },
                        icon: Icons.g_mobiledata,
                        backgroundColor: Colors.white,
                        borderColor: Colors.grey.shade300,
                        iconColor: Colors.red,
                      ),

                      const SizedBox(width: 16),

                      // Facebook login
                      _buildSocialLoginButton(
                        onPressed: () {
                          // Implement Facebook login
                        },
                        icon: Icons.facebook,
                        backgroundColor: Colors.blue.shade800,
                        iconColor: Colors.white,
                      ),

                      const SizedBox(width: 16),

                      // Apple login
                      _buildSocialLoginButton(
                        onPressed: () {
                          // Implement Apple login
                        },
                        icon: Icons.apple,
                        backgroundColor: Colors.black,
                        iconColor: Colors.white,
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color backgroundColor,
    Color iconColor = Colors.white,
    Color? borderColor,
  }) {
    return Material(
      color: backgroundColor,
      shape: CircleBorder(
        side: borderColor != null
            ? BorderSide(color: borderColor)
            : BorderSide.none,
      ),
      elevation: 1,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
      ),
    );
  }
}

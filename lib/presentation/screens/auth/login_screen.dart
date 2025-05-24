// lib/presentation/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  bool _showBiometricSection = false;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkBiometricAvailability();
    });
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: AppDimens.durationMedium2),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: AppDimens.durationMedium4),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
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
    final authState = ref.watch(authStateProvider);
    final loginForm = ref.watch(loginFormStateProvider);
    final authError = ref.watch(authErrorProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return SltScaffold(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: colorScheme.surface,
        systemNavigationBarIconBrightness: theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      appBar: SltAppBar(
        title: '',
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: theme.brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        ),
      ),
      body: authState.isLoading
          ? const SltLoadingStateWidget(
              message: 'Logging in...',
              type: LoadingIndicatorType.fadingCircle,
            )
          : SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        size.height -
                        MediaQuery.of(context).padding.top -
                        kToolbarHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsivePadding.horizontal,
                      vertical: AppDimens.paddingL,
                    ),
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Hero Section
                            _buildHeroSection(context, theme, colorScheme),
                            SizedBox(height: AppDimens.spaceXXL),

                            // Biometric Section
                            if (_showBiometricSection) ...[
                              _buildBiometricSection(
                                context,
                                theme,
                                colorScheme,
                              ),
                              SizedBox(height: AppDimens.spaceXL),
                              _buildDivider(context, theme, colorScheme),
                              SizedBox(height: AppDimens.spaceXL),
                            ],

                            // Error Display
                            if (authError != null) ...[
                              SltErrorStateWidget(
                                title: 'Login Failed',
                                message: authError,
                                compact: true,
                                accentColor: colorScheme.error,
                              ),
                              SizedBox(height: AppDimens.spaceL),
                            ],

                            // Login Form
                            _buildLoginForm(
                              context,
                              theme,
                              colorScheme,
                              loginForm,
                            ),
                            SizedBox(height: AppDimens.spaceL),

                            // Action Buttons
                            _buildActionButtons(context, theme, colorScheme),
                            SizedBox(height: AppDimens.spaceXXL),

                            // Footer Links
                            _buildFooterLinks(context, theme, colorScheme),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildHeroSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        // App Logo with Gradient Background
        Container(
          width: AppDimens.iconXXL * 1.5,
          height: AppDimens.iconXXL * 1.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.primary,
                colorScheme.primary.withValues(alpha: 0.8),
                colorScheme.secondary,
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: AppDimens.shadowRadiusL,
                offset: const Offset(0, AppDimens.shadowOffsetM),
              ),
            ],
          ),
          child: Icon(
            Icons.school_rounded,
            size: AppDimens.iconXL,
            color: Colors.white,
          ),
        ),
        SizedBox(height: AppDimens.spaceXL),

        // Welcome Text
        Text(
          'Welcome Back',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: AppDimens.spaceM),

        Text(
          'Sign in to continue your learning journey',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBiometricSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.3),
            colorScheme.tertiaryContainer.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppDimens.paddingS),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimens.radiusM),
                ),
                child: Icon(
                  Icons.fingerprint_rounded,
                  color: colorScheme.primary,
                  size: AppDimens.iconM,
                ),
              ),
              SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Access',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: AppDimens.spaceXS),
                    Text(
                      'Use biometric authentication for faster login',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimens.spaceL),
          SltBiometricAuth(
            title: 'Biometric Login',
            subtitle: 'Authenticate with your fingerprint or face',
            onSuccess: () => _handleBiometricSuccess(context, ref),
            onError: () => _handleBiometricError(context),
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
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  colorScheme.outline.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.paddingL),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.paddingM,
              vertical: AppDimens.paddingS,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppDimens.radiusXXL),
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Text(
              'or continue with',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  colorScheme.outline.withValues(alpha: 0.5),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    LoginFormModel loginForm,
  ) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SltTextField(
            label: 'Username or Email',
            hint: 'Enter your username or email',
            prefixIcon: Icons.person_outline_rounded,
            errorText: loginForm.usernameOrEmailError,
            onChanged: (value) => ref
                .read(loginFormStateProvider.notifier)
                .updateUsernameOrEmail(value),
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: AppDimens.spaceL),

          SltPasswordField(
            label: 'Password',
            hint: 'Enter your password',
            prefixIconData: Icons.lock_outline_rounded,
            errorText: loginForm.passwordError,
            onChanged: (value) =>
                ref.read(loginFormStateProvider.notifier).updatePassword(value),
            onEditingComplete: () => _handleLogin(context, ref),
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: AppDimens.spaceM),

          // Forgot Password Link
          Align(
            alignment: Alignment.centerRight,
            child: SltTextButton(
              text: 'Forgot Password?',
              onPressed: () => context.push(AppRoutes.forgotPassword),
              foregroundColor: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SltPrimaryButton(
          text: 'Sign In',
          prefixIcon: Icons.login_rounded,
          isFullWidth: true,
          onPressed: () => _handleLogin(context, ref),
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: AppDimens.elevationS,
        ),
      ],
    );
  }

  Widget _buildFooterLinks(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SltTextButton(
              text: 'Sign Up',
              onPressed: () => context.push(AppRoutes.register),
              foregroundColor: colorScheme.primary,
            ),
          ],
        ),
        SizedBox(height: AppDimens.spaceM),

        // Additional Help
        Container(
          padding: EdgeInsets.all(AppDimens.paddingM),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.help_outline_rounded,
                color: colorScheme.primary,
                size: AppDimens.iconM,
              ),
              SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need Help?',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: AppDimens.spaceXS),
                    Text(
                      'Contact our support team for assistance',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogin(BuildContext context, WidgetRef ref) async {
    // Add haptic feedback
    HapticFeedback.lightImpact();

    ref.read(authErrorProvider.notifier).clearError();
    final success = await ref
        .read(loginFormStateProvider.notifier)
        .submitLogin();

    if (success && context.mounted) {
      HapticFeedback.successImpact();
      context.go(AppRoutes.main);
    }
  }

  Future<void> _handleBiometricSuccess(
    BuildContext context,
    WidgetRef ref,
  ) async {
    HapticFeedback.successImpact();
    ref.read(authStateProvider.notifier).state = const AsyncValue.loading();
    await Future.delayed(const Duration(milliseconds: 1500));
    ref.read(authStateProvider.notifier).state = const AsyncValue.data(true);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: AppDimens.spaceS),
              Text('Biometric authentication successful!'),
            ],
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(AppDimens.paddingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
          ),
          duration: const Duration(milliseconds: AppDimens.durationMedium2),
        ),
      );
      context.go(AppRoutes.main);
    }
  }

  void _handleBiometricError(BuildContext context) {
    HapticFeedback.errorImpact();
  }
}

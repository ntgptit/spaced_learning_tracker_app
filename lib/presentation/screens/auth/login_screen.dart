// lib/presentation/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_dimens.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/auth/slt_biometric_auth.dart';
import '../../widgets/buttons/slt_button_base.dart';
import '../../widgets/buttons/slt_primary_button.dart';
import '../../widgets/buttons/slt_text_button.dart';
import '../../widgets/cards/slt_card.dart';
import '../../widgets/common/slt_app_bar.dart';
import '../../widgets/common/slt_scaffold.dart';
import '../../widgets/inputs/slt_password_text_field.dart';
import '../../widgets/inputs/slt_text_field.dart';
import '../../widgets/states/slt_error_state_widget.dart';
import '../../widgets/states/slt_loading_state_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkBiometricAvailability();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(authErrorProvider.notifier).clearError();
      }
    });
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();
  }

  void _checkBiometricAvailability() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // Guard clause
      ref.read(biometricAuthProvider.notifier).checkAvailability();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    if (authState.isLoading) {
      return const SltScaffold(
        appBar: SltAppBar(
          title: AppStrings.auth.appBarLogin, // Corrected
          centerTitle: true,
          transparent: true,
        ),
        body: SltLoadingStateWidget(
          message: AppStrings.auth.loggingIn, // Corrected
          type: LoadingIndicatorType.fadingCircle,
        ),
      );
    }
    return _buildLoginContent(context);
  }

  Widget _buildLoginContent(BuildContext context) {
    final loginForm = ref.watch(loginFormStateProvider);
    final authError = ref.watch(authErrorProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SltScaffold(
      appBar: const SltAppBar(
        title: AppStrings.auth.appBarLogin, // Corrected
        centerTitle: true,
        transparent: true,
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildLoginForm(
                context,
                theme,
                colorScheme,
                loginForm,
                authError,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    LoginFormModel loginForm,
    String? authError,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeaderSection(theme, colorScheme),
          const SizedBox(height: AppDimens.spaceXL),
          _buildErrorSection(authError),
          _buildFormCard(theme, colorScheme, loginForm),
          const SizedBox(height: AppDimens.spaceL),
          _buildActionButtons(),
          const SizedBox(height: AppDimens.spaceL),
          _buildBiometricSection(),
          const SizedBox(height: AppDimens.spaceXL),
          _buildRegisterLink(theme),
        ],
      ),
    );
  }

  Widget _buildHeaderSection(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: [
        Hero(
          tag: 'app_logo',
          child: Container(
            width: AppDimens.iconXXL * 1.5,
            height: AppDimens.iconXXL * 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorScheme.primary, colorScheme.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.3),
                  blurRadius: AppDimens.blurRadiusL,
                  offset: const Offset(0, AppDimens.offsetM),
                ),
              ],
            ),
            child: Icon(
              Icons.psychology_rounded,
              size: AppDimens.iconXXL,
              color: colorScheme.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: AppDimens.spaceL),
        Text(
          AppStrings.auth.welcomeBackLogin, // Corrected
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spaceS),
        Text(
          AppStrings.auth.loginSubtitle, // Corrected
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorSection(String? authError) {
    if (authError == null || authError.isEmpty) {
      // Guard clause
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SltErrorStateWidget(
          title: AppStrings.errors.loginFailed, // Corrected
          message: authError,
          compact: true,
          onRetry: () => ref.read(authErrorProvider.notifier).clearError(),
        ),
        const SizedBox(height: AppDimens.spaceL),
      ],
    );
  }

  Widget _buildFormCard(
    ThemeData theme,
    ColorScheme colorScheme,
    LoginFormModel loginForm,
  ) {
    return SltCard(
      elevation: AppDimens.elevationM,
      padding: const EdgeInsets.all(AppDimens.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SltTextField(
            label: AppStrings.auth.usernameOrEmail,
            // Corrected
            hint: AppStrings.auth.enterUsernameOrEmail,
            // Corrected
            prefixIcon: Icons.person_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            initialValue: loginForm.usernameOrEmail,
            // Will work after SltTextField update
            errorText: loginForm.usernameOrEmailError,
            onChanged: (value) => ref
                .read(loginFormStateProvider.notifier)
                .updateUsernameOrEmail(value),
          ),
          const SizedBox(height: AppDimens.spaceL),
          SltPasswordField(
            label: AppStrings.auth.password,
            // Corrected
            hint: AppStrings.auth.enterPassword,
            // Corrected
            prefixIconData: Icons.lock_outline_rounded,
            errorText: loginForm.passwordError,
            onChanged: (value) =>
                ref.read(loginFormStateProvider.notifier).updatePassword(value),
            onEditingComplete: () => _handleLogin(context),
          ),
          const SizedBox(height: AppDimens.spaceM),
          _buildForgotPasswordLink(theme),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordLink(ThemeData theme) {
    return Align(
      alignment: Alignment.centerRight,
      child: SltTextButton(
        text: AppStrings.auth.forgotPassword, // Corrected
        onPressed: () => _navigateToForgotPassword(),
        size: SltButtonSize.small,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SltPrimaryButton(
          text: AppStrings.auth.logInButton,
          // Corrected
          prefixIcon: Icons.login_rounded,
          isFullWidth: true,
          size: SltButtonSize.large,
          onPressed: () => _handleLogin(context),
        ),
      ],
    );
  }

  Widget _buildBiometricSection() {
    final biometricState = ref.watch(biometricAuthProvider);

    if (!biometricState.isAvailable) {
      // Guard clause
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.paddingM,
              ),
              child: Text(
                AppStrings.auth.orLoginWith, // Corrected
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: AppDimens.spaceL),
        SltBiometricAuth(
          onAuthSuccess: _handleBiometricSuccess,
          onAuthError: _handleBiometricError,
        ),
      ],
    );
  }

  Widget _buildRegisterLink(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.auth.dontHaveAccount, // Corrected
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        SltTextButton(
          text: AppStrings.auth.signUpLink, // Corrected
          onPressed: _navigateToRegister,
        ),
      ],
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    ref.read(authErrorProvider.notifier).clearError();
    final success = await ref
        .read(loginFormStateProvider.notifier)
        .submitLogin();
    if (!success || !context.mounted) return; // Guard clause
    context.go(AppRoutes.main);
  }

  void _handleBiometricSuccess() {
    ref.read(authErrorProvider.notifier).clearError();
    ref.read(authStateProvider.notifier).loginWithBiometric().then((success) {
      if (!context.mounted) return; // Guard clause
      if (success) {
        context.go(AppRoutes.main);
      }
    });
  }

  void _handleBiometricError(String error) {
    ref.read(authErrorProvider.notifier).setError(error);
  }

  void _navigateToRegister() {
    if (!context.mounted) return; // Guard clause
    context.push(AppRoutes.register);
  }

  void _navigateToForgotPassword() {
    if (!context.mounted) return; // Guard clause
    context.push(AppRoutes.forgotPassword); // Corrected
  }
}

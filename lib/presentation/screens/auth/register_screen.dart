// lib/presentation/screens/auth/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_dimens.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/buttons/slt_primary_button.dart';
import '../../widgets/buttons/slt_text_button.dart';
import '../../widgets/cards/slt_card.dart';
import '../../widgets/common/slt_app_bar.dart';
import '../../widgets/common/slt_scaffold.dart';
import '../../widgets/inputs/slt_password_text_field.dart';
import '../../widgets/inputs/slt_text_field.dart';
import '../../widgets/states/slt_error_state_widget.dart';
import '../../widgets/states/slt_loading_state_widget.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(authErrorProvider.notifier).clearError();
      }
    });
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    ref.read(authErrorProvider.notifier).clearError();
    final success = await ref
        .read(registerFormStateProvider.notifier)
        .submitRegistration();
    if (!success || !mounted) return; // Guard clause
    context.go(AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final registerForm = ref.watch(registerFormStateProvider);
    final authError = ref.watch(authErrorProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (authState.isLoading) {
      // Check if authState is loading (during submission)
      return const SltScaffold(
        appBar: SltAppBar(
          title: AppStrings.auth.appBarRegister, // Corrected
          showBackButton: true,
          centerTitle: true,
        ),
        body: SltLoadingStateWidget(
          // This widget's constructor is const
          message: AppStrings.auth.registeringAccount,
          // Corrected & ensured this string is const
          type: LoadingIndicatorType.fadingCircle,
        ),
      );
    }

    return SltScaffold(
      appBar: const SltAppBar(
        title: AppStrings.auth.appBarRegister, // Corrected
        showBackButton: true,
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildRegisterForm(
                theme,
                colorScheme,
                registerForm,
                authError,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterForm(
    ThemeData theme,
    ColorScheme colorScheme,
    RegisterFormModel registerForm,
    String? authError,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(theme, colorScheme),
          const SizedBox(height: AppDimens.spaceL),
          _buildErrorDisplay(authError),
          SltCard(
            padding: const EdgeInsets.all(AppDimens.paddingXL),
            child: Column(
              children: [
                SltTextField(
                  label: AppStrings.auth.firstName,
                  // Corrected
                  hint: AppStrings.auth.enterFirstName,
                  // Corrected
                  prefixIcon: Icons.person_outline,
                  initialValue: registerForm.firstName,
                  // Will work with updated SltTextField
                  errorText: registerForm.firstNameError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updateFirstName(value),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.spaceM),
                SltTextField(
                  label: AppStrings.auth.lastName,
                  // Corrected
                  hint: AppStrings.auth.enterLastName,
                  // Corrected
                  prefixIcon: Icons.person_outline,
                  initialValue: registerForm.lastName,
                  errorText: registerForm.lastNameError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updateLastName(value),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.spaceM),
                SltTextField(
                  label: AppStrings.auth.username,
                  // Corrected
                  hint: AppStrings.auth.enterUsername,
                  // Corrected
                  prefixIcon: Icons.account_circle_outlined,
                  initialValue: registerForm.username,
                  errorText: registerForm.usernameError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updateUsername(value),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.spaceM),
                SltTextField(
                  label: AppStrings.auth.email,
                  // Corrected
                  hint: AppStrings.auth.emailHint,
                  // Corrected
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: registerForm.email,
                  errorText: registerForm.emailError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updateEmail(value),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.spaceM),
                SltPasswordField(
                  label: AppStrings.auth.password,
                  // Corrected
                  hint: AppStrings.auth.enterPassword,
                  // Corrected
                  errorText: registerForm.passwordError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updatePassword(value),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppDimens.spaceM),
                SltPasswordField(
                  label: AppStrings.auth.confirmPassword,
                  // Corrected
                  hint: AppStrings.auth.enterConfirmPassword,
                  // Corrected
                  errorText: registerForm.confirmPasswordError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updateConfirmPassword(value),
                  onEditingComplete: _handleRegistration,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.spaceXL),
          SltPrimaryButton(
            text: AppStrings.auth.registerButton,
            // Corrected
            prefixIcon: Icons.person_add_alt_1_rounded,
            isFullWidth: true,
            size: SltButtonSize.large,
            onPressed: _handleRegistration,
          ),
          const SizedBox(height: AppDimens.spaceL),
          _buildLoginLink(theme, colorScheme),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: [
        Icon(
          Icons.app_registration_rounded,
          size: AppDimens.iconXXL,
          color: colorScheme.primary,
        ),
        const SizedBox(height: AppDimens.spaceM),
        Text(
          AppStrings.auth.registerTitle, // Corrected (User's existing)
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spaceS),
        Text(
          AppStrings.auth.registerSubtitle, // Corrected (User's existing)
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildErrorDisplay(String? authError) {
    if (authError == null || authError.isEmpty)
      return const SizedBox.shrink(); // Guard clause
    return Column(
      children: [
        SltErrorStateWidget(
          title: AppStrings.errors.registrationFailed, // Corrected
          message: authError,
          compact: true,
          onRetry: () => ref.read(authErrorProvider.notifier).clearError(),
        ),
        const SizedBox(height: AppDimens.spaceL),
      ],
    );
  }

  Widget _buildLoginLink(ThemeData theme, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.auth.alreadyHaveAccount, // Corrected
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        SltTextButton(
          text: AppStrings.auth.logInButton,
          // Corrected (using explicit button text)
          onPressed: () {
            if (!context.mounted) return; // Guard clause
            context.go(AppRoutes.login);
          },
        ),
      ],
    );
  }
}

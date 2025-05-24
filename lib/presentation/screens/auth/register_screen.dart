import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_text_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_password_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../core/router/app_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: AppDimens.durationMedium3),
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
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final registerForm = ref.watch(registerFormStateProvider);
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
        showBackButton: true,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: theme.brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
        ),
        onBackPressed: () => context.pop(),
      ),
      body: authState.isLoading
          ? const SltLoadingStateWidget(
              message: 'Creating your account...',
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
                            _buildHeroSection(context, theme, colorScheme),
                            const SizedBox(height: AppDimens.spaceXXL),

                            if (authError != null) ...[
                              SltErrorStateWidget(
                                title: 'Registration Failed',
                                message: authError,
                                compact: true,
                                accentColor: colorScheme.error,
                                onRetry: () => ref
                                    .read(authErrorProvider.notifier)
                                    .clearError(),
                              ),
                              const SizedBox(height: AppDimens.spaceL),
                            ],

                            _buildRegistrationForm(
                              context,
                              theme,
                              colorScheme,
                              registerForm,
                            ),
                            const SizedBox(height: AppDimens.spaceL),

                            _buildPasswordStrengthIndicator(
                              context,
                              theme,
                              colorScheme,
                              registerForm,
                            ),
                            const SizedBox(height: AppDimens.spaceXL),

                            _buildTermsSection(context, theme, colorScheme),
                            const SizedBox(height: AppDimens.spaceXL),

                            _buildActionButtons(context, theme, colorScheme),
                            const SizedBox(height: AppDimens.spaceL),

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
        Container(
          width: AppDimens.iconXXL * 1.2,
          height: AppDimens.iconXXL * 1.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorScheme.secondary,
                colorScheme.secondary.withValues(alpha: 0.8),
                colorScheme.tertiary,
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colorScheme.secondary.withValues(alpha: 0.3),
                blurRadius: AppDimens.shadowRadiusL,
                offset: const Offset(0, AppDimens.shadowOffsetM),
              ),
            ],
          ),
          child: const Icon(
            Icons.person_add_alt_rounded,
            size: AppDimens.iconXL,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppDimens.spaceXL),

        Text(
          'Join Our Community',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimens.spaceM),

        Text(
          'Create your account to start your learning journey and unlock endless possibilities',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRegistrationForm(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    RegisterFormModel registerForm,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
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
          _buildSectionHeader(
            context,
            theme,
            colorScheme,
            'Personal Information',
          ),
          const SizedBox(height: AppDimens.spaceM),

          Row(
            children: [
              Expanded(
                child: SltTextField(
                  label: 'First Name',
                  hint: 'Enter first name',
                  prefixIcon: Icons.person_outline_rounded,
                  errorText: registerForm.firstNameError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updateFirstName(value),
                  textInputAction: TextInputAction.next,
                ),
              ),
              const SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: SltTextField(
                  label: 'Last Name',
                  hint: 'Enter last name',
                  prefixIcon: Icons.person_outline_rounded,
                  errorText: registerForm.lastNameError,
                  onChanged: (value) => ref
                      .read(registerFormStateProvider.notifier)
                      .updateLastName(value),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceXL),

          _buildSectionHeader(
            context,
            theme,
            colorScheme,
            'Account Information',
          ),
          const SizedBox(height: AppDimens.spaceM),

          SltTextField(
            label: 'Username',
            hint: 'Choose a unique username',
            prefixIcon: Icons.account_circle_outlined,
            errorText: registerForm.usernameError,
            onChanged: (value) => ref
                .read(registerFormStateProvider.notifier)
                .updateUsername(value),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDimens.spaceL),

          SltTextField(
            label: 'Email Address',
            hint: 'Enter your email address',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            errorText: registerForm.emailError,
            onChanged: (value) =>
                ref.read(registerFormStateProvider.notifier).updateEmail(value),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDimens.spaceXL),

          _buildSectionHeader(context, theme, colorScheme, 'Password Setup'),
          const SizedBox(height: AppDimens.spaceM),

          SltPasswordField(
            label: 'Password',
            hint: 'Create a strong password',
            prefixIconData: Icons.lock_outline_rounded,
            errorText: registerForm.passwordError,
            onChanged: (value) => ref
                .read(registerFormStateProvider.notifier)
                .updatePassword(value),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDimens.spaceL),

          SltPasswordField(
            label: 'Confirm Password',
            hint: 'Confirm your password',
            prefixIconData: Icons.lock_outline_rounded,
            errorText: registerForm.confirmPasswordError,
            onChanged: (value) => ref
                .read(registerFormStateProvider.notifier)
                .updateConfirmPassword(value),
            onEditingComplete: () => _handleRegister(context, ref),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    String title,
  ) {
    return Row(
      children: [
        Container(
          width: 4,
          height: AppDimens.iconM,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colorScheme.primary, colorScheme.secondary],
            ),
            borderRadius: BorderRadius.circular(AppDimens.radiusXS),
          ),
        ),
        const SizedBox(width: AppDimens.spaceM),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordStrengthIndicator(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    RegisterFormModel registerForm,
  ) {
    final password = registerForm.password;
    final strength = _calculatePasswordStrength(password);

    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            colorScheme.tertiaryContainer.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimens.paddingS),
                decoration: BoxDecoration(
                  color: _getStrengthColor(
                    strength,
                    colorScheme,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimens.radiusS),
                ),
                child: Icon(
                  Icons.security_rounded,
                  color: _getStrengthColor(strength, colorScheme),
                  size: AppDimens.iconM,
                ),
              ),
              const SizedBox(width: AppDimens.spaceM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Strength',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppDimens.spaceXS),
                    Text(
                      _getStrengthText(strength),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getStrengthColor(strength, colorScheme),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.spaceL),

          Container(
            width: double.infinity,
            height: 6,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppDimens.radiusXS),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: strength / 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getStrengthColor(strength, colorScheme),
                      _getStrengthColor(
                        strength,
                        colorScheme,
                      ).withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppDimens.radiusXS),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimens.spaceL),

          Wrap(
            spacing: AppDimens.spaceM,
            runSpacing: AppDimens.spaceS,
            children: [
              _buildPasswordRequirement(
                context,
                theme,
                colorScheme,
                'At least 8 characters',
                password.length >= 8,
              ),
              _buildPasswordRequirement(
                context,
                theme,
                colorScheme,
                'Uppercase letter',
                password.contains(RegExp(r'[A-Z]')),
              ),
              _buildPasswordRequirement(
                context,
                theme,
                colorScheme,
                'Lowercase letter',
                password.contains(RegExp(r'[a-z]')),
              ),
              _buildPasswordRequirement(
                context,
                theme,
                colorScheme,
                'Number',
                password.contains(RegExp(r'[0-9]')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordRequirement(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    String requirement,
    bool isMet,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingM,
        vertical: AppDimens.paddingS,
      ),
      decoration: BoxDecoration(
        color: isMet
            ? colorScheme.primary.withValues(alpha: 0.1)
            : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(
          color: isMet
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isMet
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: AppDimens.iconS,
            color: isMet ? colorScheme.primary : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: AppDimens.spaceS),
          Text(
            requirement,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isMet ? colorScheme.primary : colorScheme.onSurfaceVariant,
              fontWeight: isMet ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsSection(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.2),
            colorScheme.secondaryContainer.withValues(alpha: 0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.policy_rounded,
            color: colorScheme.primary,
            size: AppDimens.iconL,
          ),
          const SizedBox(height: AppDimens.spaceM),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              children: [
                const TextSpan(
                  text: 'By creating an account, you agree to our ',
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
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
    return SltPrimaryButton(
      text: 'Create Account',
      prefixIcon: Icons.person_add_alt_1_rounded,
      isFullWidth: true,
      onPressed: () => _handleRegister(context, ref),
      backgroundColor: colorScheme.secondary,
      foregroundColor: Colors.white,
      elevation: AppDimens.elevationS,
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
              'Already have an account?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SltTextButton(
              text: 'Sign In',
              onPressed: () => context.pop(),
              foregroundColor: colorScheme.primary,
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceM),

        Container(
          padding: const EdgeInsets.all(AppDimens.paddingM),
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
              const SizedBox(width: AppDimens.spaceM),
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
                    const SizedBox(height: AppDimens.spaceXS),
                    Text(
                      'Contact our support team for assistance with account creation',
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

  int _calculatePasswordStrength(String password) {
    int strength = 0;
    if (password.length >= 8) strength++;
    if (password.contains(RegExp(r'[A-Z]'))) strength++;
    if (password.contains(RegExp(r'[a-z]'))) strength++;
    if (password.contains(RegExp(r'[0-9]'))) strength++;
    return strength;
  }

  String _getStrengthText(int strength) {
    switch (strength) {
      case 0:
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return 'Weak';
    }
  }

  Color _getStrengthColor(int strength, ColorScheme colorScheme) {
    switch (strength) {
      case 0:
      case 1:
        return colorScheme.error;
      case 2:
        return Colors.orange;
      case 3:
        return colorScheme.tertiary;
      case 4:
        return colorScheme.primary;
      default:
        return colorScheme.error;
    }
  }

  Future<void> _handleRegister(BuildContext context, WidgetRef ref) async {
    HapticFeedback.lightImpact();
    ref.read(authErrorProvider.notifier).clearError();
    final success = await ref
        .read(registerFormStateProvider.notifier)
        .submitRegistration();

    if (success && context.mounted) {
      HapticFeedback.heavyImpact();
      context.go(AppRoutes.main);
    }
  }
}

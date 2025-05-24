// lib/presentation/screens/auth/forgot_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/constants/app_strings.dart';
import 'package:spaced_learning_app/core/router/app_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_text_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/inputs/slt_text_field.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_success_state_widget.dart';

import '../../widgets/buttons/slt_button_base.dart';

class ForgotPasswordScreen extends ConsumerWidget {
  const ForgotPasswordScreen({super.key});

  Future<void> _handleSubmit(WidgetRef ref) async {
    final formNotifier = ref.read(forgotPasswordFormStateProvider.notifier);
    // Early return if form is invalid.
    if (!formNotifier.validateForm()) {
      return;
    }
    await formNotifier.submitForgotPassword();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final formState = ref.watch(forgotPasswordFormStateProvider);
    // authError will also reflect errors from forgotPasswordFormStateProvider.
    final authError = ref.watch(authErrorProvider);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Show loading state if AuthState is processing the request AND form hasn't been successfully submitted yet.
    if (authState.isLoading && !formState.isSubmitted) {
      return const SltScaffold(
        appBar: SltAppBar(
          title: AppStrings.auth.forgotPasswordTitle,
          showBackButton: true,
          centerTitle: true,
        ),
        body: SltLoadingStateWidget(
          message: AppStrings.auth.sendingResetLink,
          type: LoadingIndicatorType.fadingCircle,
        ),
      );
    }

    // Show success state if the form has been submitted successfully.
    if (formState.isSubmitted) {
      return SltSuccessStateWidget(
        title: AppStrings.auth.resetLinkSentTitle,
        message:
            '${AppStrings.auth.resetLinkSentMessage} ${formState.email}. ${AppStrings.auth.checkSpamFolder}',
        primaryButtonText: AppStrings.general.backToLogin,
        onPrimaryButtonPressed: () {
          // Guard clause for context validity.
          if (!context.mounted) return;
          context.go(AppRoutes.login);
        },
        showAppBar: true,
        appBarTitle: AppStrings.auth.forgotPasswordTitle,
        icon: Icons.mark_email_read_outlined,
      );
    }

    // Default view: Forgot Password Form.
    return SltScaffold(
      appBar: const SltAppBar(
        title: AppStrings.auth.forgotPasswordTitle,
        showBackButton: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.lock_reset_outlined,
              size: AppDimens.iconXXL * 1.5,
              color: colorScheme.primary,
            ),
            const SizedBox(height: AppDimens.spaceXL),
            Text(
              AppStrings.auth.forgotPasswordSubtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimens.spaceXL),

            // Display error message if any, and form has not been successfully submitted.
            _buildErrorDisplay(authError, formState.isSubmitted, ref),

            SltTextField(
              label: AppStrings.auth.email,
              hint: AppStrings.auth.emailHint,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              initialValue: formState.email,
              errorText: formState.emailError,
              onChanged: (value) => ref
                  .read(forgotPasswordFormStateProvider.notifier)
                  .updateEmail(value),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _handleSubmit(ref),
            ),
            const SizedBox(height: AppDimens.spaceXXL),
            SltPrimaryButton(
              text: AppStrings.auth.sendResetLink,
              prefixIcon: Icons.send_outlined,
              isFullWidth: true,
              size: SltButtonSize.large,
              onPressed: () => _handleSubmit(ref),
            ),
            const SizedBox(height: AppDimens.spaceL),
            Center(
              child: SltTextButton(
                text: AppStrings.general.backToLogin,
                onPressed: () {
                  // Guard clause for context validity.
                  if (!context.mounted) return;
                  context.go(AppRoutes.login);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorDisplay(
    String? authError,
    bool isSubmitted,
    WidgetRef ref,
  ) {
    // Guard clause: Do not show error if there is no error or if form was successfully submitted.
    if (authError == null || authError.isEmpty || isSubmitted) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        SltErrorStateWidget(
          title: AppStrings.errors.requestFailedTitle,
          message: authError,
          compact: true, // Use compact mode for in-form errors.
          onRetry: () => ref.read(authErrorProvider.notifier).clearError(),
        ),
        const SizedBox(height: AppDimens.spaceL),
      ],
    );
  }
}

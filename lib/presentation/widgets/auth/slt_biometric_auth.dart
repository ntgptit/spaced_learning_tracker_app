// lib/presentation/widgets/auth/slt_biometric_auth.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/constants/app_strings.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_icon_button.dart'; // Assuming SltIconButton exists and is styled.

// A simple widget to trigger biometric authentication.
class SltBiometricAuth extends ConsumerWidget {
  final VoidCallback onAuthSuccess;
  final Function(String error) onAuthError;

  const SltBiometricAuth({
    super.key,
    required this.onAuthSuccess,
    required this.onAuthError,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the biometric provider's state.
    final biometricState = ref.watch(biometricAuthProvider);

    return SltIconButton(
      // Using SltIconButton as an example.
      icon: Icons.fingerprint_rounded,
      tooltip: AppStrings.auth.loginWithBiometrics,
      iconSize: 32, // A suitable size for a tap target.
      // Disable button while authenticating to prevent multiple attempts.
      onPressed: biometricState.isAuthenticating
          ? null
          : () async {
              final success = await ref
                  .read(biometricAuthProvider.notifier)
                  .authenticate(
                    AppStrings.auth.biometricReason,
                  ); // Use a localized reason from AppStrings.

              // Check if the widget is still mounted before calling callbacks.
              if (!context.mounted) return; // Early return if not mounted.

              if (success) {
                onAuthSuccess();
                return; // Early return on success.
              }

              // If authentication failed, read the latest state to get the error message.
              final latestBiometricState = ref.read(biometricAuthProvider);
              // Fallback error message if specific one isn't set.
              final errorMessage =
                  latestBiometricState.error ??
                  AppStrings.errors.biometricAuthFailed;
              onAuthError(errorMessage);
            },
    );
  }
}

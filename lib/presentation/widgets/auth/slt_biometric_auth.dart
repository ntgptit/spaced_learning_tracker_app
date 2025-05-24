import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/types/auth_messages_ios.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_text_button.dart';

part 'slt_biometric_auth.g.dart';

enum BiometricType { fingerprint, face, none }

enum BiometricAuthState { available, unavailable, notEnrolled, disabled }

@riverpod
class BiometricAvailability extends _$BiometricAvailability {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<BiometricAuthState> build() async {
    return _checkBiometricAvailability();
  }

  Future<BiometricAuthState> _checkBiometricAvailability() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        return BiometricAuthState.unavailable;
      }

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return BiometricAuthState.notEnrolled;
      }

      return BiometricAuthState.available;
    } catch (e) {
      return BiometricAuthState.unavailable;
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _checkBiometricAvailability());
  }
}

@riverpod
class AvailableBiometricTypes extends _$AvailableBiometricTypes {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<List<BiometricType>> build() async {
    return _getAvailableBiometricTypes();
  }

  Future<List<BiometricType>> _getAvailableBiometricTypes() async {
    try {
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      final types = <BiometricType>[];

      if (availableBiometrics.contains(BiometricType.fingerprint)) {
        types.add(BiometricType.fingerprint);
      }
      if (availableBiometrics.contains(BiometricType.face)) {
        types.add(BiometricType.face);
      }

      return types.isEmpty ? [BiometricType.none] : types;
    } catch (e) {
      return [BiometricType.none];
    }
  }
}

class SltBiometricAuth extends ConsumerWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;
  final VoidCallback? onCancel;
  final bool showAlternativeLogin;
  final VoidCallback? onAlternativeLogin;
  final Color? primaryColor;
  final bool autoPrompt;
  final String localizedFallbackTitle;

  const SltBiometricAuth({
    super.key,
    this.title = 'Biometric Authentication',
    this.subtitle = 'Use your fingerprint or face to authenticate',
    this.onSuccess,
    this.onError,
    this.onCancel,
    this.showAlternativeLogin = true,
    this.onAlternativeLogin,
    this.primaryColor,
    this.autoPrompt = false,
    this.localizedFallbackTitle = 'Use Password',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectivePrimaryColor = primaryColor ?? colorScheme.primary;

    final biometricAvailability = ref.watch(biometricAvailabilityProvider);
    final availableTypes = ref.watch(availableBiometricTypesProvider);

    return biometricAvailability.when(
      loading: () => _buildLoadingState(context, theme),
      error: (error, stackTrace) => _buildErrorState(
        context,
        theme,
        'Biometric authentication unavailable',
      ),
      data: (availability) => availability == BiometricAuthState.available
          ? availableTypes.when(
              loading: () => _buildLoadingState(context, theme),
              error: (error, stackTrace) => _buildErrorState(
                context,
                theme,
                'Failed to detect biometric types',
              ),
              data: (types) => _buildAvailableState(
                context,
                theme,
                effectivePrimaryColor,
                types,
              ),
            )
          : _buildUnavailableState(context, theme, availability),
    );
  }

  Widget _buildLoadingState(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingXL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: AppDimens.spaceM),
          Text(
            'Checking biometric availability...',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    ThemeData theme,
    String message,
  ) {
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: AppDimens.iconXL,
            color: colorScheme.error,
          ),
          const SizedBox(height: AppDimens.spaceM),
          Text(
            'Authentication Error',
            style: theme.textTheme.titleLarge?.copyWith(
              color: colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spaceS),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (showAlternativeLogin) ...[
            const SizedBox(height: AppDimens.spaceL),
            SltTextButton(
              text: 'Use Password Instead',
              onPressed: onAlternativeLogin,
              foregroundColor: colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUnavailableState(
    BuildContext context,
    ThemeData theme,
    BiometricAuthState availability,
  ) {
    final colorScheme = theme.colorScheme;
    String message;
    IconData icon;

    switch (availability) {
      case BiometricAuthState.unavailable:
        message = 'Biometric authentication is not available on this device.';
        icon = Icons.fingerprint_rounded;
        break;
      case BiometricAuthState.notEnrolled:
        message =
            'No biometric data enrolled. Please set up biometric authentication in your device settings.';
        icon = Icons.fingerprint_rounded;
        break;
      case BiometricAuthState.disabled:
        message =
            'Biometric authentication is disabled. Please enable it in your device settings.';
        icon = Icons.fingerprint_rounded;
        break;
      default:
        message = 'Biometric authentication is not available.';
        icon = Icons.fingerprint_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: AppDimens.iconXL,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppDimens.spaceM),
          Text(
            'Biometric Unavailable',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spaceS),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          if (showAlternativeLogin) ...[
            const SizedBox(height: AppDimens.spaceL),
            SltPrimaryButton(
              text: 'Use Password',
              onPressed: onAlternativeLogin,
              prefixIcon: Icons.password_rounded,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAvailableState(
    BuildContext context,
    ThemeData theme,
    Color primaryColor,
    List<BiometricType> types,
  ) {
    final colorScheme = theme.colorScheme;

    if (autoPrompt) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _authenticateWithBiometrics(context);
      });
    }

    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildBiometricIcon(types, primaryColor),
          const SizedBox(height: AppDimens.spaceL),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spaceS),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimens.spaceXL),
          SltPrimaryButton(
            text: _getBiometricButtonText(types),
            prefixIcon: _getBiometricButtonIcon(types),
            onPressed: () => _authenticateWithBiometrics(context),
            backgroundColor: primaryColor,
            isFullWidth: true,
          ),
          if (showAlternativeLogin) ...[
            const SizedBox(height: AppDimens.spaceM),
            SltTextButton(
              text: localizedFallbackTitle,
              onPressed: onAlternativeLogin,
              foregroundColor: colorScheme.primary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBiometricIcon(List<BiometricType> types, Color primaryColor) {
    IconData icon;
    if (types.contains(BiometricType.face)) {
      icon = Icons.face_rounded;
    } else if (types.contains(BiometricType.fingerprint)) {
      icon = Icons.fingerprint_rounded;
    } else {
      icon = Icons.security_rounded;
    }

    return Container(
      width: AppDimens.iconXXL,
      height: AppDimens.iconXXL,
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: AppDimens.iconXL, color: primaryColor),
    );
  }

  String _getBiometricButtonText(List<BiometricType> types) {
    if (types.contains(BiometricType.face)) {
      return 'Authenticate with Face ID';
    } else if (types.contains(BiometricType.fingerprint)) {
      return 'Authenticate with Fingerprint';
    } else {
      return 'Authenticate with Biometrics';
    }
  }

  IconData _getBiometricButtonIcon(List<BiometricType> types) {
    if (types.contains(BiometricType.face)) {
      return Icons.face_rounded;
    } else if (types.contains(BiometricType.fingerprint)) {
      return Icons.fingerprint_rounded;
    } else {
      return Icons.security_rounded;
    }
  }

  Future<void> _authenticateWithBiometrics(BuildContext context) async {
    try {
      final localAuth = LocalAuthentication();

      final isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        authMessages: [
          const AndroidAuthMessages(
            signInTitle: 'Biometric Authentication Required',
            biometricHint:
                'Place your finger on the sensor or look at the camera',
            biometricNotRecognized: 'Biometric not recognized, try again',
            biometricSuccess: 'Authentication successful',
            cancelButton: 'Cancel',
            deviceCredentialsRequiredTitle: 'Device credentials required',
            deviceCredentialsSetupDescription:
                'Please set up device credentials',
            goToSettingsButton: 'Go to Settings',
            goToSettingsDescription:
                'Biometric authentication is not set up on your device. Go to Settings > Security to add biometric authentication.',
          ),
          IOSAuthMessages(
            lockOut:
                'Biometric authentication is disabled. Please lock and unlock your screen to enable it.',
            goToSettingsButton: 'Go to Settings',
            goToSettingsDescription:
                'Biometric authentication is not set up on your device. Go to Settings > Touch ID & Passcode or Face ID & Passcode to add biometric authentication.',
            cancelButton: 'Cancel',
            localizedFallbackTitle: localizedFallbackTitle,
          ),
        ],
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );

      if (isAuthenticated) {
        if (onSuccess != null) {
          onSuccess!();
        }
      } else {
        if (onCancel != null) {
          onCancel!();
        }
      }
    } on PlatformException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'NotAvailable':
          errorMessage =
              'Biometric authentication is not available on this device.';
          break;
        case 'NotEnrolled':
          errorMessage =
              'No biometric credentials are enrolled. Please set up biometric authentication in your device settings.';
          break;
        case 'LockedOut':
          errorMessage =
              'Biometric authentication is temporarily locked due to too many failed attempts.';
          break;
        case 'PermanentlyLockedOut':
          errorMessage =
              'Biometric authentication is permanently locked. Please use your device passcode.';
          break;
        case 'BiometricOnlyNotSupported':
          errorMessage =
              'Biometric-only authentication is not supported on this device.';
          break;
        default:
          errorMessage = 'Biometric authentication failed. Please try again.';
      }

      if (context.mounted) {
        _showErrorSnackBar(context, errorMessage);
      }

      if (onError != null) {
        onError!();
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(
          context,
          'An unexpected error occurred during authentication.',
        );
      }

      if (onError != null) {
        onError!();
      }
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(AppDimens.paddingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
        ),
      ),
    );
  }
}

class SltBiometricAuthDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;
  final VoidCallback? onCancel;
  final bool showAlternativeLogin;
  final VoidCallback? onAlternativeLogin;
  final Color? primaryColor;
  final bool barrierDismissible;

  const SltBiometricAuthDialog({
    super.key,
    this.title = 'Biometric Authentication',
    this.subtitle = 'Use your fingerprint or face to authenticate',
    this.onSuccess,
    this.onError,
    this.onCancel,
    this.showAlternativeLogin = true,
    this.onAlternativeLogin,
    this.primaryColor,
    this.barrierDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
      ),
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      contentPadding: EdgeInsets.zero,
      content: SltBiometricAuth(
        title: title,
        subtitle: subtitle,
        onSuccess: () {
          Navigator.of(context).pop(true);
          if (onSuccess != null) {
            onSuccess!();
          }
        },
        onError: () {
          if (onError != null) {
            onError!();
          }
        },
        onCancel: () {
          Navigator.of(context).pop(false);
          if (onCancel != null) {
            onCancel!();
          }
        },
        showAlternativeLogin: showAlternativeLogin,
        onAlternativeLogin: () {
          Navigator.of(context).pop('alternative');
          if (onAlternativeLogin != null) {
            onAlternativeLogin!();
          }
        },
        primaryColor: primaryColor,
        autoPrompt: true,
      ),
    );
  }

  static Future<dynamic> show(
    BuildContext context, {
    String title = 'Biometric Authentication',
    String subtitle = 'Use your fingerprint or face to authenticate',
    VoidCallback? onSuccess,
    VoidCallback? onError,
    VoidCallback? onCancel,
    bool showAlternativeLogin = true,
    VoidCallback? onAlternativeLogin,
    Color? primaryColor,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => SltBiometricAuthDialog(
        title: title,
        subtitle: subtitle,
        onSuccess: onSuccess,
        onError: onError,
        onCancel: onCancel,
        showAlternativeLogin: showAlternativeLogin,
        onAlternativeLogin: onAlternativeLogin,
        primaryColor: primaryColor,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}

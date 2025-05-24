// lib/presentation/viewmodels/auth_viewmodel.dart
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// For actual biometric functionality, uncomment and ensure 'local_auth' is in pubspec.yaml
// import 'package:local_auth/local_auth.dart';
import 'package:spaced_learning_app/domain/models/auth_response.dart';
import 'package:spaced_learning_app/domain/models/user.dart';

import '../../core/constants/app_strings.dart';
import '../../core/di/providers.dart';
import '../../core/utils/string_utils.dart';

part 'auth_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Future<bool> build() async {
    return _checkAuthentication();
  }

  // Checks if the user is currently authenticated by validating stored tokens.
  Future<bool> _checkAuthentication() async {
    try {
      final token = await ref.read(storageServiceProvider).getToken();
      // Early return if no token is found.
      if (token == null || token.isEmpty) {
        return false;
      }

      try {
        // Validate token with the backend.
        final isValid = await ref
            .read(authRepositoryProvider)
            .validateToken(token);

        // Early return if token is not valid.
        if (!isValid) {
          await ref.read(storageServiceProvider).clearTokens();
          return false;
        }

        // If token is valid, load user data from storage.
        final userData = await ref.read(storageServiceProvider).getUserData();
        if (userData != null) {
          ref
              .read(currentUserProvider.notifier)
              .updateUser(User.fromJson(userData));
        }
        return true;
      } catch (e) {
        debugPrint('Token validation error: $e');
        // Error during validation, assume token is invalid and clear.
        await ref.read(storageServiceProvider).clearTokens();
        return false;
      }
    } catch (e) {
      debugPrint('Critical authentication check error: $e');
      // Critical error, reset storage as a precaution.
      await ref.read(storageServiceProvider).resetSecureStorage();
      return false;
    }
  }

  // Attempts to log in the user with the provided credentials.
  Future<bool> login(String usernameOrEmail, String password) async {
    state = const AsyncValue.loading();
    try {
      final response = await ref
          .read(authRepositoryProvider)
          .login(usernameOrEmail, password);
      await _handleAuthResponse(response);
      state = const AsyncValue.data(true);
      return true;
    } catch (e) {
      debugPrint('Login error: $e');
      state = AsyncValue.error(e, StackTrace.current);
      ref.read(authErrorProvider.notifier).setError(e.toString());
      return false;
    }
  }

  // Attempts to register a new user.
  Future<bool> register(
    String username,
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    state = const AsyncValue.loading();
    try {
      final response = await ref
          .read(authRepositoryProvider)
          .register(username, email, password, firstName, lastName);
      await _handleAuthResponse(response);
      state = const AsyncValue.data(true);
      return true;
    } catch (e) {
      debugPrint('Registration error: $e');
      state = AsyncValue.error(e, StackTrace.current);
      ref.read(authErrorProvider.notifier).setError(e.toString());
      return false;
    }
  }

  // Logs out the current user.
  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(storageServiceProvider).clearTokens();
      await ref.read(storageServiceProvider).clearUserData();
      ref.read(currentUserProvider.notifier).updateUser(null);
      state = const AsyncValue.data(false);
    } catch (e) {
      debugPrint('Logout error: $e');
      // Ensure user is logged out client-side even if server call fails.
      ref.read(currentUserProvider.notifier).updateUser(null);
      state = AsyncValue.error(e, StackTrace.current);
      ref.read(authErrorProvider.notifier).setError(e.toString());
    }
  }

  // Requests a password reset for the given email.
  Future<bool> forgotPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      // Placeholder: await ref.read(authRepositoryProvider).forgotPassword(email);
      await Future.delayed(
        const Duration(seconds: 2),
      ); // Simulate network delay
      // Keep current auth state value (true if logged in, false if not).
      state = AsyncValue.data(state.value ?? false);
      return true;
    } catch (e) {
      debugPrint('Forgot password error: $e');
      state = AsyncValue.error(e, StackTrace.current);
      ref.read(authErrorProvider.notifier).setError(e.toString());
      return false;
    }
  }

  // Handles login after successful biometric authentication.
  Future<bool> loginWithBiometric() async {
    state = const AsyncValue.loading();
    try {
      // In a real app, retrieve stored credentials or a biometric-specific token
      // For simulation:
      await Future.delayed(const Duration(seconds: 1));
      const mockUser = User(
        id: 'bio_user_id_123',
        username: 'biometric_user_flutter',
        email: 'bio.user@example.com',
        firstName: 'BioUser',
        lastName: 'Authenticated',
      );
      const mockAuthResponse = AuthResponse(
        token: 'fake_biometric_auth_token_xyz',
        user: mockUser,
      );

      await _handleAuthResponse(mockAuthResponse);
      state = const AsyncValue.data(true);
      return true;
    } catch (e) {
      debugPrint('Biometric login error: $e');
      state = AsyncValue.error(e, StackTrace.current);
      ref.read(authErrorProvider.notifier).setError(e.toString());
      return false;
    }
  }

  // Handles the response from login/registration by saving token and user data.
  Future<void> _handleAuthResponse(AuthResponse response) async {
    try {
      await ref.read(storageServiceProvider).saveToken(response.token);
      // Save refresh token if available.
      if (response.refreshToken != null && response.refreshToken!.isNotEmpty) {
        await ref
            .read(storageServiceProvider)
            .saveRefreshToken(response.refreshToken!);
      }
      await ref
          .read(storageServiceProvider)
          .saveUserData(response.user.toJson());
      ref.read(currentUserProvider.notifier).updateUser(response.user);
    } catch (e) {
      debugPrint('Error handling auth response: $e');
      // Still update the user in memory if saving to storage fails.
      ref.read(currentUserProvider.notifier).updateUser(response.user);
      rethrow; // Rethrow to allow calling function to handle.
    }
  }
}

// Manages the currently logged-in user's data.
@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() {
    return null; // No user logged in initially.
  }

  void updateUser(User? user) {
    state = user;
  }
}

// Manages authentication-related error messages from various sources.
@riverpod
class AuthError extends _$AuthError {
  @override
  String? build() {
    // Listen to general authentication state errors.
    final authAsyncValue = ref.watch(authStateProvider);
    if (authAsyncValue.hasError && authAsyncValue.error != null) {
      return authAsyncValue.error.toString();
    }

    // Listen to forgot password form submission errors.
    final forgotPasswordForm = ref.watch(forgotPasswordFormStateProvider);
    if (forgotPasswordForm.submissionError != null) {
      return forgotPasswordForm.submissionError;
    }

    // Listen to biometric authentication errors.
    final biometricState = ref.watch(biometricAuthProvider);
    if (biometricState.error != null && biometricState.error!.isNotEmpty) {
      return biometricState.error;
    }

    return null; // No error.
  }

  void setError(String? message) {
    state = message;
  }

  void clearError() {
    state = null;
  }
}

// Login Form Management
@riverpod
class LoginFormState extends _$LoginFormState {
  @override
  LoginFormModel build() => const LoginFormModel();

  void updateUsernameOrEmail(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.usernameOrEmailRequired;
    }
    state = state.copyWith(usernameOrEmail: value, usernameOrEmailError: error);
  }

  void updatePassword(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.passwordRequired;
    }
    if (value.isNotEmpty && value.length < 8) {
      // Check only if not empty
      error = AppStrings.errors.passwordTooShort;
    }
    state = state.copyWith(password: value, passwordError: error);
  }

  // Validates the entire login form.
  bool validateForm() {
    // Trigger validation for display and get current state.
    updateUsernameOrEmail(state.usernameOrEmail);
    updatePassword(state.password);
    return state.usernameOrEmailError == null && state.passwordError == null;
  }

  // Submits the login form.
  Future<bool> submitLogin() async {
    // Early return if form is not valid.
    if (!validateForm()) {
      return false;
    }
    ref.read(authErrorProvider.notifier).clearError(); // Clear previous errors.
    final authNotifier = ref.read(authStateProvider.notifier);
    return authNotifier.login(state.usernameOrEmail, state.password);
  }
}

// Register Form Management
@riverpod
class RegisterFormState extends _$RegisterFormState {
  @override
  RegisterFormModel build() => const RegisterFormModel();

  void updateFirstName(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.firstNameRequired;
    }
    state = state.copyWith(firstName: value, firstNameError: error);
  }

  void updateLastName(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.lastNameRequired;
    }
    state = state.copyWith(lastName: value, lastNameError: error);
  }

  void updateUsername(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.usernameRequired;
    }
    if (value.isNotEmpty && value.length < 3) {
      error = AppStrings.errors.usernameTooShort;
    }
    if (value.isNotEmpty && !RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(value)) {
      error = AppStrings.errors.invalidUsernameFormat;
    }
    state = state.copyWith(username: value, usernameError: error);
  }

  void updateEmail(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.emailRequired;
    }
    if (value.isNotEmpty && !StringUtils.isValidEmail(value)) {
      error = AppStrings.errors.invalidEmail;
    }
    state = state.copyWith(email: value, emailError: error);
  }

  void updatePassword(String value) {
    String? passwordError;
    String? confirmPasswordError =
        state.confirmPasswordError; // Preserve current confirm error.
    final confirmPassword = state.confirmPassword;

    if (value.isEmpty) {
      passwordError = AppStrings.errors.passwordRequired;
    }
    if (value.isNotEmpty && value.length < 8) {
      passwordError = AppStrings.errors.passwordTooShort;
    }

    // Re-validate confirm password if it's not empty.
    if (confirmPassword.isNotEmpty && confirmPassword != value) {
      confirmPasswordError = AppStrings.errors.passwordsDoNotMatch;
    }
    if (confirmPassword.isNotEmpty && confirmPassword == value) {
      confirmPasswordError =
          null; // Clear confirm error if passwords now match.
    }
    state = state.copyWith(
      password: value,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }

  void updateConfirmPassword(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.confirmPasswordRequired;
    }
    if (value.isNotEmpty && value != state.password) {
      error = AppStrings.errors.passwordsDoNotMatch;
    }
    state = state.copyWith(confirmPassword: value, confirmPasswordError: error);
  }

  // Validates the entire registration form.
  bool validateForm() {
    // Trigger individual validations to update error messages.
    updateFirstName(state.firstName);
    updateLastName(state.lastName);
    updateUsername(state.username);
    updateEmail(state.email);
    updatePassword(state.password);
    updateConfirmPassword(state.confirmPassword);

    return state.firstNameError == null &&
        state.lastNameError == null &&
        state.usernameError == null &&
        state.emailError == null &&
        state.passwordError == null &&
        state.confirmPasswordError == null;
  }

  // Submits the registration form.
  Future<bool> submitRegistration() async {
    // Early return if form is not valid.
    if (!validateForm()) {
      return false;
    }
    ref.read(authErrorProvider.notifier).clearError(); // Clear previous errors.
    final authNotifier = ref.read(authStateProvider.notifier);
    return authNotifier.register(
      state.username,
      state.email,
      state.password,
      state.firstName,
      state.lastName,
    );
  }
}

// Forgot Password Form Management
@riverpod
class ForgotPasswordFormState extends _$ForgotPasswordFormState {
  @override
  ForgotPasswordFormModel build() => const ForgotPasswordFormModel();

  void updateEmail(String value) {
    String? error;
    if (value.isEmpty) {
      error = AppStrings.errors.emailRequired;
    }
    if (value.isNotEmpty && !StringUtils.isValidEmail(value)) {
      error = AppStrings.errors.invalidEmail;
    }
    // Reset submission status and error on email change.
    state = state.copyWith(
      email: value,
      emailError: error,
      submissionError: null,
      isSubmitted: false,
    );
  }

  // Validates the forgot password form.
  bool validateForm() {
    updateEmail(state.email); // Trigger validation for display.
    return state.emailError == null;
  }

  // Submits the forgot password request.
  Future<bool> submitForgotPassword() async {
    // Early return if form is not valid.
    if (!validateForm()) {
      state = state.copyWith(
        isSubmitted: false,
      ); // Ensure isSubmitted is false if validation fails.
      return false;
    }
    ref.read(authErrorProvider.notifier).clearError(); // Clear previous errors.
    final authNotifier = ref.read(authStateProvider.notifier);
    final success = await authNotifier.forgotPassword(state.email);

    // Update state based on submission success or failure.
    if (success) {
      state = state.copyWith(isSubmitted: true, submissionError: null);
      return true;
    }
    // AuthState handles setting the error, AuthError provider will pick it up.
    state = state.copyWith(
      isSubmitted: false,
      submissionError: ref.read(authErrorProvider),
    );
    return false;
  }
}

// Biometric Authentication Management
@riverpod
class BiometricAuth extends _$BiometricAuth {
  // This generates 'biometricAuthProvider'
  @override
  BiometricAuthModel build() {
    return const BiometricAuthModel(); // Initial state.
  }

  // Checks if biometric authentication is available on the device.
  Future<void> checkAvailability() async {
    // final localAuth = LocalAuthentication(); // For real implementation
    try {
      // In a real app, use a plugin like local_auth:
      // final bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      // final bool isDeviceSupported = await localAuth.isDeviceSupported();
      // state = state.copyWith(isAvailable: canCheckBiometrics && isDeviceSupported, clearError: true);
      await Future.delayed(
        const Duration(milliseconds: 300),
      ); // Simulate check.
      state = state.copyWith(
        isAvailable: true,
        clearError: true,
      ); // Simulate available.
    } catch (e) {
      debugPrint('Biometric availability check error: $e');
      state = state.copyWith(
        isAvailable: false,
        error: '${AppStrings.errors.biometricCheckFailed}: ${e.toString()}',
      );
    }
  }

  // Attempts to authenticate the user using biometrics.
  Future<bool> authenticate(String localizedReason) async {
    state = state.copyWith(isAuthenticating: true, clearError: true);
    // final localAuth = LocalAuthentication(); // For real implementation
    try {
      // In a real app:
      // final bool didAuthenticate = await localAuth.authenticate(
      //   localizedReason: localizedReason,
      //   options: const AuthenticationOptions(
      //     stickyAuth: true, // Keep auth dialog open on app switch.
      //     biometricOnly: true, // Use only biometric, not device credentials.
      //   ),
      // );
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate authentication.
      const bool didAuthenticate =
          true; // Simulate success, set to false to test error.

      // Early return if authentication failed.
      if (!didAuthenticate) {
        state = state.copyWith(
          isAuthenticating: false,
          error: AppStrings.errors.biometricAuthFailedByUser,
        );
        return false;
      }

      state = state.copyWith(isAuthenticating: false);
      return true;
    } catch (e) {
      // PlatformException from local_auth, or other errors.
      debugPrint('Biometric authentication error: $e');
      state = state.copyWith(
        isAuthenticating: false,
        error: '${AppStrings.errors.biometricErrorPrefix} ${e.toString()}',
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

// Data Models for Form States & Biometric Auth

class LoginFormModel {
  final String usernameOrEmail;
  final String password;
  final String? usernameOrEmailError;
  final String? passwordError;

  const LoginFormModel({
    this.usernameOrEmail = '',
    this.password = '',
    this.usernameOrEmailError,
    this.passwordError,
  });

  LoginFormModel copyWith({
    String? usernameOrEmail,
    String? password,
    String? usernameOrEmailError,
    String? passwordError,
  }) {
    return LoginFormModel(
      usernameOrEmail: usernameOrEmail ?? this.usernameOrEmail,
      password: password ?? this.password,
      usernameOrEmailError: usernameOrEmailError ?? this.usernameOrEmailError,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}

class RegisterFormModel {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String? firstNameError;
  final String? lastNameError;
  final String? usernameError;
  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  const RegisterFormModel({
    this.firstName = '',
    this.lastName = '',
    this.username = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstNameError,
    this.lastNameError,
    this.usernameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  RegisterFormModel copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    String? firstNameError,
    String? lastNameError,
    String? usernameError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return RegisterFormModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstNameError: firstNameError ?? this.firstNameError,
      lastNameError: lastNameError ?? this.lastNameError,
      usernameError: usernameError ?? this.usernameError,
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
    );
  }
}

class ForgotPasswordFormModel {
  final String email;
  final String? emailError;
  final bool isSubmitted; // Tracks if the form was successfully submitted.
  final String? submissionError; // Specific error from the submission attempt.

  const ForgotPasswordFormModel({
    this.email = '',
    this.emailError,
    this.isSubmitted = false,
    this.submissionError,
  });

  ForgotPasswordFormModel copyWith({
    String? email,
    String? emailError,
    bool? isSubmitted,
    String? submissionError,
  }) {
    return ForgotPasswordFormModel(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      submissionError: submissionError ?? this.submissionError,
    );
  }
}

// Model for biometric authentication state.
class BiometricAuthModel {
  final bool isAvailable;
  final bool isAuthenticating;
  final String? error;

  const BiometricAuthModel({
    this.isAvailable = false,
    this.isAuthenticating = false,
    this.error,
  });

  BiometricAuthModel copyWith({
    bool? isAvailable,
    bool? isAuthenticating,
    String? error,
    bool clearError = false, // Helper to easily clear/reset the error.
  }) {
    return BiometricAuthModel(
      isAvailable: isAvailable ?? this.isAvailable,
      isAuthenticating: isAuthenticating ?? this.isAuthenticating,
      // If clearError is true, error becomes null, otherwise uses provided error or existing one.
      error: clearError ? null : error ?? this.error,
    );
  }
}

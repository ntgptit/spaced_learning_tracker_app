import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/domain/models/auth_response.dart';
import 'package:spaced_learning_app/domain/models/user.dart';

import '../../core/di/providers.dart';
import '../../core/utils/string_utils.dart';

part 'auth_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  @override
  Future<bool> build() async {
    return _checkAuthentication();
  }

  Future<bool> _checkAuthentication() async {
    try {
      final token = await ref.read(storageServiceProvider).getToken();
      if (token == null || token.isEmpty) {
        return false;
      }

      try {
        final isValid = await ref
            .read(authRepositoryProvider)
            .validateToken(token);

        if (isValid) {
          final userData = await ref.read(storageServiceProvider).getUserData();
          if (userData != null) {
            ref
                .read(currentUserProvider.notifier)
                .updateUser(User.fromJson(userData));
          }
          return true;
        }

        await ref.read(storageServiceProvider).clearTokens();
        return false;
      } catch (e) {
        debugPrint('Token validation error: $e');
        await ref.read(storageServiceProvider).clearTokens();
        return false;
      }
    } catch (e) {
      debugPrint('Critical authentication check error: $e');
      await ref.read(storageServiceProvider).resetSecureStorage();
      return false;
    }
  }

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
      return false;
    }
  }

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
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).forgotPassword(email);
      state = const AsyncValue.data(true);
      return true;
    } catch (e) {
      debugPrint('Forgot password error: $e');
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> resetPassword(String token, String newPassword) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(authRepositoryProvider).resetPassword(token, newPassword);
      state = const AsyncValue.data(true);
      return true;
    } catch (e) {
      debugPrint('Reset password error: $e');
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(storageServiceProvider).clearTokens();
      await ref.read(storageServiceProvider).clearUserData();
      ref.read(currentUserProvider.notifier).updateUser(null);
      state = const AsyncValue.data(false);
    } catch (e) {
      debugPrint('Logout error: $e');
      ref.read(currentUserProvider.notifier).updateUser(null);
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> _handleAuthResponse(AuthResponse response) async {
    try {
      await ref.read(storageServiceProvider).saveToken(response.token);
      if (response.refreshToken != null) {
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
      ref.read(currentUserProvider.notifier).updateUser(response.user);
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() {
    return null;
  }

  void updateUser(User? user) {
    state = user;
  }
}

@riverpod
class AuthError extends _$AuthError {
  @override
  String? build() {
    final authState = ref.watch(authStateProvider);
    return authState.hasError ? authState.error.toString() : null;
  }

  void clearError() {
    state = null;
  }
}

@riverpod
class LoginFormState extends _$LoginFormState {
  @override
  LoginFormModel build() => const LoginFormModel();

  void updateUsernameOrEmail(String value) {
    String? error;
    if (value.isEmpty) {
      error = 'Username or email is required';
    }

    state = state.copyWith(usernameOrEmail: value, usernameOrEmailError: error);
  }

  void updatePassword(String value) {
    String? error;
    if (value.isEmpty) {
      error = 'Password is required';
    } else if (value.length < 8) {
      error = 'Password must be at least 8 characters';
    }

    state = state.copyWith(password: value, passwordError: error);
  }

  bool validateForm() {
    updateUsernameOrEmail(state.usernameOrEmail);
    updatePassword(state.password);

    return state.usernameOrEmailError == null && state.passwordError == null;
  }

  Future<bool> submitLogin() async {
    if (!validateForm()) {
      return false;
    }

    final authNotifier = ref.read(authStateProvider.notifier);
    return authNotifier.login(state.usernameOrEmail, state.password);
  }
}

@riverpod
class RegisterFormState extends _$RegisterFormState {
  @override
  RegisterFormModel build() => const RegisterFormModel();

  void updateFirstName(String value) {
    String? error;
    if (value.isEmpty) {
      error = 'First name is required';
    }

    state = state.copyWith(firstName: value, firstNameError: error);
  }

  void updateLastName(String value) {
    String? error;
    if (value.isEmpty) {
      error = 'Last name is required';
    }

    state = state.copyWith(lastName: value, lastNameError: error);
  }

  void updateUsername(String value) {
    String? error;
    if (value.isEmpty) {
      error = 'Username is required';
    } else if (value.length < 3) {
      error = 'Username must be at least 3 characters';
    } else if (!RegExp(r'^[a-zA-Z0-9._-]+$').hasMatch(value)) {
      error =
          'Username can only contain letters, numbers, dots, underscores and hyphens';
    }

    state = state.copyWith(username: value, usernameError: error);
  }

  void updateEmail(String value) {
    String? error;
    if (value.isEmpty) {
      error = 'Email is required';
    } else if (!StringUtils.isValidEmail(value)) {
      error = 'Enter a valid email address';
    }

    state = state.copyWith(email: value, emailError: error);
  }

  void updatePassword(String value) {
    String? error;
    final confirmPassword = state.confirmPassword;

    if (value.isEmpty) {
      error = 'Password is required';
    } else if (value.length < 8) {
      error = 'Password must be at least 8 characters';
    }

    state = state.copyWith(password: value, passwordError: error);

    if (confirmPassword.isNotEmpty && confirmPassword != value) {
      state = state.copyWith(confirmPasswordError: 'Passwords do not match');
    } else if (confirmPassword.isNotEmpty && confirmPassword == value) {
      state = state.copyWith(confirmPasswordError: null);
    }
  }

  void updateConfirmPassword(String value) {
    String? error;

    if (value.isEmpty) {
      error = 'Please confirm your password';
    } else if (value != state.password) {
      error = 'Passwords do not match';
    }

    state = state.copyWith(confirmPassword: value, confirmPasswordError: error);
  }

  bool validateForm() {
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

  Future<bool> submitRegistration() async {
    if (!validateForm()) {
      return false;
    }

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

@riverpod
class ForgotPasswordFormState extends _$ForgotPasswordFormState {
  @override
  ForgotPasswordFormModel build() => const ForgotPasswordFormModel();

  void updateEmail(String value) {
    String? error;
    if (value.isEmpty) {
      error = 'Email is required';
    } else if (!StringUtils.isValidEmail(value)) {
      error = 'Enter a valid email address';
    }

    state = state.copyWith(email: value, emailError: error);
  }

  void resetEmailSentState() {
    state = state.copyWith(isEmailSent: false);
  }

  bool validateForm() {
    updateEmail(state.email);
    return state.emailError == null;
  }

  Future<bool> submitForgotPassword() async {
    if (!validateForm()) {
      return false;
    }

    final authNotifier = ref.read(authStateProvider.notifier);
    final success = await authNotifier.forgotPassword(state.email);

    if (success) {
      state = state.copyWith(isEmailSent: true);
    }

    return success;
  }
}

@riverpod
class ResetPasswordFormState extends _$ResetPasswordFormState {
  @override
  ResetPasswordFormModel build() => const ResetPasswordFormModel();

  void updatePassword(String value) {
    String? error;
    final confirmPassword = state.confirmPassword;

    if (value.isEmpty) {
      error = 'Password is required';
    } else if (value.length < 8) {
      error = 'Password must be at least 8 characters';
    }

    state = state.copyWith(password: value, passwordError: error);

    if (confirmPassword.isNotEmpty && confirmPassword != value) {
      state = state.copyWith(confirmPasswordError: 'Passwords do not match');
    } else if (confirmPassword.isNotEmpty && confirmPassword == value) {
      state = state.copyWith(confirmPasswordError: null);
    }
  }

  void updateConfirmPassword(String value) {
    String? error;

    if (value.isEmpty) {
      error = 'Please confirm your password';
    } else if (value != state.password) {
      error = 'Passwords do not match';
    }

    state = state.copyWith(confirmPassword: value, confirmPasswordError: error);
  }

  bool validateForm() {
    updatePassword(state.password);
    updateConfirmPassword(state.confirmPassword);

    return state.passwordError == null && state.confirmPasswordError == null;
  }

  Future<bool> submitResetPassword(String token) async {
    if (!validateForm()) {
      return false;
    }

    final authNotifier = ref.read(authStateProvider.notifier);
    return authNotifier.resetPassword(token, state.password);
  }
}


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
      usernameOrEmailError: usernameOrEmailError,
      passwordError: passwordError,
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
      firstNameError: firstNameError,
      lastNameError: lastNameError,
      usernameError: usernameError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }
}

class ForgotPasswordFormModel {
  final String email;
  final String? emailError;
  final bool isEmailSent;

  const ForgotPasswordFormModel({
    this.email = '',
    this.emailError,
    this.isEmailSent = false,
  });

  ForgotPasswordFormModel copyWith({
    String? email,
    String? emailError,
    bool? isEmailSent,
  }) {
    return ForgotPasswordFormModel(
      email: email ?? this.email,
      emailError: emailError,
      isEmailSent: isEmailSent ?? this.isEmailSent,
    );
  }
}

class ResetPasswordFormModel {
  final String password;
  final String confirmPassword;
  final String? passwordError;
  final String? confirmPasswordError;

  const ResetPasswordFormModel({
    this.password = '',
    this.confirmPassword = '',
    this.passwordError,
    this.confirmPasswordError,
  });

  ResetPasswordFormModel copyWith({
    String? password,
    String? confirmPassword,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return ResetPasswordFormModel(
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
    );
  }
}

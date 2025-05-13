import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/register_use_case.dart';

part 'register_view_model.g.dart';

/// Register state to manage UI state
class RegisterState {
  final bool isLoading;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final String? errorMessage;
  final bool isRegisterSuccess;

  const RegisterState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.errorMessage,
    this.isRegisterSuccess = false,
  });

  /// Create a copy of this state with given fields replaced with new values
  RegisterState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    String? errorMessage,
    bool? isRegisterSuccess,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      errorMessage: errorMessage,
      isRegisterSuccess: isRegisterSuccess ?? this.isRegisterSuccess,
    );
  }
}

/// Register view model
@riverpod
class RegisterViewModel extends _$RegisterViewModel {
  late final RegisterUseCase _registerUseCase;

  @override
  RegisterState build() {
    _registerUseCase = ref.read(registerUseCaseProvider);
    return const RegisterState();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    state = state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    );
  }

  /// Toggle confirm password visibility
  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  /// Clear error message
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }

  /// Perform registration
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Reset error and set loading
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isRegisterSuccess: false,
    );

    final params = RegisterParams(
      name: name,
      email: email,
      password: password,
    );

    final result = await _registerUseCase(params);

    return result.when(
      success: (user) {
        // Registration successful
        state = state.copyWith(
          isLoading: false,
          isRegisterSuccess: true,
        );
        return true;
      },
      failure: (failure) {
        // Registration failed
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  /// Validate name input
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  /// Validate email input
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validate password input
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasDigits = value.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacters =
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase || !hasDigits || !hasSpecialCharacters) {
      return 'Password must contain uppercase, number, and special character';
    }

    return null;
  }

  /// Validate confirm password input
  String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}

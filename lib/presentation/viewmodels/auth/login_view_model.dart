import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/usecases/login_use_case.dart';

part 'login_view_model.g.dart';

/// Login state to manage UI state
class LoginState {
  final bool isLoading;
  final bool isPasswordVisible;
  final String? errorMessage;
  final bool isLoginSuccess;

  const LoginState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage,
    this.isLoginSuccess = false,
  });

  /// Create a copy of this state with given fields replaced with new values
  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    String? errorMessage,
    bool? isLoginSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
      isLoginSuccess: isLoginSuccess ?? this.isLoginSuccess,
    );
  }
}

/// Login view model
@riverpod
class LoginViewModel extends _$LoginViewModel {
  late final LoginUseCase _loginUseCase;

  @override
  LoginState build() {
    _loginUseCase = ref.read(loginUseCaseProvider);
    return const LoginState();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    state = state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    );
  }

  /// Clear error message
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }

  /// Perform login
  Future<bool> login(String email, String password) async {
    // Reset error and set loading
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      isLoginSuccess: false,
    );

    final params = LoginParams(email: email, password: password);
    final result = await _loginUseCase(params);

    return result.when(
      success: (user) {
        // Login successful
        state = state.copyWith(
          isLoading: false,
          isLoginSuccess: true,
        );
        return true;
      },
      failure: (failure) {
        // Login failed
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
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

    return null;
  }
}

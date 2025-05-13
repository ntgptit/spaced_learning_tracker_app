import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slt_app/core/architecture/result.dart';
import 'package:slt_app/domain/entities/user.dart';

import '../../core/architecture/failure.dart';

part 'auth_repository.g.dart';

/// Auth repository provider
@riverpod
AuthRepository authRepository(Ref ref) {
  // In a real app, you would inject the repository implementation here
  // For now, we'll return a fake implementation for demo purposes
  return FakeAuthRepository();
}

/// Auth repository interface
abstract class AuthRepository {
  /// Login a user with email and password
  Future<Result<User>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<Result<User>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Logout the current user
  Future<Result<bool>> logout();

  /// Get the current authenticated user
  Future<Result<User>> getCurrentUser();

  /// Request password reset
  Future<Result<bool>> forgotPassword(String email);

  /// Verify if a user is logged in
  Future<bool> isLoggedIn();
}

/// Fake auth repository implementation for demo purposes
class FakeAuthRepository implements AuthRepository {
  // Simulate a user database
  final Map<String, User> _users = {};
  User? _currentUser;

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Simple validation
    if (email.isEmpty || password.isEmpty) {
      return const Result.failure(
        ValidationFailure(
          message: 'Email and password are required',
          errors: {
            'email': ['Email is required'],
            'password': ['Password is required']
          },
        ),
      );
    }

    // Check if the user exists
    final normalizedEmail = email.toLowerCase().trim();
    final user = _users.values
        .where((u) => u.email.toLowerCase() == normalizedEmail)
        .firstOrNull;

    if (user == null) {
      return const Result.failure(
        NotFoundFailure(
          message: 'No user found with this email address',
        ),
      );
    }

    // In a real app, you would verify the password hash here
    // For demo purposes, we're just simulating successful login

    _currentUser = user;

    return Result.success(user);
  }

  @override
  Future<Result<User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Simple validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      return const Result.failure(
        ValidationFailure(
          message: 'All fields are required',
          errors: {
            'name': ['Name is required'],
            'email': ['Email is required'],
            'password': ['Password is required'],
          },
        ),
      );
    }

    // Check if the email is already registered
    final normalizedEmail = email.toLowerCase().trim();
    final existingUser = _users.values
        .where((u) => u.email.toLowerCase() == normalizedEmail)
        .firstOrNull;

    if (existingUser != null) {
      return const Result.failure(
        ValidationFailure(
          message: 'Email already registered',
          errors: {
            'email': ['This email is already registered']
          },
        ),
      );
    }

    // Create a new user
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      createdAt: DateTime.now(),
      isEmailVerified: false,
    );

    // Save the user
    _users[newUser.id] = newUser;

    return Result.success(newUser);
  }

  @override
  Future<Result<bool>> logout() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _currentUser = null;

    return const Result.success(true);
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (_currentUser == null) {
      return const Result.failure(
        AuthenticationFailure(
          message: 'User not authenticated',
        ),
      );
    }

    return Result.success(_currentUser!);
  }

  @override
  Future<Result<bool>> forgotPassword(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Simple validation
    if (email.isEmpty) {
      return const Result.failure(
        ValidationFailure(
          message: 'Email is required',
          errors: {
            'email': ['Email is required']
          },
        ),
      );
    }

    // Check if the user exists
    final normalizedEmail = email.toLowerCase().trim();
    final user = _users.values
        .where((u) => u.email.toLowerCase() == normalizedEmail)
        .firstOrNull;

    if (user == null) {
      // For security reasons, don't reveal if the email exists or not
      // Just return success
      return const Result.success(true);
    }

    // In a real app, you would send a password reset email here

    return const Result.success(true);
  }

  @override
  Future<bool> isLoggedIn() async {
    return _currentUser != null;
  }
}

import 'package:equatable/equatable.dart';

/// Base class for all failure objects
/// Extends Equatable for easy comparison
abstract class Failure extends Equatable {
  final String message;
  final String code;

  const Failure({
    required this.message,
    required this.code,
  });

  @override
  List<Object> get props => [message, code];
}

/// Server failure
class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    String code = 'SERVER_FAILURE',
  }) : super(message: message, code: code);
}

/// Network failure
class NetworkFailure extends Failure {
  const NetworkFailure({
    String message =
        'Network connection failed. Please check your internet connection.',
    String code = 'NETWORK_FAILURE',
  }) : super(message: message, code: code);
}

/// Cache failure
class CacheFailure extends Failure {
  const CacheFailure({
    String message = 'Cache operation failed.',
    String code = 'CACHE_FAILURE',
  }) : super(message: message, code: code);
}

/// Authentication failure
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    String message = 'Authentication failed. Please login again.',
    String code = 'AUTH_FAILURE',
  }) : super(message: message, code: code);
}

/// Validation failure
class ValidationFailure extends Failure {
  final Map<String, List<String>> errors;

  const ValidationFailure({
    required this.errors,
    String message = 'Validation failed. Please check your inputs.',
    String code = 'VALIDATION_FAILURE',
  }) : super(message: message, code: code);

  @override
  List<Object> get props => [message, code, errors];
}

/// Not found failure
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    String message = 'The requested resource was not found.',
    String code = 'NOT_FOUND_FAILURE',
  }) : super(message: message, code: code);
}

/// Permission failure
class PermissionFailure extends Failure {
  const PermissionFailure({
    String message = 'You do not have permission to access this resource.',
    String code = 'PERMISSION_FAILURE',
  }) : super(message: message, code: code);
}

/// Timeout failure
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    String message = 'The operation timed out. Please try again.',
    String code = 'TIMEOUT_FAILURE',
  }) : super(message: message, code: code);
}

/// Unknown failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    String message = 'An unknown error occurred. Please try again.',
    String code = 'UNKNOWN_FAILURE',
  }) : super(message: message, code: code);
}

/// Auth failure - used for authorization failures
class AuthFailure extends Failure {
  const AuthFailure({
    String message = 'You are not authorized to perform this action.',
    String code = 'AUTH_FAILURE',
  }) : super(message: message, code: code);
}

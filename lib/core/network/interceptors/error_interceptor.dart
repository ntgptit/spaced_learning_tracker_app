import 'package:dio/dio.dart';
import 'package:slt_app/core/architecture/failure.dart';
import 'package:slt_app/core/constants/app_constants.dart';
import 'package:slt_app/core/constants/app_strings.dart';

/// Error interceptor for Dio
/// Handles standardizing error responses
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle different types of errors
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return _handleTimeoutError(err, handler);

      case DioExceptionType.badResponse:
        return _handleBadResponseError(err, handler);

      case DioExceptionType.cancel:
        return _handleCancelError(err, handler);

      case DioExceptionType.connectionError:
        return _handleConnectionError(err, handler);

      default:
        return _handleDefaultError(err, handler);
    }
  }

  /// Handle timeout errors
  void _handleTimeoutError(DioException err, ErrorInterceptorHandler handler) {
    err = err.copyWith(
      error: const TimeoutFailure(
        message: AppStrings.errorTimeout,
        code: AppConstants.errorCodeTimeout,
      ),
    );

    handler.next(err);
  }

  /// Handle bad response errors (4xx, 5xx)
  void _handleBadResponseError(
      DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final responseData = err.response?.data;

    // Default error message
    String errorMessage = AppStrings.errorGeneric;
    String errorCode = AppConstants.errorCodeServer;

    // Try to extract error message from response
    if (responseData is Map<String, dynamic>) {
      errorMessage = responseData['message'] as String? ?? errorMessage;
      errorCode = responseData['code'] as String? ?? errorCode;
    }

    // Create appropriate error based on status code
    Failure failure;

    switch (statusCode) {
      case 400:
        failure = ValidationFailure(
          message: errorMessage,
          code: AppConstants.errorCodeBadRequest,
          errors: _extractValidationErrors(responseData),
        );
        break;

      case 401:
        failure = AuthFailure(
          message: errorMessage,
          code: AppConstants.errorCodeUnauthorized,
        );
        break;

      case 403:
        failure = PermissionFailure(
          message: errorMessage,
          code: AppConstants.errorCodeUnauthorized,
        );
        break;

      case 404:
        failure = NotFoundFailure(
          message: errorMessage,
          code: AppConstants.errorCodeNotFound,
        );
        break;

      case 422:
        failure = ValidationFailure(
          message: errorMessage,
          code: AppConstants.errorCodeValidation,
          errors: _extractValidationErrors(responseData),
        );
        break;

      case 500:
      case 502:
      case 503:
      case 504:
        failure = ServerFailure(
          message: errorMessage,
          code: AppConstants.errorCodeServer,
        );
        break;

      default:
        failure = UnknownFailure(
          message: errorMessage,
          code: errorCode,
        );
        break;
    }

    err = err.copyWith(error: failure);
    handler.next(err);
  }

  /// Handle request cancellation errors
  void _handleCancelError(DioException err, ErrorInterceptorHandler handler) {
    err = err.copyWith(
      error: const UnknownFailure(
        message: 'Request was cancelled',
        code: AppConstants.errorCodeCancelled,
      ),
    );

    handler.next(err);
  }

  /// Handle connection errors
  void _handleConnectionError(
      DioException err, ErrorInterceptorHandler handler) {
    err = err.copyWith(
      error: const NetworkFailure(
        message: AppStrings.errorNoInternet,
        code: AppConstants.errorCodeNetwork,
      ),
    );

    handler.next(err);
  }

  /// Handle default errors
  void _handleDefaultError(DioException err, ErrorInterceptorHandler handler) {
    err = err.copyWith(
      error: UnknownFailure(
        message: err.message ?? AppStrings.errorGeneric,
        code: AppConstants.errorCodeUnknown,
      ),
    );

    handler.next(err);
  }

  /// Extract validation errors from response data
  Map<String, List<String>> _extractValidationErrors(dynamic responseData) {
    final Map<String, List<String>> validationErrors = {};

    if (responseData is Map<String, dynamic> &&
        responseData['errors'] is Map<String, dynamic>) {
      final errors = responseData['errors'] as Map<String, dynamic>;

      errors.forEach((key, value) {
        if (value is List) {
          validationErrors[key] = value.map((e) => e.toString()).toList();
        } else if (value is String) {
          validationErrors[key] = [value];
        }
      });
    }

    return validationErrors;
  }
}

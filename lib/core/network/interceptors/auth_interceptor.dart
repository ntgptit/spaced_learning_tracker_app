import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:slt_app/core/config/env_config.dart';
import 'package:slt_app/core/constants/app_constants.dart';

/// Authentication interceptor for Dio
/// Handles adding auth tokens to requests and token refresh
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for login and register endpoints
    if (_isAuthEndpoint(options.path)) {
      return super.onRequest(options, handler);
    }

    // Get token from secure storage
    final token = await _secureStorage.read(key: AppConstants.secureKeyToken);

    if (token != null) {
      // Add token to headers
      options.headers['Authorization'] = 'Bearer $token';
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // If token is expired, try to refresh it
    if (_isTokenExpired(err) && EnvConfig.refreshTokenEnabled) {
      try {
        final newToken = await _refreshToken();

        if (newToken != null) {
          // Retry the original request with the new token
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          // Create new request with the updated token
          final response = await Dio().fetch(options);
          return handler.resolve(response);
        }
      } catch (e) {
        // If token refresh fails, logout user
        await _handleLogout();
      }
    }

    return super.onError(err, handler);
  }

  /// Check if the request is for an auth endpoint
  bool _isAuthEndpoint(String path) {
    final authPaths = [
      '/login',
      '/register',
      '/forgot-password',
      '/reset-password',
    ];

    return authPaths.any((authPath) => path.contains(authPath));
  }

  /// Check if the error is due to token expiration
  bool _isTokenExpired(DioException err) {
    return err.response?.statusCode == 401;
  }

  /// Refresh the token
  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await _secureStorage.read(
        key: AppConstants.secureKeyRefreshToken,
      );

      if (refreshToken == null) {
        return null;
      }

      // Make a request to refresh the token
      final response = await Dio().post(
        '${EnvConfig.authUrl}/refresh',
        data: {
          'refresh_token': refreshToken,
        },
      );

      // Save the new token
      final newToken = response.data['token'] as String;
      final newRefreshToken = response.data['refresh_token'] as String;

      await _secureStorage.write(
        key: AppConstants.secureKeyToken,
        value: newToken,
      );

      await _secureStorage.write(
        key: AppConstants.secureKeyRefreshToken,
        value: newRefreshToken,
      );

      return newToken;
    } catch (e) {
      return null;
    }
  }

  /// Handle logout when token refresh fails
  Future<void> _handleLogout() async {
    // Clear tokens
    await _secureStorage.delete(key: AppConstants.secureKeyToken);
    await _secureStorage.delete(key: AppConstants.secureKeyRefreshToken);
    // Other logout logic...
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slt_app/core/config/env_config.dart';

/// Cache interceptor for Dio
/// Handles caching of API responses
class CacheInterceptor extends Interceptor {
  late SharedPreferences _prefs;

  CacheInterceptor() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip caching for non-GET requests
    if (options.method != 'GET') {
      return super.onRequest(options, handler);
    }

    // Skip caching if cache is disabled
    if (!EnvConfig.cacheEnabled) {
      return super.onRequest(options, handler);
    }

    // Skip caching if it's explicitly disabled for this request
    if (_isCacheDisabled(options)) {
      return super.onRequest(options, handler);
    }

    // Check if cache is available and not expired
    final cacheKey = _getCacheKey(options);
    final cacheData = _prefs.getString(cacheKey);

    if (cacheData != null) {
      final cacheInfo = jsonDecode(cacheData) as Map<String, dynamic>;
      final timestamp = cacheInfo['timestamp'] as int;
      final data = cacheInfo['data'];

      // Check if cache is expired
      final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
      final maxCacheAge = _getCacheMaxAge(options);

      if (cacheAge < maxCacheAge) {
        // Return cached data
        return handler.resolve(
          Response(
            requestOptions: options,
            data: data,
            statusCode: 200,
            headers: Headers.fromMap({
              'cached': ['true'],
              'cache-age': [cacheAge.toString()],
            }),
          ),
        );
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // Skip caching for non-GET requests
    if (response.requestOptions.method != 'GET') {
      return super.onResponse(response, handler);
    }

    // Skip caching if cache is disabled
    if (!EnvConfig.cacheEnabled) {
      return super.onResponse(response, handler);
    }

    // Skip caching if it's explicitly disabled for this request
    if (_isCacheDisabled(response.requestOptions)) {
      return super.onResponse(response, handler);
    }

    // Skip caching for non-success responses
    if (response.statusCode != 200) {
      return super.onResponse(response, handler);
    }

    // Cache the response
    final cacheKey = _getCacheKey(response.requestOptions);
    final cacheInfo = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': response.data,
    };

    await _prefs.setString(cacheKey, jsonEncode(cacheInfo));

    return super.onResponse(response, handler);
  }

  /// Get cache key based on request options
  String _getCacheKey(RequestOptions options) {
    final uri = options.uri.toString();
    final params = options.queryParameters.isEmpty
        ? ''
        : jsonEncode(options.queryParameters);

    return 'cache_${uri}_$params';
  }

  /// Check if cache is disabled for this request
  bool _isCacheDisabled(RequestOptions options) {
    final extras = options.extra;
    return extras.containsKey('disableCache') && extras['disableCache'] == true;
  }

  /// Get max cache age for this request
  int _getCacheMaxAge(RequestOptions options) {
    final extras = options.extra;

    if (extras.containsKey('maxCacheAge') && extras['maxCacheAge'] is int) {
      return extras['maxCacheAge'] as int;
    }

    // Default cache duration from environment config
    return EnvConfig.cacheDuration * 1000;
  }

  /// Clear the cache
  Future<void> clearCache() async {
    final keys = _prefs.getKeys();

    for (final key in keys) {
      if (key.startsWith('cache_')) {
        await _prefs.remove(key);
      }
    }
  }

  /// Clear cache for a specific endpoint
  Future<void> clearCacheForEndpoint(String endpoint) async {
    final keys = _prefs.getKeys();

    for (final key in keys) {
      if (key.startsWith('cache_') && key.contains(endpoint)) {
        await _prefs.remove(key);
      }
    }
  }
}

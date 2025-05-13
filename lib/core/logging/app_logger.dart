import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:slt_app/core/config/env_config.dart';

/// App logger
/// Wrapper around Logger package to provide consistent logging
class AppLogger {
  late final Logger _logger;

  AppLogger() {
    _initLogger();
  }

  /// Initialize logger with appropriate configuration
  void _initLogger() {
    final logLevel = _getLogLevel();

    _logger = Logger(
      level: logLevel,
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: false,
        printTime: true,
      ),
      filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),
    );
  }

  /// Get log level from environment configuration
  Level _getLogLevel() {
    switch (EnvConfig.logLevel.toLowerCase()) {
      case 'verbose':
        return Level.verbose;
      case 'debug':
        return Level.debug;
      case 'info':
        return Level.info;
      case 'warning':
        return Level.warning;
      case 'error':
        return Level.error;
      case 'nothing':
        return Level.nothing;
      default:
        return kDebugMode ? Level.debug : Level.info;
    }
  }

  void verbose(dynamic message, [dynamic errorObj, StackTrace? stackTraceObj]) {
    _logger.v(message, errorObj, stackTraceObj);
  }

  void debug(dynamic message, [dynamic errorObj, StackTrace? stackTraceObj]) {
    _logger.d(message, errorObj, stackTraceObj);
  }

  void info(dynamic message, [dynamic errorObj, StackTrace? stackTraceObj]) {
    _logger.i(message, errorObj, stackTraceObj);
  }

  void warning(dynamic message, [dynamic errorObj, StackTrace? stackTraceObj]) {
    _logger.w(message, errorObj, stackTraceObj);
  }

  void error(dynamic message, [dynamic errorObj, StackTrace? stackTraceObj]) {
    _logger.e(message, errorObj, stackTraceObj);
  }

  void critical(dynamic message,
      [dynamic errorObj, StackTrace? stackTraceObj]) {
    _logger.v(message, errorObj, stackTraceObj);
  }

  void traceEntry(String methodName, [Map<String, dynamic>? params]) {
    final paramsStr =
        params?.entries.map((e) => '${e.key}: ${e.value}').join(', ');
    _logger.d(
        'Entering $methodName${paramsStr != null ? ' with $paramsStr' : ''}');
  }

  void traceExit(String methodName, [dynamic result]) {
    _logger.d(
        'Exiting $methodName${result != null ? ' with result: $result' : ''}');
  }

  void exception(Exception exception, [StackTrace? stackTraceObj]) {
    _logger.e('Exception caught:', exception, stackTraceObj);
  }

  void startTask(String taskName) {
    _logger.i('Starting task: $taskName');
  }

  void endTask(String taskName, [String? details]) {
    _logger
        .i('Completed task: $taskName${details != null ? ' - $details' : ''}');
  }

  void logRequest(String method, String url,
      {Map<String, dynamic>? headers, dynamic body}) {
    _logger.d('HTTP $method Request: $url\nHeaders: $headers\nBody: $body');
  }

  void logResponse(
      String method, String url, int statusCode, dynamic body, int duration) {
    _logger.d(
        'HTTP $method Response ($statusCode) from $url in ${duration}ms\nBody: $body');
  }

  void logNetworkError(String method, String url, dynamic error) {
    _logger.e('HTTP $method Error for $url', error);
  }

  void logUserAction(String action, [Map<String, dynamic>? params]) {
    if (EnvConfig.analyticsEnabled) {
      _logger.i('User Action: $action${params != null ? ' - $params' : ''}');
    }
  }

  void logLifecycle(String event) {
    _logger.i('Lifecycle Event: $event');
  }
}

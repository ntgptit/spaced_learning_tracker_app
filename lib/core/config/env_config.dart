import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration
/// Handles different environment configurations (development, staging, production)
class EnvConfig {
  // Environment types
  static const String dev = 'development';
  static const String staging = 'staging';
  static const String prod = 'production';

  // Current environment
  static late String _currentEnv;

  // Initialize environment
  static Future<void> initialize(String env) async {
    _currentEnv = env;

    // Load environment variables from .env file
    try {
      await dotenv.load(fileName: _getEnvFileName());
      print('Environment loaded successfully: ${_getEnvFileName()}');
    } catch (e) {
      print('Failed to load environment file: ${e.toString()}');
      // Fallback to default .env file if specific env file is not found
      try {
        await dotenv.load(fileName: '.env');
        print('Fallback to default .env file');
      } catch (e) {
        print('Failed to load default .env file: ${e.toString()}');
      }
    }
  }

  // Get environment file name based on current environment
  static String _getEnvFileName() {
    switch (_currentEnv) {
      case dev:
        return '.env.dev';
      case staging:
        return '.env.staging';
      case prod:
        return '.env.prod';
      default:
        return '.env';
    }
  }

  // Check if current environment is development
  static bool get isDev => _currentEnv == dev;

  // Check if current environment is staging
  static bool get isStaging => _currentEnv == staging;

  // Check if current environment is production
  static bool get isProd => _currentEnv == prod;

  // Get current environment name
  static String get currentEnv => _currentEnv;

  // Get value from environment variables
  static String getValue(String key, {String defaultValue = ''}) {
    return dotenv.env[key] ?? defaultValue;
  }

  // Get API base URL from environment variables
  static String get apiBaseUrl {
    return getValue('API_BASE_URL', defaultValue: 'https://api.example.com');
  }

  // Get API key from environment variables
  static String get apiKey {
    return getValue('API_KEY', defaultValue: '');
  }

  // Get API version from environment variables
  static String get apiVersion {
    return getValue('API_VERSION', defaultValue: 'v1');
  }

  // Get app name from environment variables
  static String get appName {
    return getValue('APP_NAME', defaultValue: 'SLT App');
  }

  // Get log level from environment variables
  static String get logLevel {
    return getValue('LOG_LEVEL', defaultValue: 'info');
  }

  // Get analytics enabled flag from environment variables
  static bool get analyticsEnabled {
    return getValue('ANALYTICS_ENABLED', defaultValue: 'true') == 'true';
  }

  // Get crash reporting enabled flag from environment variables
  static bool get crashReportingEnabled {
    return getValue('CRASH_REPORTING_ENABLED', defaultValue: 'true') == 'true';
  }

  // Get debug mode flag from environment variables
  static bool get debugMode {
    return getValue('DEBUG_MODE', defaultValue: 'false') == 'true';
  }

  // Get auth URL from environment variables
  static String get authUrl {
    return getValue('AUTH_URL', defaultValue: '$apiBaseUrl/auth');
  }

  // Get timeout value from environment variables
  static int get timeout {
    return int.parse(getValue('TIMEOUT', defaultValue: '30000'));
  }

  // Get max retry count from environment variables
  static int get maxRetries {
    return int.parse(getValue('MAX_RETRIES', defaultValue: '3'));
  }

  // Get cache enabled flag from environment variables
  static bool get cacheEnabled {
    return getValue('CACHE_ENABLED', defaultValue: 'true') == 'true';
  }

  // Get cache duration from environment variables (in seconds)
  static int get cacheDuration {
    return int.parse(getValue('CACHE_DURATION', defaultValue: '3600'));
  }

  // Get refresh token enabled flag from environment variables
  static bool get refreshTokenEnabled {
    return getValue('REFRESH_TOKEN_ENABLED', defaultValue: 'true') == 'true';
  }
}

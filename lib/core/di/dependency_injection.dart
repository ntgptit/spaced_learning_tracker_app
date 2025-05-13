import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slt_app/core/logging/app_logger.dart';
import 'package:slt_app/core/network/api_client.dart';
import 'package:slt_app/core/services/connectivity_service.dart';
import 'package:slt_app/core/services/local_storage_service.dart';
import 'package:slt_app/core/services/secure_storage_service.dart';
import 'package:slt_app/core/services/theme_service.dart';

import '../services/slt_ui_notifier_service.dart';

/// Dependency injection using GetIt
/// This is a service locator pattern implementation
class DependencyInjection {
  static final GetIt locator = GetIt.instance;

  /// Initialize all dependencies
  static Future<void> init() async {
    await _initCore();
    await _initServices();
    await _initRepositories();
    await _initUseCases();
    await _initViewModels();
  }

  /// Initialize core dependencies
  static Future<void> _initCore() async {
    // Logger
    locator.registerSingleton<AppLogger>(AppLogger());

    // Shared Preferences
    final sharedPreferences = await SharedPreferences.getInstance();
    locator.registerSingleton<SharedPreferences>(sharedPreferences);

    // Secure Storage
    const secureStorage = FlutterSecureStorage();
    locator.registerSingleton<FlutterSecureStorage>(secureStorage);

    // API Client
    locator.registerLazySingleton<ApiClient>(
      () => ApiClient(logger: locator<AppLogger>()),
    );
  }

  /// Initialize services
  static Future<void> _initServices() async {
    // UI Notifier Service
    locator.registerLazySingleton<UiNotifierService>(
      () => UiNotifierService(),
    );

    // Connectivity Service
    locator.registerLazySingleton<ConnectivityService>(
      () => ConnectivityService(),
    );

    // Local Storage Service
    locator.registerLazySingleton<LocalStorageService>(
      () => LocalStorageService(
        sharedPreferences: locator<SharedPreferences>(),
      ),
    );

    // Secure Storage Service
    locator.registerLazySingleton<SecureStorageService>(
      () => SecureStorageService(
        secureStorage: locator<FlutterSecureStorage>(),
      ),
    );

    // Theme Service
    locator.registerLazySingleton<ThemeService>(
      () => ThemeService(
        localStorage: locator<LocalStorageService>(),
      ),
    );
  }

  /// Initialize repositories
  static Future<void> _initRepositories() async {
    // TODO: Register repositories
    // Example:
    // locator.registerLazySingleton<UserRepository>(
    //   () => UserRepositoryImpl(
    //     apiClient: locator<ApiClient>(),
    //     localStorage: locator<LocalStorageService>(),
    //   ),
    // );
  }

  /// Initialize use cases
  static Future<void> _initUseCases() async {
    // TODO: Register use cases
    // Example:
    // locator.registerLazySingleton<GetUserUseCase>(
    //   () => GetUserUseCase(
    //     repository: locator<UserRepository>(),
    //   ),
    // );
  }

  /// Initialize view models
  static Future<void> _initViewModels() async {
    // TODO: Register view models
    // Examples:
    // locator.registerFactory<HomeViewModel>(
    //   () => HomeViewModel(
    //     getUserUseCase: locator<GetUserUseCase>(),
    //   ),
    // );
  }
}

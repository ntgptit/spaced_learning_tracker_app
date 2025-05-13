import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:slt_app/core/config/env_config.dart';
import 'package:slt_app/core/di/dependency_injection.dart';
import 'package:slt_app/core/router/app_routes.dart';
import 'package:slt_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment config with graceful fallback
  try {
    await EnvConfig.initialize(EnvConfig.dev);
    debugPrint('Environment initialized: ${EnvConfig.currentEnv}');
  } catch (e) {
    debugPrint('Failed to initialize environment: $e');
    // Continue with default values if environment initialization fails
  }

  // Initialize dependency injection
  await DependencyInjection.init();

  runApp(
    // Enable Riverpod for the entire app
    const ProviderScope(
      child: SltApp(),
    ),
  );
}

class SltApp extends ConsumerWidget {
  const SltApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Use Theme provider once implemented
    const themeMode = ThemeMode.system;

    // Use app name from environment if available
    final appName = EnvConfig.appName;

    return MaterialApp.router(
      title: appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerDelegate: AppRoutes.router.routerDelegate,
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
      debugShowCheckedModeBanner:
          !EnvConfig.isProd, // Hide debug banner in production
    );
  }
}

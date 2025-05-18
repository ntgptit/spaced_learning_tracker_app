import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/presentation/screens/auth/login_screen.dart';
import 'package:spaced_learning_app/presentation/screens/auth/register_screen.dart';
import 'package:spaced_learning_app/presentation/screens/home/home_screen.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';

part 'app_routes.g.dart';

/// App routes
/// All routes are defined here to ensure consistency across the app
class AppRoutes {
  // Route names (used for named routes)
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String search = '/search';
  static const String courseDetails = '/course/:id';
  static const String lessonDetails = '/lesson/:id';
  static const String quizDetails = '/quiz/:id';
  static const String examDetails = '/exam/:id';
  static const String assignmentDetails = '/assignment/:id';
  static const String calendar = '/calendar';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String changePassword = '/change-password';
  static const String about = '/about';
  static const String help = '/help';
  static const String termsOfService = '/terms-of-service';
  static const String privacyPolicy = '/privacy-policy';

  // Router provider for GoRouter
  @riverpod
  GoRouter goRouter(Ref ref) {
    final authState = ref.watch(authStateProvider);

    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: initial,
      redirect: (context, state) {
        final isAuthenticated = authState.valueOrNull ?? false;

        final isLoggingIn = state.matchedLocation == login;
        final isRegistering = state.matchedLocation == register;

        // If not authenticated and not on auth pages, redirect to login
        if (!isAuthenticated && !isLoggingIn && !isRegistering) {
          return login;
        }

        // If authenticated and on auth pages, redirect to home
        if (isAuthenticated && (isLoggingIn || isRegistering)) {
          return home;
        }

        // No redirect needed
        return null;
      },
      routes: [
        GoRoute(path: initial, redirect: (_, __) => home),
        GoRoute(
          path: home,
          pageBuilder: (context, state) =>
              MaterialPage(key: state.pageKey, child: const HomeScreen()),
        ),
        GoRoute(
          path: login,
          pageBuilder: (context, state) =>
              MaterialPage(key: state.pageKey, child: const LoginScreen()),
        ),
        GoRoute(
          path: register,
          pageBuilder: (context, state) =>
              MaterialPage(key: state.pageKey, child: const RegisterScreen()),
        ),
        // Add more routes as needed
      ],
      errorPageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          appBar: AppBar(title: const Text('Page Not Found')),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'The page "${state.uri.toString()}" does not exist',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go(initial),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

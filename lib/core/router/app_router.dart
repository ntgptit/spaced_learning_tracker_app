// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/presentation/screens/auth/login_screen.dart';
import 'package:spaced_learning_app/presentation/screens/auth/register_screen.dart';
import 'package:spaced_learning_app/presentation/screens/main/main_screen.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/bottom_navigation_provider.dart';

import '../../presentation/screens/books/book_detail_screen.dart';
import '../../presentation/screens/learning/module_detail_screen.dart';

part 'app_router.g.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const main = '/main';
  static const home = '/home';
  static const books = '/books';
  static const bookDetail = '/books/:id';
  static const moduleDetail = '/modules/:id';
  static const due = '/due';
  static const stats = '/stats';
  static const profile = '/profile';
  static const settings = '/settings';
}

String? _authRedirect(bool isAuthenticated, String location) {
  final isLoggingIn = location == AppRoutes.login;
  final isRegistering = location == AppRoutes.register;

  if (!isAuthenticated && !isLoggingIn && !isRegistering) {
    return AppRoutes.login;
  }

  if (isAuthenticated && (isLoggingIn || isRegistering)) {
    return AppRoutes.main;
  }

  return null;
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  final authState = ref.watch(authStateProvider);
  final bottomNavTab = ref.watch(bottomNavigationStateProvider);
  final isAuthenticated = authState.valueOrNull ?? false;

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.main,
    redirect: (context, state) =>
        _authRedirect(isAuthenticated, state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.main,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: MainScreen(tab: bottomNavTab),
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (context, state) =>
            const MaterialPage(child: LoginScreen()),
      ),
      GoRoute(
        path: AppRoutes.register,
        pageBuilder: (context, state) =>
            const MaterialPage(child: RegisterScreen()),
      ),
      GoRoute(
        path: AppRoutes.bookDetail,
        pageBuilder: (context, state) {
          final bookId = state.pathParameters['id'] ?? '';
          return MaterialPage(
            key: state.pageKey,
            child: BookDetailScreen(bookId: bookId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.moduleDetail,
        pageBuilder: (context, state) {
          final moduleId = state.pathParameters['id'] ?? '';
          return MaterialPage(
            key: state.pageKey,
            child: ModuleDetailScreen(moduleId: moduleId),
          );
        },
      ),
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
                'The page "${state.uri}" does not exist',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(AppRoutes.main),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

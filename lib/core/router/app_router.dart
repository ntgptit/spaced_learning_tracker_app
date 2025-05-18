// lib/core/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/presentation/screens/auth/login_screen.dart';
import 'package:spaced_learning_app/presentation/screens/auth/register_screen.dart';
import 'package:spaced_learning_app/presentation/screens/main/main_screen.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/bottom_navigation_provider.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
// Import common widgets for error page
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
// Import state widgets for demo routes
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_maintenance_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_offline_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_unauthorized_state_widget.dart';

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
  static const cardsExample = '/examples/cards';

  // Routes for state widget examples
  static const exampleEmptyState = '/examples/states/empty';
  static const exampleErrorState = '/examples/states/error';
  static const exampleLoadingState = '/examples/states/loading';
  static const exampleOfflineState = '/examples/states/offline';
  static const exampleMaintenanceState = '/examples/states/maintenance';
  static const exampleUnauthorizedState = '/examples/states/unauthorized';
  static const exampleComingSoonState = '/examples/states/coming-soon';
  static const exampleGenericError =
      '/examples/states/generic-error'; // For general error builder
}

String? _authRedirect(bool isAuthenticated, String location) {
  final isLoggingIn = location == AppRoutes.login;
  final isRegistering = location == AppRoutes.register;
  final isSplash = location == AppRoutes.splash;
  final isExampleRoute = location.startsWith(
    '/examples',
  ); // Allow access to example routes

  if (isSplash || isExampleRoute || (isLoggingIn || isRegistering)) {
    if (isAuthenticated && (isLoggingIn || isRegistering) && !isExampleRoute) {
      return AppRoutes.main;
    }
    return null;
  }

  if (!isAuthenticated) {
    return AppRoutes.login;
  }

  if (isAuthenticated && isSplash) {
    return AppRoutes.main;
  }

  return null;
}

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateProvider);
  final bottomNavTab = ref.watch(bottomNavigationStateProvider);
  final isAuthenticated = authState.maybeWhen(
    data: (authenticated) => authenticated,
    orElse: () => false,
  );

  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.main,
    redirect: (context, state) =>
        _authRedirect(isAuthenticated, state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.main,
        pageBuilder: (context, state) => NoTransitionPage(
          key: ValueKey('main-${bottomNavTab.index}'),
          // Ensure key changes with tab
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

      // --- State Widget Example Routes ---
      GoRoute(
        path: AppRoutes.exampleEmptyState,
        pageBuilder: (context, state) => MaterialPage(
          child: SltScaffold(
            appBar: const SltAppBar(
              title: 'Empty State Example',
              showBackButton: true,
            ),
            body: SltEmptyStateWidget.noData(
              title: 'No Items Found',
              message:
                  'There are currently no items to display. Try adding some!',
              buttonText: 'Add Item',
              onButtonPressed: () {
                // ignore: avoid_print
                print('Add Item Tapped');
              },
            ),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.exampleErrorState,
        pageBuilder: (context, state) => MaterialPage(
          child: SltScaffold(
            appBar: const SltAppBar(
              title: 'Error State Example',
              showBackButton: true,
            ),
            body: SltErrorStateWidget.serverError(
              details:
                  'The server failed to process your request (Error 500). Please try again later.',
              onRetry: () {
                // ignore: avoid_print
                print('Retry Tapped');
              },
            ),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.exampleLoadingState,
        pageBuilder: (context, state) => MaterialPage(
          // Loading state might not need an SltScaffold if it's a full-screen overlay
          // But if it's a page, then yes.
          child: SltLoadingStateWidget.fullScreen(
            message: 'Fetching latest data, please wait...',
            showAppBar: true,
            // Example of showing SltAppBar within the state widget
            appBarTitle: 'Loading Example',
            dismissible: true, // Allow back navigation
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.exampleOfflineState,
        pageBuilder: (context, state) => MaterialPage(
          child: SltOfflineStateWidget.contentUnavailable(
            title: 'Content Offline',
            message:
                'This content requires an internet connection. Please connect and refresh.',
            onRetry: () {
              // ignore: avoid_print
              print('Refresh Offline Content Tapped');
            },
            showAppBar: true,
            appBarTitle: 'Offline Example',
            onNavigateBack: () => context.pop(),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.exampleMaintenanceState,
        pageBuilder: (context, state) => MaterialPage(
          child: SltMaintenanceStateWidget.scheduled(
            title: 'App Update In Progress',
            startTime: DateTime.now().subtract(const Duration(hours: 1)),
            endTime: DateTime.now().add(const Duration(hours: 2)),
            details:
                'We are rolling out new features and improvements. The app will be back online soon.',
            showAppBar: true,
            appBarTitle: 'Maintenance Mode',
            onNavigateBack: () => context.pop(),
            onRetryIfActive: () {
              // ignore: avoid_print
              print("Check Status Tapped");
            },
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.exampleUnauthorizedState,
        pageBuilder: (context, state) => MaterialPage(
          child: SlUnauthorizedStateWidget.insufficientPermissions(
            title: 'Premium Feature',
            message:
                'This feature is only available for premium users. Upgrade your account to access it.',
            onRequestAccess: () {
              // ignore: avoid_print
              print('Upgrade to Premium Tapped');
            },
            onGoBack: () => context.pop(),
            showAppBar: true,
            appBarTitle: 'Access Denied',
          ),
        ),
      ),

      GoRoute(
        // A route to display the generic errorPageBuilder for testing/showcase
        path: AppRoutes.exampleGenericError,
        pageBuilder: (context, state) => throw Exception(
          'This is a test error to show the generic error page.',
        ),
      ),
    ],
    errorPageBuilder: (context, state) {
      // Log the error for debugging purposes
      debugPrint('GoRouter Error: ${state.error}');
      debugPrint('GoRouter Error Location: ${state.uri}');

      // You can customize the error page based on state.error
      // For example, if state.error is a specific type of exception.
      // For now, we'll use a generic SltErrorStateWidget.

      return MaterialPage(
        key: state.pageKey,
        child: SltErrorStateWidget.custom(
          title: 'Oops! Something Went Wrong',
          message:
              'We encountered an unexpected issue. The page at "${state.uri}" might be broken or doesn\'t exist. \n\nError: ${state.error?.toString() ?? 'Unknown error'}',
          icon: Icons.sentiment_very_dissatisfied_rounded,
          retryText: 'Go to Home',
          onRetry: () => context.go(AppRoutes.main),
          showAppBar: true,
          appBarTitle: 'Page Error',
          onNavigateBack: () => context.go(AppRoutes.main), // Ensure a way back
        ),
      );
    },
  );
}

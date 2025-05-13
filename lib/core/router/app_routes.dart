import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slt_app/presentation/screens/auth/login_screen.dart';
import 'package:slt_app/presentation/screens/auth/register_screen.dart';
import 'package:slt_app/presentation/screens/home/home_screen.dart';

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

  // GoRouter configuration
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: initial,
    routes: [
      GoRoute(
        path: initial,
        redirect: (_, __) => home,
      ),
      GoRoute(
        path: home,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),
      // Add more routes as needed
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
        ),
        body: Center(
          child: Text('Page not found: ${state.uri.toString()}'),
        ),
      ),
    ),
  );

  // Route utility methods

  /// Navigate to a named route
  static void navigateTo(BuildContext context, String routeName,
      {Object? arguments}) {
    context.go(routeName, extra: arguments);
  }

  /// Navigate to a named route and replace the current route
  static void navigateReplacementTo(BuildContext context, String routeName,
      {Object? arguments}) {
    context.goNamed(routeName, extra: arguments);
  }

  /// Navigate to a named route and clear the navigation stack
  static void navigateAndRemoveUntil(BuildContext context, String routeName,
      {Object? arguments}) {
    context.go(routeName, extra: arguments);
  }

  /// Go back to the previous route
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    }
  }

  /// Retrieve route arguments
  static T? getArguments<T>(BuildContext context) {
    return GoRouterState.of(context).extra as T?;
  }

  /// Get the current route name
  static String getCurrentRouteName(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }
}

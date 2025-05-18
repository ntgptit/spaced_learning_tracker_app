// lib/presentation/screens/dashboard/dashboard_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/router/app_routes.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/screens/home/home_screen.dart';
import 'package:spaced_learning_app/presentation/viewmodels/bottom_navigation_provider.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';

import '../books/books_screen.dart';
import '../due/due_screen.dart';
import '../profile/profile_screen.dart';
import '../stats/stats_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(bottomNavigationStateProvider);

    // Current screen based on active tab
    Widget currentScreen = const HomeScreen();

    // Set current screen based on active tab
    switch (activeTab) {
      case BottomNavigationTab.home:
        currentScreen = const HomeScreen();
        break;
      case BottomNavigationTab.books:
        currentScreen = const BooksScreen();
        break;
      case BottomNavigationTab.due:
        currentScreen = const DueScreen();
        break;
      case BottomNavigationTab.stats:
        currentScreen = const StatsScreen();
        break;
      case BottomNavigationTab.profile:
        currentScreen = const ProfileScreen();
        break;
    }

    return SltScaffold(
      // No app bar here as each tab's screen will have its own app bar
      body: currentScreen,
      bottomNavigationBar: _buildBottomNavBar(context, ref, activeTab),
    );
  }

  Widget _buildBottomNavBar(
    BuildContext context,
    WidgetRef ref,
    BottomNavigationTab activeTab,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationBar(
      height: AppDimens.bottomNavBarHeight,
      elevation: AppDimens.elevationS,
      backgroundColor: colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: colorScheme.primaryContainer,
      selectedIndex: activeTab.index,
      onDestinationSelected: (index) {
        final selectedTab = BottomNavigationTab.values[index];
        ref
            .read(bottomNavigationStateProvider.notifier)
            .setActiveTab(selectedTab);

        // For deep linking - update URL without navigation
        switch (selectedTab) {
          case BottomNavigationTab.home:
            context.go(AppRoutes.dashboard);
            break;
          case BottomNavigationTab.books:
            context.go(AppRoutes.books);
            break;
          case BottomNavigationTab.due:
            context.go(AppRoutes.due);
            break;
          case BottomNavigationTab.stats:
            context.go(AppRoutes.stats);
            break;
          case BottomNavigationTab.profile:
            context.go(AppRoutes.profile);
            break;
        }
      },
      destinations: [
        // Home tab
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
            color: activeTab == BottomNavigationTab.home
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.home_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Home',
        ),

        // Books tab
        NavigationDestination(
          icon: Icon(
            Icons.book_outlined,
            color: activeTab == BottomNavigationTab.books
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.book_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Books',
        ),

        // Due tab
        NavigationDestination(
          icon: Icon(
            Icons.assignment_outlined,
            color: activeTab == BottomNavigationTab.due
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.assignment_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Due',
        ),

        // Stats tab
        NavigationDestination(
          icon: Icon(
            Icons.bar_chart_outlined,
            color: activeTab == BottomNavigationTab.stats
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.bar_chart_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Stats',
        ),

        // Profile tab
        NavigationDestination(
          icon: Icon(
            Icons.person_outline_rounded,
            color: activeTab == BottomNavigationTab.profile
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.person_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}

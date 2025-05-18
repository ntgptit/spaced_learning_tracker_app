// lib/presentation/screens/main/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/screens/books/books_screen.dart';
import 'package:spaced_learning_app/presentation/screens/due/due_screen.dart';
import 'package:spaced_learning_app/presentation/screens/home/home_screen.dart';
import 'package:spaced_learning_app/presentation/screens/profile/profile_screen.dart';
import 'package:spaced_learning_app/presentation/screens/stats/stats_screen.dart';
import 'package:spaced_learning_app/presentation/viewmodels/bottom_navigation_provider.dart';

class MainScreen extends ConsumerWidget {
  final BottomNavigationTab tab;

  const MainScreen({super.key, required this.tab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Current screen based on active tab
    Widget currentScreen;

    // Set current screen based on active tab
    switch (tab) {
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

    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: _buildBottomNavBar(context, ref, tab),
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

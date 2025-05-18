import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/router/app_routes.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/learning_stats_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/theme_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_icon_button.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../viewmodels/progress_viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Load initial data when the screen is created
    Future.microtask(() {
      ref.read(homeViewModelProvider.notifier).loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get theme data
    Theme.of(context);
    final isDark = ref.watch(isDarkModeProvider);

    // Get current user
    final user = ref.watch(currentUserProvider);

    // Watch home view model state
    final homeState = ref.watch(homeViewModelProvider);

    // Watch learning stats
    final learningStats = ref.watch(learningStatsStateProvider);

    // Watch due progress
    final dueProgress = ref.watch(todayDueTasksProvider);

    // Build welcome message
    final welcomeMessage = user != null
        ? 'Welcome back, ${user.displayName ?? user.firstName ?? user.username}!'
        : 'Welcome to Spaced Learning!';

    return SltScaffold(
      appBar: SltAppBar(
        title: 'Spaced Learning',
        centerTitle: true,
        actions: [
          SltIconButton(
            icon: isDark ? Icons.light_mode : Icons.dark_mode,
            onPressed: () {
              ref.read(themeStateProvider.notifier).toggleTheme();
            },
          ),
          SltIconButton(icon: Icons.logout, onPressed: _handleLogout),
          const SizedBox(width: AppDimens.paddingS),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeViewModelProvider.notifier).refreshData(),
        child: _buildHomeContent(
          context,
          homeState,
          welcomeMessage,
          learningStats,
          dueProgress,
        ),
      ),
    );
  }

  Widget _buildHomeContent(
    BuildContext context,
    HomeState homeState,
    String welcomeMessage,
    AsyncValue<dynamic> learningStats,
    List<dynamic> dueProgress,
  ) {
    // Handle loading state
    if (homeState.isFirstLoading) {
      return const SltLoadingStateWidget(message: 'Loading your dashboard...');
    }

    // Handle error state
    if (homeState.hasError) {
      return SltErrorStateWidget(
        title: 'Error Loading Dashboard',
        message: homeState.errorMessage ?? 'An unknown error occurred',
        onRetry: () =>
            ref.read(homeViewModelProvider.notifier).loadInitialData(),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section
          Text(
            welcomeMessage,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppDimens.spaceL),

          // Stats section
          _buildStatsSection(context, learningStats),
          const SizedBox(height: AppDimens.spaceXL),

          // Due tasks section
          _buildDueTasksSection(context, dueProgress),
        ],
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context,
    AsyncValue<dynamic> learningStats,
  ) {
    return learningStats.when(
      data: (data) {
        if (data == null) {
          return const SltEmptyStateWidget(
            title: 'No Stats Available',
            message: 'Start learning to see your statistics here.',
          );
        }

        // Build stats grid with actual data
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimens.spaceM,
          mainAxisSpacing: AppDimens.spaceM,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SltStatCard(
              title: 'Streak',
              value: '${data.streakDays}',
              subtitle: 'days',
              icon: Icons.local_fire_department,
            ),
            SltStatCard(
              title: 'Vocabulary',
              value: '${data.vocabularyCompletionRate.toStringAsFixed(1)}%',
              subtitle: '${data.learnedWords}/${data.totalWords} words',
              icon: Icons.menu_book,
            ),
            SltStatCard(
              title: 'Due Today',
              value: '${data.dueToday}',
              subtitle: 'modules',
              icon: Icons.today,
            ),
            SltStatCard(
              title: 'Completed',
              value: '${data.totalCompletedModules}',
              subtitle: 'modules',
              icon: Icons.check_circle_outline,
            ),
          ],
        );
      },
      loading: () =>
          const SltLoadingStateWidget(message: 'Loading statistics...'),
      error: (error, stack) => SltErrorStateWidget(
        title: 'Could Not Load Stats',
        message: error.toString(),
        onRetry: () => ref.refresh(learningStatsStateProvider),
        compact: true,
      ),
    );
  }

  Widget _buildDueTasksSection(
    BuildContext context,
    List<dynamic> dueProgress,
  ) {
    final theme = Theme.of(context);

    // Display section header
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Due Today', style: theme.textTheme.titleLarge),
        const SizedBox(height: AppDimens.spaceM),

        // Check if there are any due tasks
        dueProgress.isEmpty
            ? SltEmptyStateWidget.noData(
                title: 'No Tasks Due Today',
                message:
                    'You\'re all caught up! Start a new module or check back later.',
                buttonText: 'Browse Modules',
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dueProgress.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimens.spaceM),
                itemBuilder: (context, index) {
                  final progress = dueProgress[index];
                  return SltProgressCard(
                    title: progress.moduleTitle ?? 'Module',
                    subtitle: 'Book: ${progress.moduleTitle ?? 'Unknown'}',
                    progress: progress.percentComplete / 100,
                    onTap: () => _navigateToModule(progress.id),
                  );
                },
              ),
      ],
    );
  }

  void _navigateToModule(String progressId) {
    // TODO: Implement navigation to module details
  }

  Future<void> _handleLogout() async {
    // Show a confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout Confirmation'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    // Proceed with logout if confirmed
    if (shouldLogout == true) {
      await ref.read(authStateProvider.notifier).logout();

      if (context.mounted) {
        context.go(AppRoutes.login);
      }
    }
  }
}

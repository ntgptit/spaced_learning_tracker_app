// lib/presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/learning_stats_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/progress_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/theme_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_insight_card.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_progress_card.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_stat_card.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../viewmodels/bottom_navigation_provider.dart';
import '../../widgets/cards/slt_section_divider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize data loading when screen is first created
    Future.microtask(() {
      _loadInitialData();
    });
  }

  // Load all required data from APIs
  Future<void> _loadInitialData() async {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    await homeViewModel.loadInitialData();
  }

  // Refresh all data
  Future<void> _refreshData() async {
    final homeViewModel = ref.read(homeViewModelProvider.notifier);
    await homeViewModel.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    // Get home state, stats, and progress data
    final homeState = ref.watch(homeViewModelProvider);
    final learningStats = ref.watch(learningStatsStateProvider);
    final learningInsights = ref.watch(learningInsightsProvider);
    final dueProgress = ref.watch(todayDueTasksProvider);

    // Get user
    final user = ref.watch(currentUserProvider);

    // Personalized welcome message
    final welcomeMessage = user != null
        ? 'Welcome back, ${user.displayName ?? user.firstName ?? user.username}!'
        : 'Welcome to Spaced Learning!';

    return SltScaffold(
      appBar: SltAppBar(
        title: 'Dashboard',
        centerTitle: true,
        actions: [
          // Theme toggle button
          IconButton(
            icon: Icon(
              ref.watch(isDarkModeProvider)
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeStateProvider.notifier).toggleTheme();
            },
            tooltip: ref.watch(isDarkModeProvider)
                ? 'Switch to Light Mode'
                : 'Switch to Dark Mode',
          ),
          const SizedBox(width: AppDimens.paddingS),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: _buildHomeContent(
          context,
          homeState,
          welcomeMessage,
          learningStats,
          learningInsights,
          dueProgress,
        ),
      ),
    );
  }

  // Main content builder with state handling
  Widget _buildHomeContent(
    BuildContext context,
    HomeState homeState,
    String welcomeMessage,
    AsyncValue learningStats,
    AsyncValue learningInsights,
    List dueProgress,
  ) {
    // Show loading state
    if (homeState.isFirstLoading) {
      return const SltLoadingStateWidget(message: 'Loading your dashboard...');
    }

    // Show error state
    if (homeState.hasError) {
      return SltErrorStateWidget(
        title: 'Error Loading Dashboard',
        message: homeState.errorMessage ?? 'An unknown error occurred',
        onRetry: _loadInitialData,
      );
    }

    // Main content with scrolling
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

          // Insights section
          _buildInsightsSection(context, learningInsights),
          const SizedBox(height: AppDimens.spaceXL),

          // Due tasks section
          _buildDueTasksSection(context, dueProgress),
        ],
      ),
    );
  }

  // Stats grid section with 4 key metrics
  Widget _buildStatsSection(BuildContext context, AsyncValue learningStats) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Learning Statistics', style: theme.textTheme.titleLarge),
        const SizedBox(height: AppDimens.spaceM),
        learningStats.when(
          data: (data) {
            if (data == null) {
              return const SltEmptyStateWidget(
                title: 'No Stats Available',
                message: 'Start learning to see your statistics here.',
                icon: Icons.analytics_outlined,
              );
            }

            // Stats grid with actual data
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
          loading: () => const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => SltErrorStateWidget(
            title: 'Could Not Load Stats',
            message: error.toString(),
            onRetry: () => ref.refresh(learningStatsStateProvider),
            compact: true,
          ),
        ),
      ],
    );
  }

  // Learning insights section
  Widget _buildInsightsSection(
    BuildContext context,
    AsyncValue learningInsights,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Learning Insights', style: theme.textTheme.titleLarge),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                // Show info dialog about insights
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('About Insights'),
                    content: const Text(
                      'Insights provide personalized learning recommendations and feedback based on your study habits and progress.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Got it'),
                      ),
                    ],
                  ),
                );
              },
              tooltip: 'About Insights',
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceM),
        learningInsights.when(
          data: (insights) {
            if (insights == null || insights.isEmpty) {
              return const SltEmptyStateWidget(
                title: 'No Insights Available',
                message: 'Keep learning to receive personalized insights.',
                icon: Icons.psychology_outlined,
              );
            }

            // Display insights cards
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: insights.length > 3 ? 3 : insights.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppDimens.spaceM),
              itemBuilder: (context, index) {
                final insight = insights[index];
                return SltInsightCard(
                  title: 'Learning Insight',
                  message: insight.message,
                  icon: _getInsightIcon(insight.type),
                  accentColor: _getInsightColor(
                    insight.type,
                    theme.colorScheme,
                  ),
                  onTap: () {
                    // Show full insight details
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(_getInsightTitle(insight.type)),
                        content: Text(insight.message),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
          loading: () => const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => SltErrorStateWidget(
            title: 'Could Not Load Insights',
            message: error.toString(),
            onRetry: () => ref.refresh(learningInsightsProvider),
            compact: true,
          ),
        ),
        if (learningInsights.hasValue &&
            learningInsights.value != null &&
            learningInsights.value.length > 3) ...[
          const SizedBox(height: AppDimens.spaceM),
          Center(
            child: TextButton.icon(
              onPressed: () {
                // Navigate to insights screen
                // context.push(AppRoutes.insights);
              },
              icon: const Icon(Icons.visibility_outlined),
              label: const Text('View All Insights'),
            ),
          ),
        ],
      ],
    );
  }

  // Due tasks section with progress cards
  Widget _buildDueTasksSection(BuildContext context, List dueProgress) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with divider
        SltSectionDivider(
          title: 'Due Today',
          icon: Icons.assignment_outlined,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(height: AppDimens.spaceM),

        // Empty state or list of due tasks
        dueProgress.isEmpty
            ? SltEmptyStateWidget.noData(
                title: 'No Tasks Due Today',
                message:
                    'You\'re all caught up! Start a new module or check back later.',
                buttonText: 'Browse Modules',
                onButtonPressed: () {
                  // Navigate to books/modules screen
                  ref.read(bottomNavigationStateProvider.notifier).goToBooks();
                },
                icon: Icons.check_circle_outline,
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dueProgress.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimens.spaceM),
                itemBuilder: (context, index) {
                  final progress = dueProgress[index];

                  // Get cycle info
                  String cycleInfo = '';
                  if (progress.cyclesStudied != null) {
                    cycleInfo = _getCycleInfo(progress.cyclesStudied);
                  }

                  return SltProgressCard(
                    title: progress.moduleTitle ?? 'Module',
                    subtitle: cycleInfo.isNotEmpty
                        ? cycleInfo
                        : 'Due for review',
                    progress: (progress.percentComplete ?? 0) / 100,
                    leadingIcon: Icons.book_outlined,
                    onTap: () => _navigateToModuleDetails(progress.id),
                  );
                },
              ),
      ],
    );
  }

  // Get cycle info text based on cycle type
  String _getCycleInfo(dynamic cycleStudied) {
    switch (cycleStudied.toString()) {
      case 'CycleStudied.firstTime':
        return 'First study session';
      case 'CycleStudied.firstReview':
        return 'First review';
      case 'CycleStudied.secondReview':
        return 'Second review';
      case 'CycleStudied.thirdReview':
        return 'Third review';
      case 'CycleStudied.moreThanThreeReviews':
        return 'Reinforcement review';
      default:
        return '';
    }
  }

  // Map insight type to appropriate icon
  IconData _getInsightIcon(dynamic insightType) {
    switch (insightType.toString()) {
      case 'InsightType.vocabularyRate':
        return Icons.trending_up;
      case 'InsightType.streak':
        return Icons.local_fire_department;
      case 'InsightType.pendingWords':
        return Icons.assignment_outlined;
      case 'InsightType.dueToday':
        return Icons.today;
      case 'InsightType.achievement':
        return Icons.emoji_events;
      case 'InsightType.tip':
        return Icons.lightbulb_outline;
      default:
        return Icons.insights;
    }
  }

  // Map insight type to title
  String _getInsightTitle(dynamic insightType) {
    switch (insightType.toString()) {
      case 'InsightType.vocabularyRate':
        return 'Vocabulary Progress';
      case 'InsightType.streak':
        return 'Learning Streak';
      case 'InsightType.pendingWords':
        return 'Pending Words';
      case 'InsightType.dueToday':
        return 'Due Today';
      case 'InsightType.achievement':
        return 'Achievement';
      case 'InsightType.tip':
        return 'Learning Tip';
      default:
        return 'Insight';
    }
  }

  // Map insight type to appropriate color
  Color _getInsightColor(dynamic insightType, ColorScheme colorScheme) {
    switch (insightType.toString()) {
      case 'InsightType.vocabularyRate':
        return Colors.teal;
      case 'InsightType.streak':
        return Colors.orange;
      case 'InsightType.pendingWords':
        return Colors.indigo;
      case 'InsightType.dueToday':
        return Colors.blue;
      case 'InsightType.achievement':
        return Colors.amber;
      case 'InsightType.tip':
        return colorScheme.tertiary;
      default:
        return colorScheme.primary;
    }
  }

  // Navigate to module details screen
  void _navigateToModuleDetails(String progressId) {
    // context.push('${AppRoutes.moduleDetails}/$progressId');
  }
}

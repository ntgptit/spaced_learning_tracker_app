import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/learning_stats_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/progress_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_insight_card.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_progress_card.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_stat_card.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';

import '../../../core/router/app_router.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await ref.read(loadAllStatsProvider(refreshCache: false).future);

    final user = ref.read(currentUserProvider);
    if (user != null) {
      await ref.read(progressStateProvider.notifier).loadDueProgress(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final learningStats = ref.watch(learningStatsStateProvider);
    final learningInsights = ref.watch(learningInsightsProvider);
    final dueProgress = ref.watch(todayDueTasksProvider);
    final user = ref.watch(currentUserProvider);

    return SltScaffold(
      appBar: SltAppBar(
        title: 'Learning Dashboard',
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreetingSection(context, user),
              const SizedBox(height: AppDimens.spaceXL),

              _buildOverviewCard(context, learningStats),
              const SizedBox(height: AppDimens.spaceXL),

              _buildLearningActivitySection(context, learningStats),
              const SizedBox(height: AppDimens.spaceXL),

              _buildDueItemsSection(context, dueProgress),
              const SizedBox(height: AppDimens.spaceXL),

              _buildInsightsSection(context, learningInsights),
              const SizedBox(height: AppDimens.spaceXL),

              _buildQuickActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingSection(BuildContext context, dynamic user) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final greeting = _getTimeBasedGreeting();
    final username = user != null
        ? (user.displayName ?? user.firstName ?? user.username)
        : 'Learner';

    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting, $username!',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppDimens.spaceS),
          Text(
            'Track your learning progress and stay on schedule.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colorScheme.onPrimaryContainer.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(BuildContext context, AsyncValue learningStats) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: AppDimens.elevationS,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.insights, color: colorScheme.primary),
                const SizedBox(width: AppDimens.spaceS),
                Text(
                  'Learning Overview',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.spaceM),

            learningStats.when(
              data: (data) {
                if (data == null) {
                  return const Text('No learning data available yet.');
                }

                return Column(
                  children: [
                    _buildOverviewItem(
                      context,
                      'Learning Streak',
                      '${data.streakDays} days',
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                    const Divider(),

                    _buildOverviewItem(
                      context,
                      'Vocabulary Mastered',
                      '${data.vocabularyCompletionRate.toStringAsFixed(1)}%',
                      Icons.menu_book,
                      Colors.blue,
                    ),
                    const Divider(),

                    _buildOverviewItem(
                      context,
                      'Tasks Due Today',
                      '${data.dueToday}',
                      Icons.assignment_outlined,
                      Colors.red,
                    ),
                  ],
                );
              },
              loading: () => const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Text(
                'Error loading overview: ${error.toString()}',
                style: TextStyle(color: colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingS),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color, size: AppDimens.iconM),
          ),
          const SizedBox(width: AppDimens.spaceM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.bodyMedium),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningActivitySection(
    BuildContext context,
    AsyncValue learningStats,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learning Activity',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),

        learningStats.when(
          data: (data) {
            if (data == null) {
              return const SltEmptyStateWidget(
                title: 'No Activity Data',
                message: 'Start learning to see your activity stats here.',
                icon: Icons.bar_chart_outlined,
              );
            }

            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimens.spaceM,
              mainAxisSpacing: AppDimens.spaceM,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SltStatCard(
                  title: 'Completed Today',
                  value: '${data.completedToday}',
                  subtitle: 'modules',
                  icon: Icons.check_circle_outline,
                ),
                SltStatCard(
                  title: 'Words Learned',
                  value: '${data.learnedWords}',
                  subtitle: 'of ${data.totalWords}',
                  icon: Icons.text_fields,
                ),
                SltStatCard(
                  title: 'This Week',
                  value: '${data.completedThisWeek}',
                  subtitle: 'modules completed',
                  icon: Icons.calendar_view_week,
                ),
                SltStatCard(
                  title: 'Learning Cycles',
                  value: '${data.cycleStats['FIRST_REVIEW'] ?? 0}',
                  subtitle: 'modules in review',
                  icon: Icons.autorenew,
                ),
              ],
            );
          },
          loading: () => const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => SltErrorStateWidget(
            title: 'Error Loading Activity',
            message: error.toString(),
            onRetry: _loadData,
            compact: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDueItemsSection(BuildContext context, List dueProgress) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Today',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),

        dueProgress.isEmpty
            ? SltEmptyStateWidget.noData(
                title: 'Nothing Due Today',
                message: 'You\'re all caught up! No tasks pending for today.',
                icon: Icons.event_available,
              )
            : Column(
                children: [
                  ...dueProgress
                      .take(3)
                      .map(
                        (progress) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppDimens.spaceM,
                          ),
                          child: SltProgressCard(
                            title: progress.moduleTitle ?? 'Module',
                            subtitle: _getCycleInfo(progress.cyclesStudied),
                            progress: (progress.percentComplete ?? 0) / 100,
                            leadingIcon: Icons.book_outlined,
                            onTap: () => context.push(
                              '${AppRoutes.moduleDetail}/${progress.id}',
                            ),
                          ),
                        ),
                      ),

                  if (dueProgress.length > 3)
                    SltPrimaryButton(
                      text: 'View All Due Tasks',
                      prefixIcon: Icons.visibility,
                      onPressed: () => context.go(AppRoutes.due),
                    ),
                ],
              ),
      ],
    );
  }

  Widget _buildInsightsSection(
    BuildContext context,
    AsyncValue learningInsights,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Insights',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.spaceM),

        learningInsights.when(
          data: (insights) {
            if (insights == null || insights.isEmpty) {
              return const SltEmptyStateWidget(
                title: 'No Insights Yet',
                message: 'Continue learning to receive personalized insights.',
                icon: Icons.psychology_outlined,
              );
            }

            final insight = insights.first;
            return SltInsightCard(
              title: _getInsightTitle(insight.type),
              message: insight.message,
              icon: _getInsightIcon(insight.type),
              accentColor: _getInsightColor(insight.type, colorScheme),
              onTap: () {},
            );
          },
          loading: () => const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => SltErrorStateWidget(
            title: 'Error Loading Insights',
            message: error.toString(),
            onRetry: _loadData,
            compact: true,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButtons(BuildContext context) {
    return Wrap(
      spacing: AppDimens.spaceM,
      runSpacing: AppDimens.spaceM,
      children: [
        SltPrimaryButton(
          text: 'Browse Books',
          prefixIcon: Icons.book,
          onPressed: () => context.go(AppRoutes.books),
        ),
        SltPrimaryButton(
          text: 'View Statistics',
          prefixIcon: Icons.bar_chart,
          onPressed: () => context.go(AppRoutes.stats),
        ),
        SltPrimaryButton(
          text: 'Check Due Tasks',
          prefixIcon: Icons.assignment,
          onPressed: () => context.go(AppRoutes.due),
        ),
      ],
    );
  }


  String _getTimeBasedGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    }

    if (hour < 17) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  String _getCycleInfo(dynamic cycleStudied) {
    if (cycleStudied == null) {
      return 'Learning in progress';
    }

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
        return 'Learning in progress';
    }
  }

  String _getInsightTitle(dynamic insightType) {
    if (insightType == null) {
      return 'Learning Insight';
    }

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
        return 'Learning Insight';
    }
  }

  IconData _getInsightIcon(dynamic insightType) {
    if (insightType == null) {
      return Icons.insights;
    }

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

  Color _getInsightColor(dynamic insightType, ColorScheme colorScheme) {
    if (insightType == null) {
      return colorScheme.primary;
    }

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
}

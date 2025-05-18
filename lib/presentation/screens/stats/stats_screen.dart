// lib/presentation/screens/stats/stats_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/learning_stats_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_stat_card.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(loadAllStatsProvider(refreshCache: false).future);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final learningStats = ref.watch(learningStatsStateProvider);

    return SltScaffold(
      appBar: const SltAppBar(title: 'Learning Statistics', centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(loadAllStatsProvider(refreshCache: true).future);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppDimens.paddingL),
          child: learningStats.when(
            data: (stats) {
              if (stats == null) {
                return const SltEmptyStateWidget(
                  title: 'No Stats Available',
                  message: 'Start learning to see your statistics here.',
                  icon: Icons.analytics_outlined,
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Streak stats
                  _buildSectionTitle(
                    context,
                    'Learning Streak',
                    Icons.local_fire_department,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  _buildStreakStats(context, stats),
                  const SizedBox(height: AppDimens.spaceXL),

                  // Vocabulary stats
                  _buildSectionTitle(
                    context,
                    'Vocabulary Progress',
                    Icons.menu_book,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  _buildVocabularyStats(context, stats),
                  const SizedBox(height: AppDimens.spaceXL),

                  // Due tasks stats
                  _buildSectionTitle(
                    context,
                    'Due Tasks',
                    Icons.assignment_outlined,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  _buildDueStats(context, stats),
                  const SizedBox(height: AppDimens.spaceXL),

                  // Completion stats
                  _buildSectionTitle(
                    context,
                    'Completion',
                    Icons.check_circle_outline,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  _buildCompletionStats(context, stats),
                  const SizedBox(height: AppDimens.spaceXL),

                  // Module cycle stats
                  _buildSectionTitle(
                    context,
                    'Learning Cycles',
                    Icons.autorenew,
                  ),
                  const SizedBox(height: AppDimens.spaceM),
                  _buildCycleStats(context, stats),
                  const SizedBox(height: AppDimens.spaceXXL),
                ],
              );
            },
            loading: () => const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => SltErrorStateWidget(
              title: 'Could Not Load Stats',
              message: error.toString(),
              onRetry: () => ref.refresh(learningStatsStateProvider),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, color: colorScheme.primary),
        const SizedBox(width: AppDimens.spaceS),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakStats(BuildContext context, dynamic stats) {
    return Row(
      children: [
        Expanded(
          child: SltStatCard(
            title: 'Current Streak',
            value: '${stats.streakDays}',
            subtitle: 'days',
            icon: Icons.local_fire_department,
          ),
        ),
        const SizedBox(width: AppDimens.spaceM),
        Expanded(
          child: SltStatCard(
            title: 'Longest Streak',
            value: '${stats.longestStreakDays}',
            subtitle: 'days',
            icon: Icons.emoji_events_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildVocabularyStats(BuildContext context, dynamic stats) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppDimens.spaceM,
      mainAxisSpacing: AppDimens.spaceM,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SltStatCard(
          title: 'Completion Rate',
          value: '${stats.vocabularyCompletionRate.toStringAsFixed(1)}%',
          subtitle: 'of total words',
          icon: Icons.percent,
        ),
        SltStatCard(
          title: 'Words Learned',
          value: '${stats.learnedWords}',
          subtitle: 'of ${stats.totalWords}',
          icon: Icons.menu_book,
        ),
        SltStatCard(
          title: 'Pending Words',
          value: '${stats.pendingWords}',
          subtitle: 'to be learned',
          icon: Icons.pending_actions,
        ),
        SltStatCard(
          title: 'Weekly Rate',
          value: '${stats.weeklyNewWordsRate.toStringAsFixed(1)}',
          subtitle: 'words/week',
          icon: Icons.speed,
        ),
      ],
    );
  }

  Widget _buildDueStats(BuildContext context, dynamic stats) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppDimens.spaceM,
      mainAxisSpacing: AppDimens.spaceM,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SltStatCard(
          title: 'Due Today',
          value: '${stats.dueToday}',
          subtitle: 'modules',
          icon: Icons.today,
        ),
        SltStatCard(
          title: 'Words Due Today',
          value: '${stats.wordsDueToday}',
          subtitle: 'words',
          icon: Icons.spellcheck,
        ),
        SltStatCard(
          title: 'Due This Week',
          value: '${stats.dueThisWeek}',
          subtitle: 'modules',
          icon: Icons.date_range,
        ),
        SltStatCard(
          title: 'Due This Month',
          value: '${stats.dueThisMonth}',
          subtitle: 'modules',
          icon: Icons.calendar_month,
        ),
      ],
    );
  }

  Widget _buildCompletionStats(BuildContext context, dynamic stats) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppDimens.spaceM,
      mainAxisSpacing: AppDimens.spaceM,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SltStatCard(
          title: 'Completed Today',
          value: '${stats.completedToday}',
          subtitle: 'modules',
          icon: Icons.check_circle,
        ),
        SltStatCard(
          title: 'Words Today',
          value: '${stats.wordsCompletedToday}',
          subtitle: 'words reviewed',
          icon: Icons.spellcheck,
        ),
        SltStatCard(
          title: 'This Week',
          value: '${stats.completedThisWeek}',
          subtitle: 'modules completed',
          icon: Icons.calendar_view_week,
        ),
        SltStatCard(
          title: 'This Month',
          value: '${stats.completedThisMonth}',
          subtitle: 'modules completed',
          icon: Icons.calendar_month,
        ),
      ],
    );
  }

  Widget _buildCycleStats(BuildContext context, dynamic stats) {
    final cycleData = stats.cycleStats;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SltStatCard(
                title: 'Total Modules',
                value: '${stats.totalModules}',
                subtitle: 'in learning',
                icon: Icons.folder,
              ),
            ),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: SltStatCard(
                title: 'First Time',
                value: '${cycleData['FIRST_TIME'] ?? 0}',
                subtitle: 'modules',
                icon: Icons.looks_one,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceM),
        Row(
          children: [
            Expanded(
              child: SltStatCard(
                title: 'First Review',
                value: '${cycleData['FIRST_REVIEW'] ?? 0}',
                subtitle: 'modules',
                icon: Icons.looks_two,
              ),
            ),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: SltStatCard(
                title: 'Second Review',
                value: '${cycleData['SECOND_REVIEW'] ?? 0}',
                subtitle: 'modules',
                icon: Icons.looks_3,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.spaceM),
        Row(
          children: [
            Expanded(
              child: SltStatCard(
                title: 'Third Review',
                value: '${cycleData['THIRD_REVIEW'] ?? 0}',
                subtitle: 'modules',
                icon: Icons.looks_4,
              ),
            ),
            const SizedBox(width: AppDimens.spaceM),
            Expanded(
              child: SltStatCard(
                title: 'More Reviews',
                value: '${cycleData['MORE_THAN_THREE_REVIEWS'] ?? 0}',
                subtitle: 'modules',
                icon: Icons.looks_5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

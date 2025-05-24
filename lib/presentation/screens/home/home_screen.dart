// lib/presentation/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/router/app_router.dart';
import 'package:spaced_learning_app/core/theme/app_colors.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/core/theme/app_typography.dart';
import 'package:spaced_learning_app/domain/models/learning_insight.dart';
import 'package:spaced_learning_app/domain/models/learning_stats.dart';
import 'package:spaced_learning_app/domain/models/progress.dart';
import 'package:spaced_learning_app/domain/models/user.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/learning_stats_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/progress_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_button_base.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_insight_card.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_progress_card.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_stat_card.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/media/slt_avatar_image.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerInitialLoadAndAnimation(); // Gọi hàm đã sửa
    });
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: AppDimens.durationM),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
  }

  // Sửa hàm này: bỏ async và Future<void>
  void _triggerInitialLoadAndAnimation() {
    if (mounted) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          _animationController.forward();
        }
      });
    }
  }

  Future<void> _refreshData() async {
    final homeNotifier = ref.read(homeViewModelProvider.notifier);
    await homeNotifier.refreshData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final homeState = ref.watch(homeViewModelProvider);
    final User? user = ref.watch(currentUserProvider);

    return SltScaffold(
      appBar: _HomeAppBar(user: user, onRefresh: _refreshData),
      body: _buildBody(context, homeState),
    );
  }

  Widget _buildBody(BuildContext context, HomeState homeState) {
    if (homeState.status == HomeLoadingStatus.initial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (ref.read(homeViewModelProvider).status ==
            HomeLoadingStatus.initial) {
          ref.read(homeViewModelProvider.notifier).loadInitialData();
        }
      });
      return const _HomeSkeletonLoader();
    }

    if (homeState.status == HomeLoadingStatus.loading &&
        homeState.isFirstLoading) {
      return const _HomeSkeletonLoader();
    }

    if (homeState.status == HomeLoadingStatus.error) {
      return SltErrorStateWidget(
        title: 'Could Not Load Home',
        message: homeState.errorMessage ?? 'An unexpected error occurred.',
        onRetry: () =>
            ref.read(homeViewModelProvider.notifier).loadInitialData(),
      );
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: _HomeContent(
          onRefresh: _refreshData,
          isRefreshing:
              homeState.status == HomeLoadingStatus.loading &&
              !homeState.isFirstLoading,
        ),
      ),
    );
  }
}

class _HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final User? user;
  final VoidCallback onRefresh;

  const _HomeAppBar({this.user, required this.onRefresh});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final username = user?.displayName ?? user?.firstName ?? 'Learner';

    return SltAppBar(
      leading: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingS),
        child: SltAvatarImage(
          imageUrl: null,
          radius: AppDimens.avatarSizeS / 2,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getTimeBasedGreeting(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            username,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded),
          onPressed: onRefresh,
          tooltip: 'Refresh Data',
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded),
          onPressed: () {
            // TODO: Implement navigation to notifications screen
          },
          tooltip: 'Notifications',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeSkeletonLoader extends StatelessWidget {
  const _HomeSkeletonLoader();

  Widget _buildSkeletonCard(
    BuildContext context, {
    double height = 100,
    double? width,
  }) {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
      ),
      margin: const EdgeInsets.only(bottom: AppDimens.spaceM),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkeletonCard(context, height: 80),
          const SizedBox(height: AppDimens.spaceXL),
          Row(
            children: [
              Expanded(child: _buildSkeletonCard(context, height: 120)),
              const SizedBox(width: AppDimens.spaceM),
              Expanded(child: _buildSkeletonCard(context, height: 120)),
            ],
          ),
          const SizedBox(height: AppDimens.spaceXL),
          _buildSkeletonCard(context, height: 40, width: 150),
          const SizedBox(height: AppDimens.spaceM),
          _buildSkeletonCard(context, height: 80),
          _buildSkeletonCard(context, height: 80),
          const SizedBox(height: AppDimens.spaceXL),
          _buildSkeletonCard(context, height: 40, width: 200),
          const SizedBox(height: AppDimens.spaceM),
          _buildSkeletonCard(context, height: 150),
          const SizedBox(height: AppDimens.spaceXL),
          Row(
            children: [
              Expanded(child: _buildSkeletonCard(context, height: 50)),
              const SizedBox(width: AppDimens.spaceM),
              Expanded(child: _buildSkeletonCard(context, height: 50)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  final VoidCallback onRefresh;
  final bool isRefreshing;

  const _HomeContent({required this.onRefresh, this.isRefreshing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final learningStatsAsync = ref.watch(learningStatsStateProvider);
    final dueTasksToday = ref.watch(todayDueTasksProvider);
    final insightsAsync = ref.watch(learningInsightsProvider);

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: Theme.of(context).colorScheme.primary,
      child: ListView(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        children: [
          if (isRefreshing)
            Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.spaceM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: AppDimens.spaceM),
                  Text(
                    'Refreshing data...',
                    style: AppTypography.bodySmall.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          _buildOverviewStatsSection(context, ref, learningStatsAsync),
          const SizedBox(height: AppDimens.spaceXL),
          _buildDueTodaySection(context, ref, dueTasksToday),
          const SizedBox(height: AppDimens.spaceXL),
          _buildLearningInsightsSection(context, ref, insightsAsync),
          const SizedBox(height: AppDimens.spaceXL),
          _buildQuickActionsSection(context),
          const SizedBox(height: AppDimens.spaceXL),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title, {
    IconData? icon,
    VoidCallback? onViewAll,
    String? viewAllText,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: theme.colorScheme.primary,
                size: AppDimens.iconM,
              ),
              const SizedBox(width: AppDimens.spaceS),
            ],
            Text(
              title,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        if (onViewAll != null && viewAllText != null)
          TextButton(onPressed: onViewAll, child: Text(viewAllText)),
      ],
    );
  }

  Widget _buildOverviewStatsSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<LearningStatsDTO?> statsAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Overview'),
        const SizedBox(height: AppDimens.spaceM),
        statsAsync.when(
          data: (stats) {
            if (stats == null) {
              return SltEmptyStateWidget.noData(
                title: 'No Overview',
                message: 'No overview data available.',
              );
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount =
                    constraints.maxWidth < AppDimens.breakpointCompact ? 2 : 3;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppDimens.spaceM,
                  mainAxisSpacing: AppDimens.spaceM,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: crossAxisCount == 2 ? 1.5 : 1.2,
                  children: [
                    SltStatCard(
                      title: 'Streak',
                      value: '${stats.streakDays} Days',
                      icon: Icons.local_fire_department_rounded,
                      iconColor: AppColors.warning,
                      onTap: () => context.go(AppRoutes.stats),
                    ),
                    SltStatCard(
                      title: 'Learned',
                      value: '${stats.learnedWords}',
                      subtitle: 'words',
                      icon: Icons.school_rounded,
                      iconColor: AppColors.info,
                      onTap: () => context.go(AppRoutes.stats),
                    ),
                    if (crossAxisCount == 3 ||
                        (crossAxisCount == 2 && stats.dueToday > 0))
                      SltStatCard(
                        title: 'Due Today',
                        value: '${stats.dueToday}',
                        subtitle: 'items',
                        icon: Icons.calendar_today_rounded,
                        iconColor: AppColors.error,
                        onTap: () => context.go(AppRoutes.due),
                      ),
                  ],
                );
              },
            );
          },
          loading: () => Center(child: SltLoadingStateWidget.small()),
          error: (err, stack) => SltErrorStateWidget.custom(
            title: 'Error Loading Stats',
            message: err.toString(),
            compact: true,
            onRetry: () => ref.refresh(learningStatsStateProvider),
          ),
        ),
      ],
    );
  }

  Widget _buildDueTodaySection(
    BuildContext context,
    WidgetRef ref,
    List<ProgressDetail> dueTasks,
  ) {
    final limitedTasks = dueTasks.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          'Due Today',
          icon: Icons.checklist_rtl_rounded,
          onViewAll: dueTasks.isNotEmpty
              ? () => context.go(AppRoutes.due)
              : null,
          viewAllText: dueTasks.length > 3
              ? 'View All (${dueTasks.length})'
              : (dueTasks.isNotEmpty ? 'View All' : null),
        ),
        const SizedBox(height: AppDimens.spaceM),
        if (limitedTasks.isEmpty)
          SltEmptyStateWidget.noData(
            title: 'Nothing Due Today',
            message: 'You\'re all caught up! No tasks pending for today.',
            icon: Icons.event_available_rounded,
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: limitedTasks.length,
            itemBuilder: (context, index) {
              final progress = limitedTasks[index];
              return SltProgressCard(
                title: progress.moduleTitle ?? 'Unnamed Module',
                subtitle: 'Next review: Today',
                progress: (progress.percentComplete) / 100,
                onTap: () => context.go(
                  '${AppRoutes.moduleDetail}/${progress.moduleId}',
                ),
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppDimens.spaceS),
          ),
      ],
    );
  }

  Widget _buildLearningInsightsSection(
    BuildContext context,
    WidgetRef ref,
    AsyncValue<List<LearningInsightRespone>> insightsAsync,
  ) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          context,
          'Insights',
          icon: Icons.lightbulb_outline_rounded,
        ),
        const SizedBox(height: AppDimens.spaceM),
        insightsAsync.when(
          data: (insights) {
            if (insights.isEmpty) {
              return SltEmptyStateWidget.noData(
                title: 'No Insights Available',
                message: 'No insights available yet. Keep learning!',
                icon: Icons.psychology_outlined,
              );
            }
            final insight = insights.first;
            return SltInsightCard(
              title: insight.type
                  .toString()
                  .split('.')
                  .last
                  .replaceAllMapped(
                    RegExp(r'([A-Z])'),
                    (match) => ' ${match.group(1)}',
                  )
                  .trim(),
              message: insight.message,
              icon: _getInsightIcon(insight.type),
              accentColor: _getInsightColor(insight.type, theme.colorScheme),
              onTap: () {
                // TODO: Navigate to a detailed insights screen or show more info
              },
            );
          },
          loading: () => Center(child: SltLoadingStateWidget.small()),
          error: (err, stack) => SltErrorStateWidget.custom(
            title: 'Error Loading Insights',
            message: err.toString(),
            compact: true,
            onRetry: () => ref.refresh(learningInsightsProvider),
          ),
        ),
      ],
    );
  }

  IconData _getInsightIcon(InsightType insightType) {
    switch (insightType) {
      case InsightType.vocabularyRate:
        return Icons.trending_up_rounded;
      case InsightType.streak:
        return Icons.local_fire_department_rounded;
      case InsightType.pendingWords:
        return Icons.hourglass_empty_rounded;
      case InsightType.dueToday:
        return Icons.calendar_today_rounded;
      case InsightType.achievement:
        return Icons.emoji_events_rounded;
      case InsightType.tip:
        return Icons.tips_and_updates_rounded;
      default:
        return Icons.lightbulb_outline_rounded;
    }
  }

  Color _getInsightColor(InsightType insightType, ColorScheme colorScheme) {
    switch (insightType) {
      case InsightType.vocabularyRate:
        return AppColors.tealGradient[0];
      case InsightType.streak:
        return AppColors.orangeGradient[0];
      case InsightType.pendingWords:
        return AppColors.purpleGradient[0];
      case InsightType.dueToday:
        return AppColors.darkBlueGradient[0];
      case InsightType.achievement:
        return AppColors.warning;
      case InsightType.tip:
        return colorScheme.tertiary;
    }
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Quick Actions', icon: Icons.bolt_rounded),
        const SizedBox(height: AppDimens.spaceM),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: AppDimens.spaceM,
          mainAxisSpacing: AppDimens.spaceM,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.8,
          children: [
            SltPrimaryButton(
              text: 'Browse Books',
              prefixIcon: Icons.menu_book_rounded,
              onPressed: () => context.go(AppRoutes.books),
              size: SltButtonSize.medium,
            ),
            SltPrimaryButton(
              text: 'Practice',
              prefixIcon: Icons.psychology_alt_rounded,
              onPressed: () {
                // TODO: Navigate to a general practice screen or show options
              },
              size: SltButtonSize.medium,
            ),
            SltPrimaryButton(
              text: 'View Stats',
              prefixIcon: Icons.bar_chart_rounded,
              onPressed: () => context.go(AppRoutes.stats),
              size: SltButtonSize.medium,
            ),
            SltPrimaryButton(
              text: 'Add New',
              prefixIcon: Icons.add_circle_outline_rounded,
              onPressed: () {
                // TODO: Navigate to add new content screen or show options
              },
              size: SltButtonSize.medium,
            ),
          ],
        ),
      ],
    );
  }
}

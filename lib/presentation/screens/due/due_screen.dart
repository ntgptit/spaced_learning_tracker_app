import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/domain/models/progress.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/progress_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_progress_card.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../core/router/app_router.dart';

class DueScreen extends ConsumerStatefulWidget {
  const DueScreen({super.key});

  @override
  ConsumerState<DueScreen> createState() => _DueScreenState();
}

class _DueScreenState extends ConsumerState<DueScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);

    Future.microtask(() {
      _loadDueTasks();
    });
  }

  Future<void> _loadDueTasks() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser != null) {
      await ref
          .read(progressStateProvider.notifier)
          .loadDueProgress(currentUser.id);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progressState = ref.watch(progressStateProvider);

    return SltScaffold(
      appBar: SltAppBar(
        title: 'Due Tasks',
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Today'),
            Tab(text: 'This Week'),
            Tab(text: 'All'),
          ],
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          indicatorColor: colorScheme.primary,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadDueTasks,
        child: progressState.when(
          data: (progressList) {
            if (progressList.isEmpty) {
              return SltEmptyStateWidget.noData(
                title: 'No Due Tasks',
                message:
                    'You\'re all caught up! You have no tasks due at the moment.',
                icon: Icons.check_circle_outline,
              );
            }

            final todayItems = _filterTodayItems(progressList);
            final weekItems = _filterWeekItems(progressList);

            return TabBarView(
              controller: _tabController,
              children: [
                _buildProgressList(todayItems, 'today'),

                _buildProgressList(weekItems, 'this week'),

                _buildProgressList(progressList, 'in total'),
              ],
            );
          },
          loading: () =>
              const SltLoadingStateWidget(message: 'Loading due tasks...'),
          error: (error, stack) => SltErrorStateWidget(
            title: 'Error Loading Tasks',
            message: error.toString(),
            onRetry: _loadDueTasks,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressList(List<dynamic> items, String timeLabel) {
    if (items.isEmpty) {
      return SltEmptyStateWidget.noData(
        title: 'No Tasks Due $timeLabel',
        message: 'You\'re all caught up! No tasks are due $timeLabel.',
        icon: Icons.check_circle_outline,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      itemCount: items.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppDimens.spaceM),
      itemBuilder: (context, index) {
        final progress = items[index];

        String cycleInfo = '';
        if (progress.cyclesStudied != null) {
          cycleInfo = _getCycleInfo(progress.cyclesStudied);
        }

        return SltProgressCard(
          title: progress.moduleTitle ?? 'Module',
          subtitle: cycleInfo.isNotEmpty ? cycleInfo : 'Due for review',
          progress: (progress.percentComplete) / 100,
          leadingIcon: Icons.book_outlined,
          onTap: () => _navigateToModuleDetails(progress.id),
          trailing: _buildDueStatusChip(context, progress),
        );
      },
    );
  }

  Widget _buildDueStatusChip(BuildContext context, dynamic progress) {
    if (progress.nextStudyDate == null) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final studyDate = DateTime(
      progress.nextStudyDate!.year,
      progress.nextStudyDate!.month,
      progress.nextStudyDate!.day,
    );

    final isDue = !studyDate.isAfter(today);
    final isToday = studyDate.isAtSameMomentAs(today);

    final statusText = isDue && !isToday
        ? 'Overdue'
        : isToday
        ? 'Today'
        : _getDaysAwayText(studyDate, today);

    final statusColor = isDue && !isToday
        ? Colors.red
        : isToday
        ? Colors.green
        : Colors.blue;

    return Chip(
      label: Text(
        statusText,
        style: TextStyle(fontSize: AppDimens.fontXS, color: statusColor),
      ),
      backgroundColor: statusColor.withValues(alpha: 0.1),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  String _getDaysAwayText(DateTime date, DateTime today) {
    final difference = date.difference(today).inDays;

    if (difference == 1) {
      return 'Tomorrow';
    }

    if (difference < 7) {
      return '$difference days';
    }

    final weeks = difference ~/ 7;
    return weeks == 1 ? '1 week' : '$weeks weeks';
  }

  List<dynamic> _filterTodayItems(List<dynamic> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return items.where((progress) {
      if (progress.nextStudyDate == null) {
        return false;
      }

      final studyDate = DateTime(
        progress.nextStudyDate!.year,
        progress.nextStudyDate!.month,
        progress.nextStudyDate!.day,
      );

      return studyDate.isAtSameMomentAs(today) || studyDate.isBefore(today);
    }).toList();
  }

  List<dynamic> _filterWeekItems(List<dynamic> items) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));

    return items.where((progress) {
      if (progress.nextStudyDate == null) {
        return false;
      }

      final studyDate = DateTime(
        progress.nextStudyDate!.year,
        progress.nextStudyDate!.month,
        progress.nextStudyDate!.day,
      );

      return !studyDate.isBefore(weekStart) && !studyDate.isAfter(weekEnd);
    }).toList();
  }

  String _getCycleInfo(CycleStudied cycleStudied) {
    switch (cycleStudied) {
      case CycleStudied.firstTime:
        return 'First study session';
      case CycleStudied.firstReview:
        return 'First review';
      case CycleStudied.secondReview:
        return 'Second review';
      case CycleStudied.thirdReview:
        return 'Third review';
      case CycleStudied.moreThanThreeReviews:
        return 'Reinforcement review';
    }
  }

  void _navigateToModuleDetails(String progressId) {
    context.push('${AppRoutes.moduleDetail}/$progressId');
  }
}

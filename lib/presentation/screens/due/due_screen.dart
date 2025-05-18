// lib/presentation/screens/due/due_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/domain/models/progress.dart';
import 'package:spaced_learning_app/presentation/viewmodels/progress_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_progress_card.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../viewmodels/auth_viewmodel.dart';

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
      // Load due tasks for the current user
      final currentUser = ref.read(currentUserProvider);
      if (currentUser != null) {
        ref
            .read(progressStateProvider.notifier)
            .loadDueProgress(currentUser.id);
      }
    });
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
      body: progressState.when(
        data: (progressList) {
          if (progressList.isEmpty) {
            return SltEmptyStateWidget.noData(
              title: 'No Due Tasks',
              message:
                  'You\'re all caught up! You have no tasks due at the moment.',
              icon: Icons.check_circle_outline,
            );
          }

          // Filter progress items based on tab
          final todayItems = _filterTodayItems(progressList);
          final weekItems = _filterWeekItems(progressList);

          return TabBarView(
            controller: _tabController,
            children: [
              // Today tab
              _buildProgressList(todayItems, 'today'),

              // This week tab
              _buildProgressList(weekItems, 'this week'),

              // All tab
              _buildProgressList(progressList, 'in total'),
            ],
          );
        },
        loading: () =>
            const SltLoadingStateWidget(message: 'Loading due tasks...'),
        error: (error, stack) => SltErrorStateWidget(
          title: 'Error Loading Tasks',
          message: error.toString(),
          onRetry: () {
            final currentUser = ref.read(currentUserProvider);
            if (currentUser != null) {
              ref
                  .read(progressStateProvider.notifier)
                  .loadDueProgress(currentUser.id);
            }
          },
        ),
      ),
    );
  }

  Widget _buildProgressList(List<ProgressDetail> items, String timeLabel) {
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

        // Get cycle info
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
        );
      },
    );
  }

  // Filter methods for the tabs
  List<ProgressDetail> _filterTodayItems(List<ProgressDetail> items) {
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

  List<ProgressDetail> _filterWeekItems(List<ProgressDetail> items) {
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

  // Get cycle info text based on cycle type
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

  // Navigate to module details screen
  void _navigateToModuleDetails(String progressId) {
    // Navigation to be implemented
  }
}

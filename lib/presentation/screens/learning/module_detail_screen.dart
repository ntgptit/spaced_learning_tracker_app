import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/domain/models/repetition.dart';
import 'package:spaced_learning_app/presentation/viewmodels/module_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/progress_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/repetition_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/buttons/slt_primary_button.dart';
import 'package:spaced_learning_app/presentation/widgets/cards/slt_progress_card.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../domain/models/progress.dart';

class ModuleDetailScreen extends ConsumerStatefulWidget {
  final String moduleId;

  const ModuleDetailScreen({super.key, required this.moduleId});

  @override
  ConsumerState<ModuleDetailScreen> createState() => _ModuleDetailScreenState();
}

class _ModuleDetailScreenState extends ConsumerState<ModuleDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await ref
        .read(selectedModuleProvider.notifier)
        .loadModuleDetails(widget.moduleId);

    final moduleData = ref.read(selectedModuleProvider).valueOrNull;

    if (moduleData != null && moduleData.progress.isNotEmpty) {
      final progressId = moduleData.progress.first.id;
      await ref
          .read(selectedProgressProvider.notifier)
          .loadProgressDetails(progressId);
      await ref
          .read(repetitionStateProvider.notifier)
          .loadRepetitionsByProgressId(progressId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final moduleState = ref.watch(selectedModuleProvider);
    final progressState = ref.watch(selectedProgressProvider);
    final repetitionsState = ref.watch(repetitionStateProvider);

    return SltScaffold(
      appBar: const SltAppBar(
        title: 'Module Details',
        centerTitle: true,
        showBackButton: true,
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingL),
            child: _buildContent(
              context,
              moduleState,
              progressState,
              repetitionsState,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AsyncValue moduleState,
    AsyncValue progressState,
    AsyncValue repetitionsState,
  ) {
    if (moduleState.isLoading) {
      return const SltLoadingStateWidget(message: 'Loading module details...');
    }

    if (moduleState.hasError) {
      return SltErrorStateWidget(
        title: 'Error Loading Module',
        message: moduleState.error.toString(),
        onRetry: _loadData,
      );
    }

    final module = moduleState.valueOrNull;

    if (module == null) {
      return const SltEmptyStateWidget(
        title: 'Module Not Found',
        message: 'The module you are looking for could not be found.',
        icon: Icons.description_outlined,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildModuleHeader(context, module),
        const SizedBox(height: AppDimens.spaceXL),

        Text('Your Progress', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppDimens.spaceM),

        _buildProgressSection(context, module, progressState, repetitionsState),
      ],
    );
  }

  Widget _buildModuleHeader(BuildContext context, dynamic module) {
    final theme = Theme.of(context);

    return Card(
      elevation: AppDimens.elevationS,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              module.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spaceS),

            if (module.bookName != null)
              Text(
                'From: ${module.bookName}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            const SizedBox(height: AppDimens.spaceM),

            Row(
              children: [
                Chip(
                  label: Text('Module ${module.moduleNo}'),
                  avatar: const Icon(Icons.bookmark),
                  backgroundColor: theme.colorScheme.surfaceContainerHigh,
                ),
                const SizedBox(width: AppDimens.spaceM),

                Chip(
                  label: Text('${module.wordCount ?? 0} words'),
                  avatar: const Icon(Icons.text_fields),
                  backgroundColor: theme.colorScheme.surfaceContainerHigh,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection(
    BuildContext context,
    dynamic module,
    AsyncValue progressState,
    AsyncValue repetitionsState,
  ) {
    final hasProgress = module.progress.isNotEmpty;

    if (!hasProgress) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: AppDimens.spaceXL),
            const SltEmptyStateWidget(
              title: 'No Learning Progress',
              message: 'You haven\'t started learning this module yet.',
              icon: Icons.school_outlined,
            ),
            const SizedBox(height: AppDimens.spaceXL),
            SltPrimaryButton(
              text: 'Start Learning',
              prefixIcon: Icons.play_arrow_rounded,
              onPressed: _startLearning,
            ),
          ],
        ),
      );
    }

    if (progressState.isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (progressState.hasError) {
      return SltErrorStateWidget(
        title: 'Error Loading Progress',
        message: progressState.error.toString(),
        onRetry: _loadData,
        compact: true,
      );
    }

    final progress = progressState.valueOrNull;

    if (progress == null) {
      return const SltEmptyStateWidget(
        title: 'Progress Not Found',
        message: 'Your progress data could not be loaded.',
        icon: Icons.error_outline,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SltProgressCard(
          title: 'Learning Progress',
          subtitle: _getCycleInfo(progress.cyclesStudied),
          progress: progress.percentComplete / 100,
          leadingIcon: Icons.trending_up,
          onTap: () => _continueProgress(progress),
        ),
        const SizedBox(height: AppDimens.spaceXL),

        Text(
          'Learning Schedule',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppDimens.spaceM),

        _buildRepetitionsSection(context, repetitionsState, progress.id),

        const SizedBox(height: AppDimens.spaceXL),
        Center(
          child: SltPrimaryButton(
            text: 'Continue Learning',
            prefixIcon: Icons.play_arrow_rounded,
            onPressed: () => _continueProgress(progress),
          ),
        ),
      ],
    );
  }

  Widget _buildRepetitionsSection(
    BuildContext context,
    AsyncValue repetitionsState,
    String progressId,
  ) {
    if (repetitionsState.isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (repetitionsState.hasError) {
      return SltErrorStateWidget(
        title: 'Error Loading Schedule',
        message: repetitionsState.error.toString(),
        onRetry: () => ref
            .read(repetitionStateProvider.notifier)
            .loadRepetitionsByProgressId(progressId),
        compact: true,
      );
    }

    final repetitions = repetitionsState.valueOrNull ?? [];

    if (repetitions.isEmpty) {
      return const SltEmptyStateWidget(
        title: 'No Learning Schedule',
        message: 'Your learning schedule is not available.',
        icon: Icons.event_busy,
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: repetitions.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppDimens.spaceS),
      itemBuilder: (context, index) {
        final repetition = repetitions[index];

        return Card(
          child: ListTile(
            leading: _getRepetitionStatusIcon(repetition),
            title: Text(repetition.formatFullOrder()),
            subtitle: Text(
              repetition.reviewDate != null
                  ? 'Scheduled for ${_formatDate(repetition.reviewDate!)}'
                  : 'Not scheduled yet',
            ),
            trailing: _getRepetitionStatusChip(context, repetition),
          ),
        );
      },
    );
  }

  Widget _getRepetitionStatusIcon(Repetition repetition) {
    final iconData = switch (repetition.status) {
      RepetitionStatus.completed => Icons.check_circle,
      RepetitionStatus.skipped => Icons.cancel,
      RepetitionStatus.notStarted => Icons.schedule,
    };

    final iconColor = switch (repetition.status) {
      RepetitionStatus.completed => Colors.green,
      RepetitionStatus.skipped => Colors.orange,
      RepetitionStatus.notStarted => Colors.blue,
    };

    return CircleAvatar(
      backgroundColor: iconColor.withValues(alpha: 0.1),
      child: Icon(iconData, color: iconColor),
    );
  }

  Widget _getRepetitionStatusChip(BuildContext context, Repetition repetition) {
    final text = switch (repetition.status) {
      RepetitionStatus.completed => 'Completed',
      RepetitionStatus.skipped => 'Skipped',
      RepetitionStatus.notStarted => 'Pending',
    };

    final color = switch (repetition.status) {
      RepetitionStatus.completed => Colors.green,
      RepetitionStatus.skipped => Colors.orange,
      RepetitionStatus.notStarted => Colors.blue,
    };

    return Chip(
      label: Text(
        text,
        style: TextStyle(fontSize: AppDimens.fontXS, color: color),
      ),
      backgroundColor: color.withValues(alpha: 0.1),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateToCheck = DateTime(date.year, date.month, date.day);

    if (dateToCheck.isAtSameMomentAs(today)) {
      return 'Today';
    }

    if (dateToCheck.isAtSameMomentAs(tomorrow)) {
      return 'Tomorrow';
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  String _getCycleInfo(dynamic cycleStudied) {
    switch (cycleStudied.toString()) {
      case 'CycleStudied.firstTime':
        return 'First study session';
      case 'CycleStudied.firstReview':
        return 'First review cycle';
      case 'CycleStudied.secondReview':
        return 'Second review cycle';
      case 'CycleStudied.thirdReview':
        return 'Third review cycle';
      case 'CycleStudied.moreThanThreeReviews':
        return 'Advanced reinforcement cycle';
      default:
        return 'Learning in progress';
    }
  }

  Future<void> _startLearning() async {
    try {
      _showLoadingDialog('Preparing your learning session...');

      final progress = await ref
          .read(progressStateProvider.notifier)
          .createProgress(
            moduleId: widget.moduleId,
            firstLearningDate: DateTime.now(),
            cyclesStudied: CycleStudied.firstTime,
            nextStudyDate: DateTime.now(),
            percentComplete: 0,
          );

      if (progress == null) {
        if (mounted) {
          Navigator.pop(context); // Close loading dialog
          _showErrorDialog(
            'Failed to start learning session. Please try again.',
          );
        }
        return;
      }

      await ref
          .read(repetitionStateProvider.notifier)
          .createDefaultSchedule(progress.id);

      await _loadData();

      if (mounted) {
        Navigator.pop(context);
      }

    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading dialog
        _showErrorDialog('Error: ${e.toString()}');
      }
    }
  }

  void _continueProgress(dynamic progress) {
  }

  void _showLoadingDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppDimens.spaceM),
            Text(message),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

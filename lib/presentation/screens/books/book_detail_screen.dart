import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/book_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/module_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../core/router/app_router.dart';

class BookDetailScreen extends ConsumerStatefulWidget {
  final String bookId;

  const BookDetailScreen({super.key, required this.bookId});

  @override
  ConsumerState<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends ConsumerState<BookDetailScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    await ref
        .read(selectedBookProvider.notifier)
        .loadBookDetails(widget.bookId);
    await ref
        .read(modulesStateProvider.notifier)
        .loadModulesByBookId(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bookState = ref.watch(selectedBookProvider);
    final modulesState = ref.watch(modulesStateProvider);

    return SltScaffold(
      appBar: const SltAppBar(
        title: 'Book Details',
        centerTitle: true,
        showBackButton: true,
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingL),
            child: _buildContent(context, bookState, modulesState),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    AsyncValue bookState,
    AsyncValue modulesState,
  ) {
    if (bookState.isLoading || modulesState.isLoading) {
      return const SltLoadingStateWidget(message: 'Loading book details...');
    }

    if (bookState.hasError) {
      return SltErrorStateWidget(
        title: 'Error Loading Book',
        message: bookState.error.toString(),
        onRetry: _loadData,
      );
    }

    if (modulesState.hasError) {
      return SltErrorStateWidget(
        title: 'Error Loading Modules',
        message: modulesState.error.toString(),
        onRetry: _loadData,
      );
    }

    final book = bookState.valueOrNull;

    if (book == null) {
      return const SltEmptyStateWidget(
        title: 'Book Not Found',
        message: 'The book you are looking for could not be found.',
        icon: Icons.menu_book,
      );
    }

    final modules = modulesState.valueOrNull ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBookHeader(context, book),
        const SizedBox(height: AppDimens.spaceXL),

        if (book.description != null && book.description!.isNotEmpty) ...[
          Text('Description', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppDimens.spaceM),
          Text(
            book.description!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: AppDimens.spaceXL),
        ],

        Text(
          'Modules (${modules.length})',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppDimens.spaceM),

        if (modules.isEmpty)
          const SltEmptyStateWidget(
            title: 'No Modules Available',
            message: 'This book has no modules yet.',
            icon: Icons.description_outlined,
          )
        else
          _buildModulesList(context, modules),
      ],
    );
  }

  Widget _buildBookHeader(BuildContext context, dynamic book) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: AppDimens.elevationS,
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppDimens.spaceM),

            Wrap(
              spacing: AppDimens.spaceM,
              runSpacing: AppDimens.spaceS,
              children: [
                Chip(
                  label: Text(_getDifficultyText(book.difficultyLevel)),
                  avatar: const Icon(Icons.signal_cellular_alt),
                  backgroundColor: _getDifficultyColor(
                    book.difficultyLevel,
                    colorScheme,
                  ),
                ),

                if (book.category != null && book.category!.isNotEmpty)
                  Chip(
                    label: Text(book.category!),
                    avatar: const Icon(Icons.category),
                    backgroundColor: colorScheme.surfaceContainerHigh,
                  ),

                Chip(
                  label: Text(_getStatusText(book.status)),
                  avatar: Icon(_getStatusIcon(book.status)),
                  backgroundColor: _getStatusColor(book.status, colorScheme),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesList(BuildContext context, List modules) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: modules.length,
      separatorBuilder: (context, index) =>
          const SizedBox(height: AppDimens.spaceM),
      itemBuilder: (context, index) {
        final module = modules[index];

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                module.moduleNo.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            title: Text(module.title),
            subtitle: Text('${module.wordCount ?? 0} words'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go('${AppRoutes.moduleDetail}/${module.id}'),
          ),
        );
      },
    );
  }

  String _getDifficultyText(dynamic difficultyLevel) {
    if (difficultyLevel == null) {
      return 'Unspecified';
    }

    switch (difficultyLevel.toString()) {
      case 'DifficultyLevel.beginner':
        return 'Beginner';
      case 'DifficultyLevel.intermediate':
        return 'Intermediate';
      case 'DifficultyLevel.advanced':
        return 'Advanced';
      case 'DifficultyLevel.expert':
        return 'Expert';
      default:
        return 'Unspecified';
    }
  }

  Color _getDifficultyColor(dynamic difficultyLevel, ColorScheme colorScheme) {
    if (difficultyLevel == null) {
      return colorScheme.surfaceContainerHigh;
    }

    switch (difficultyLevel.toString()) {
      case 'DifficultyLevel.beginner':
        return Colors.green.withValues(alpha: 0.2);
      case 'DifficultyLevel.intermediate':
        return Colors.blue.withValues(alpha: 0.2);
      case 'DifficultyLevel.advanced':
        return Colors.orange.withValues(alpha: 0.2);
      case 'DifficultyLevel.expert':
        return Colors.red.withValues(alpha: 0.2);
      default:
        return colorScheme.surfaceContainerHigh;
    }
  }

  String _getStatusText(dynamic status) {
    switch (status.toString()) {
      case 'BookStatus.published':
        return 'Published';
      case 'BookStatus.draft':
        return 'Draft';
      case 'BookStatus.archived':
        return 'Archived';
      default:
        return 'Unknown';
    }
  }

  IconData _getStatusIcon(dynamic status) {
    switch (status.toString()) {
      case 'BookStatus.published':
        return Icons.public;
      case 'BookStatus.draft':
        return Icons.edit_note;
      case 'BookStatus.archived':
        return Icons.archive;
      default:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor(dynamic status, ColorScheme colorScheme) {
    switch (status.toString()) {
      case 'BookStatus.published':
        return Colors.green.withValues(alpha: 0.2);
      case 'BookStatus.draft':
        return Colors.amber.withValues(alpha: 0.2);
      case 'BookStatus.archived':
        return Colors.grey.withValues(alpha: 0.2);
      default:
        return colorScheme.surfaceContainerHigh;
    }
  }
}

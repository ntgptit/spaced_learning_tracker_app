// lib/presentation/screens/books/books_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaced_learning_app/core/theme/app_dimens.dart';
import 'package:spaced_learning_app/presentation/viewmodels/book_viewmodel.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_app_bar.dart';
import 'package:spaced_learning_app/presentation/widgets/common/slt_scaffold.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:spaced_learning_app/presentation/widgets/states/slt_loading_state_widget.dart';

class BooksScreen extends ConsumerStatefulWidget {
  const BooksScreen({super.key});

  @override
  ConsumerState<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends ConsumerState<BooksScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(booksStateProvider.notifier).loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final booksState = ref.watch(booksStateProvider);

    return SltScaffold(
      appBar: const SltAppBar(title: 'My Books', centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(booksStateProvider.notifier).loadBooks();
        },
        child: booksState.when(
          data: (books) {
            if (books.isEmpty) {
              return SltEmptyStateWidget.noData(
                title: 'No Books Available',
                message:
                    'Your book collection is empty. Start by adding new books to learn from.',
                buttonText: 'Browse Collection',
                onButtonPressed: null, // Add functionality when implemented
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(AppDimens.paddingL),
              itemCount: books.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppDimens.spaceM),
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  elevation: AppDimens.elevationS,
                  child: ListTile(
                    title: Text(book.name),
                    subtitle: Text(
                      '${book.moduleCount} modules • ${_getDifficultyText(book.difficultyLevel)}',
                    ),
                    leading: _getBookIcon(book.status),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ref
                          .read(selectedBookProvider.notifier)
                          .loadBookDetails(book.id);
                      // Navigate to book details when implemented
                    },
                  ),
                );
              },
            );
          },
          loading: () =>
              const SltLoadingStateWidget(message: 'Loading books...'),
          error: (error, stack) => SltErrorStateWidget(
            title: 'Error Loading Books',
            message: error.toString(),
            onRetry: () => ref.read(booksStateProvider.notifier).loadBooks(),
          ),
        ),
      ),
    );
  }

  Widget _getBookIcon(dynamic status) {
    IconData iconData;

    switch (status.toString()) {
      case 'BookStatus.published':
        iconData = Icons.book;
        break;
      case 'BookStatus.draft':
        iconData = Icons.edit_note;
        break;
      case 'BookStatus.archived':
        iconData = Icons.archive;
        break;
      default:
        iconData = Icons.book;
    }

    return CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      child: Icon(iconData, color: Theme.of(context).colorScheme.primary),
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
}

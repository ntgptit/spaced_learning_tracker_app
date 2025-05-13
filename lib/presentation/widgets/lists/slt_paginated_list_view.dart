import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_strings.dart';
import 'package:slt_app/presentation/widgets/states/slt_empty_state_widget.dart';
import 'package:slt_app/presentation/widgets/states/slt_error_state_widget.dart';
import 'package:slt_app/presentation/widgets/states/slt_loading_state_widget.dart';

import '../../../core/theme/app_dimens.dart';

/// Paginated list view widget
/// A list view that supports pagination with loading, error, and empty states
class SltPaginatedListView<T> extends StatefulWidget {
  /// List of items to display
  final List<T> items;

  /// Builder function for list items
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Callback function to load more items
  final Future<void> Function()? onLoadMore;

  /// Whether more items can be loaded
  final bool hasMoreItems;

  /// Whether items are currently loading
  final bool isLoading;

  /// Error message if loading failed
  final String? errorMessage;

  /// Callback function to retry loading
  final VoidCallback? onRetry;

  /// Empty state widget
  final Widget? emptyWidget;

  /// Loading state widget
  final Widget? loadingWidget;

  /// Error state widget
  final Widget? errorWidget;

  /// Separator widget
  final Widget? separatorWidget;

  /// Scroll controller
  final ScrollController? scrollController;

  /// Scroll physics
  final ScrollPhysics? scrollPhysics;

  /// Whether to show the loading indicator at the bottom
  final bool showLoadingIndicatorAtBottom;

  /// Number of items to load before triggering onLoadMore
  final int loadMoreThreshold;

  /// Padding around the list
  final EdgeInsetsGeometry? padding;

  /// Whether the list is shrink wrapped
  final bool shrinkWrap;

  /// Empty state message
  final String emptyStateMessage;

  /// Primary flag for list view
  final bool primary;

  const SltPaginatedListView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.onLoadMore,
    this.hasMoreItems = false,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.emptyWidget,
    this.loadingWidget,
    this.errorWidget,
    this.separatorWidget,
    this.scrollController,
    this.scrollPhysics,
    this.showLoadingIndicatorAtBottom = true,
    this.loadMoreThreshold = 3,
    this.padding,
    this.shrinkWrap = false,
    this.emptyStateMessage = AppStrings.emptyStateDescription,
    this.primary = true,
  }) : super(key: key);

  @override
  State<SltPaginatedListView<T>> createState() =>
      _SltPaginatedListViewState<T>();
}

class _SltPaginatedListViewState<T> extends State<SltPaginatedListView<T>> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    } else {
      _scrollController.removeListener(_scrollListener);
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_isLoadingMore || !widget.hasMoreItems || widget.onLoadMore == null) {
      return;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final threshold =
        widget.loadMoreThreshold * 100.0; // Adjust based on item height

    if (maxScroll - currentScroll <= threshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !widget.hasMoreItems || widget.onLoadMore == null) {
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    try {
      await widget.onLoadMore!();
    } catch (e) {
      // Error handling is delegated to the parent widget
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If there are no items, show empty state
    if (widget.items.isEmpty) {
      if (widget.isLoading) {
        return widget.loadingWidget ??
            const SltLoadingStateWidget(
              message: AppStrings.loadingStateTitle,
            );
      }

      if (widget.errorMessage != null) {
        return widget.errorWidget ??
            SltErrorStateWidget(
              message: widget.errorMessage!,
              onRetry: widget.onRetry,
            );
      }

      return widget.emptyWidget ??
          SltEmptyStateWidget(
            message: widget.emptyStateMessage,
          );
    }

    return Column(
      children: [
        Expanded(
          child: widget.separatorWidget != null
              ? ListView.separated(
                  controller: _scrollController,
                  physics: widget.scrollPhysics,
                  padding: widget.padding,
                  shrinkWrap: widget.shrinkWrap,
                  primary: widget.primary,
                  itemCount: widget.items.length,
                  separatorBuilder: (context, index) => widget.separatorWidget!,
                  itemBuilder: (context, index) => widget.itemBuilder(
                    context,
                    widget.items[index],
                    index,
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  physics: widget.scrollPhysics,
                  padding: widget.padding,
                  shrinkWrap: widget.shrinkWrap,
                  primary: widget.primary,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) => widget.itemBuilder(
                    context,
                    widget.items[index],
                    index,
                  ),
                ),
        ),

        // Loading indicator at the bottom
        if (widget.isLoading &&
            widget.showLoadingIndicatorAtBottom &&
            widget.items.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingM),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),

        // Error indicator at the bottom
        if (widget.errorMessage != null && widget.items.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingM),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                if (widget.onRetry != null)
                  TextButton(
                    onPressed: widget.onRetry,
                    child: const Text(AppStrings.retry),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

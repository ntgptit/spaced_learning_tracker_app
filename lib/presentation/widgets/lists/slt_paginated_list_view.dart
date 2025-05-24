import 'package:flutter/material.dart';

import '../../../core/theme/app_dimens.dart';
import '../states/slt_empty_state_widget.dart';
import '../states/slt_error_state_widget.dart';
import '../states/slt_loading_state_widget.dart';

class SltPaginatedListView<T> extends StatefulWidget {
  final List<T> items;

  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  final Future<void> Function()? onLoadMore;

  final bool hasMoreItems;

  final bool isLoading;

  final String? errorMessage;

  final VoidCallback? onRetry;

  final Widget? emptyWidget;

  final Widget? loadingWidget;

  final Widget? errorWidget;

  final Widget? separatorWidget;

  final ScrollController? scrollController;

  final ScrollPhysics? scrollPhysics;

  final bool showLoadingIndicatorAtBottom;

  final int loadMoreThreshold;

  final EdgeInsetsGeometry? padding;

  final bool shrinkWrap;

  final String emptyStateMessage;

  final bool primary;

  const SltPaginatedListView({
    super.key,
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
    this.emptyStateMessage = '',
    this.primary = true,
  });

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
    if (widget.items.isEmpty) {
      if (widget.isLoading) {
        return widget.loadingWidget ??
            const SltLoadingStateWidget(message: 'Loading items...');
      }

      if (widget.errorMessage != null) {
        return widget.errorWidget ??
            SltErrorStateWidget(
              message: widget.errorMessage,
              onRetry: widget.onRetry,
              title: '',
            );
      }

      return widget.emptyWidget ??
          SltEmptyStateWidget(message: widget.emptyStateMessage, title: '');
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
                  itemBuilder: (context, index) =>
                      widget.itemBuilder(context, widget.items[index], index),
                )
              : ListView.builder(
                  controller: _scrollController,
                  physics: widget.scrollPhysics,
                  padding: widget.padding,
                  shrinkWrap: widget.shrinkWrap,
                  primary: widget.primary,
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) =>
                      widget.itemBuilder(context, widget.items[index], index),
                ),
        ),

        if (widget.isLoading &&
            widget.showLoadingIndicatorAtBottom &&
            widget.items.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingM),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ),

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
                    child: const Text('Retry'),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

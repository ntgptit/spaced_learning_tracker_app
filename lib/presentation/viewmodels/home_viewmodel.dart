// lib/presentation/viewmodels/home_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/presentation/viewmodels/auth_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/learning_stats_viewmodel.dart';
import 'package:spaced_learning_app/presentation/viewmodels/progress_viewmodel.dart';

part 'home_viewmodel.g.dart';

enum HomeLoadingStatus { initial, loading, loaded, error }

class HomeState {
  final HomeLoadingStatus status;
  final String? errorMessage;

  const HomeState({required this.status, this.errorMessage});

  const HomeState.initial() : this(status: HomeLoadingStatus.initial);

  HomeState copyWith({HomeLoadingStatus? status, String? errorMessage}) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Getter to check if the state is in initial loading
  bool get isFirstLoading =>
      status == HomeLoadingStatus.initial ||
      (status == HomeLoadingStatus.loading && errorMessage == null);

  // Getter to check if the state is error
  bool get hasError => status == HomeLoadingStatus.error;

  // Getter to check if data has been loaded
  bool get isLoaded => status == HomeLoadingStatus.loaded;
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return const HomeState.initial();
  }

  Future<void> loadInitialData() async {
    debugPrint('[HomeViewModel] loadInitialData - Starting...');

    // Skip if already loading
    if (state.status == HomeLoadingStatus.loading) {
      debugPrint('[HomeViewModel] loadInitialData - Already loading, skipping');
      return;
    }

    // Set loading state
    state = state.copyWith(status: HomeLoadingStatus.loading);
    debugPrint('[HomeViewModel] loadInitialData - Setting state to loading');

    try {
      // Get current user info
      final user = ref.read(currentUserProvider);
      debugPrint(
        '[HomeViewModel] loadInitialData - Current user: ${user?.id ?? 'null'}',
      );

      // Load statistics data
      debugPrint('[HomeViewModel] loadInitialData - Loading stats data');
      await ref.read(loadAllStatsProvider(refreshCache: false).future);
      debugPrint(
        '[HomeViewModel] loadInitialData - Stats data loaded successfully',
      );

      // Load progress data if user is logged in
      if (user != null) {
        debugPrint(
          '[HomeViewModel] loadInitialData - Loading progress data for user: ${user.id}',
        );
        await ref.read(progressStateProvider.notifier).loadDueProgress(user.id);

        final progressAfter = ref.read(progressStateProvider).valueOrNull;
        debugPrint(
          '[HomeViewModel] loadInitialData - Progress data loaded. Items count: ${progressAfter?.length ?? 0}',
        );
      } else {
        debugPrint(
          '[HomeViewModel] loadInitialData - No user logged in, skipping progress loading',
        );
      }

      // Set loaded state
      state = state.copyWith(status: HomeLoadingStatus.loaded);
      debugPrint('[HomeViewModel] loadInitialData - Completed successfully');
    } catch (e, stackTrace) {
      debugPrint('[HomeViewModel] loadInitialData - Error: $e');
      debugPrint('[HomeViewModel] loadInitialData - Stack trace: $stackTrace');

      // Set error state
      state = state.copyWith(
        status: HomeLoadingStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> refreshData() async {
    try {
      // Get current user info
      final user = ref.read(currentUserProvider);

      // Reload statistics data
      await ref.read(loadAllStatsProvider(refreshCache: true).future);

      // Reload progress data if user is logged in
      if (user != null) {
        await ref.read(progressStateProvider.notifier).loadDueProgress(user.id);
      }

      state = state.copyWith(status: HomeLoadingStatus.loaded);
    } catch (e) {
      debugPrint('Error refreshing data: $e');
      state = state.copyWith(
        status: HomeLoadingStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}

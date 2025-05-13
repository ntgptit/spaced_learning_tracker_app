import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

/// Home view model
/// Manages the state of the home screen
@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<bool> build() async {
    // Simulate some loading time
    await Future.delayed(const Duration(seconds: 1));

    // Return a success state
    return true;
  }

  /// Example action that triggers a state change
  Future<void> performAction() async {
    // Set state to loading
    state = const AsyncLoading();

    try {
      // Perform some async action
      await Future.delayed(const Duration(seconds: 2));

      // Update state with success
      state = const AsyncData(true);
    } catch (e, stackTrace) {
      // Update state with error
      state = AsyncError(e, stackTrace);
    }
  }
}

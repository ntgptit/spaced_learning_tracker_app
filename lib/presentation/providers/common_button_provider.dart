// lib/presentation/providers/common_button_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'common_button_provider.g.dart';

/// Button state types for different button behaviors
enum ButtonStateType { loading, toggle, selection, expansion, fab }

/// Generic button state data
class ButtonStateData {
  final bool isLoading;
  final bool isToggled;
  final bool isExpanded;
  final bool isSelected;
  final List<String> selectedItems;
  final String? selectedValue;

  const ButtonStateData({
    this.isLoading = false,
    this.isToggled = false,
    this.isExpanded = false,
    this.isSelected = false,
    this.selectedItems = const [],
    this.selectedValue,
  });

  ButtonStateData copyWith({
    bool? isLoading,
    bool? isToggled,
    bool? isExpanded,
    bool? isSelected,
    List<String>? selectedItems,
    String? selectedValue,
  }) {
    return ButtonStateData(
      isLoading: isLoading ?? this.isLoading,
      isToggled: isToggled ?? this.isToggled,
      isExpanded: isExpanded ?? this.isExpanded,
      isSelected: isSelected ?? this.isSelected,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedValue: selectedValue ?? this.selectedValue,
    );
  }
}

/// Common button state provider with ID-based state management
@riverpod
class CommonButtonState extends _$CommonButtonState {
  @override
  Map<String, ButtonStateData> build() => {};

  /// Get state data for a specific button ID
  ButtonStateData getButtonState(String buttonId) {
    return state[buttonId] ?? const ButtonStateData();
  }

  /// Set loading state for a button
  void setLoading(String buttonId, bool isLoading) {
    final currentState = getButtonState(buttonId);
    state = {...state, buttonId: currentState.copyWith(isLoading: isLoading)};
  }

  /// Toggle state for a button
  void toggle(String buttonId) {
    final currentState = getButtonState(buttonId);
    state = {
      ...state,
      buttonId: currentState.copyWith(isToggled: !currentState.isToggled),
    };
  }

  /// Set toggle value directly
  void setToggle(String buttonId, bool value) {
    final currentState = getButtonState(buttonId);
    state = {...state, buttonId: currentState.copyWith(isToggled: value)};
  }

  /// Set expansion state
  void setExpanded(String buttonId, bool isExpanded) {
    final currentState = getButtonState(buttonId);
    state = {...state, buttonId: currentState.copyWith(isExpanded: isExpanded)};
  }

  /// Toggle expansion
  void toggleExpansion(String buttonId) {
    final currentState = getButtonState(buttonId);
    state = {
      ...state,
      buttonId: currentState.copyWith(isExpanded: !currentState.isExpanded),
    };
  }

  /// Set selection state
  void setSelected(String buttonId, bool isSelected) {
    final currentState = getButtonState(buttonId);
    state = {...state, buttonId: currentState.copyWith(isSelected: isSelected)};
  }

  /// Toggle selection
  void toggleSelection(String buttonId) {
    final currentState = getButtonState(buttonId);
    state = {
      ...state,
      buttonId: currentState.copyWith(isSelected: !currentState.isSelected),
    };
  }

  /// Add item to selection list
  void addToSelection(String buttonId, String item) {
    final currentState = getButtonState(buttonId);
    final updatedItems = [...currentState.selectedItems];

    if (!updatedItems.contains(item)) {
      updatedItems.add(item);
      state = {
        ...state,
        buttonId: currentState.copyWith(selectedItems: updatedItems),
      };
    }
  }

  /// Remove item from selection list
  void removeFromSelection(String buttonId, String item) {
    final currentState = getButtonState(buttonId);
    final updatedItems = currentState.selectedItems
        .where((i) => i != item)
        .toList();

    state = {
      ...state,
      buttonId: currentState.copyWith(selectedItems: updatedItems),
    };
  }

  /// Toggle item in selection list
  void toggleItemSelection(String buttonId, String item) {
    final currentState = getButtonState(buttonId);

    if (currentState.selectedItems.contains(item)) {
      removeFromSelection(buttonId, item);
      return;
    }

    addToSelection(buttonId, item);
  }

  /// Set selected value for single selection
  void setSelectedValue(String buttonId, String? value) {
    final currentState = getButtonState(buttonId);
    state = {...state, buttonId: currentState.copyWith(selectedValue: value)};
  }

  /// Clear all state for a button
  void clearButtonState(String buttonId) {
    final newState = Map<String, ButtonStateData>.from(state);
    newState.remove(buttonId);
    state = newState;
  }

  /// Clear all states
  void clearAllStates() {
    state = {};
  }

  /// Check if button is in loading state
  bool isLoading(String buttonId) => getButtonState(buttonId).isLoading;

  /// Check if button is toggled
  bool isToggled(String buttonId) => getButtonState(buttonId).isToggled;

  /// Check if button is expanded
  bool isExpanded(String buttonId) => getButtonState(buttonId).isExpanded;

  /// Check if button is selected
  bool isSelected(String buttonId) => getButtonState(buttonId).isSelected;

  /// Get selected items for a button
  List<String> getSelectedItems(String buttonId) =>
      getButtonState(buttonId).selectedItems;

  /// Get selected value for a button
  String? getSelectedValue(String buttonId) =>
      getButtonState(buttonId).selectedValue;

  /// Check if item is selected in a button's selection list
  bool isItemSelected(String buttonId, String item) {
    return getButtonState(buttonId).selectedItems.contains(item);
  }
}

/// Convenience providers for specific button states
@riverpod
bool buttonIsLoading(Ref ref, String buttonId) {
  final stateMap = ref.watch(commonButtonStateProvider);
  final buttonState = stateMap[buttonId] ?? const ButtonStateData();
  return buttonState.isLoading;
}

@riverpod
bool buttonIsToggled(Ref ref, String buttonId) {
  final stateMap = ref.watch(commonButtonStateProvider);
  final buttonState = stateMap[buttonId] ?? const ButtonStateData();
  return buttonState.isToggled;
}

@riverpod
bool buttonIsExpanded(Ref ref, String buttonId) {
  final stateMap = ref.watch(commonButtonStateProvider);
  final buttonState = stateMap[buttonId] ?? const ButtonStateData();
  return buttonState.isExpanded;
}

@riverpod
bool buttonIsSelected(Ref ref, String buttonId) {
  final stateMap = ref.watch(commonButtonStateProvider);
  final buttonState = stateMap[buttonId] ?? const ButtonStateData();
  return buttonState.isSelected;
}

@riverpod
List<String> buttonSelectedItems(Ref ref, String buttonId) {
  final stateMap = ref.watch(commonButtonStateProvider);
  final buttonState = stateMap[buttonId] ?? const ButtonStateData();
  return buttonState.selectedItems;
}

@riverpod
String? buttonSelectedValue(Ref ref, String buttonId) {
  final stateMap = ref.watch(commonButtonStateProvider);
  final buttonState = stateMap[buttonId] ?? const ButtonStateData();
  return buttonState.selectedValue;
}

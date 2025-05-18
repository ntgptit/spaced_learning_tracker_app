// lib/presentation/viewmodels/bottom_navigation_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_navigation_provider.g.dart';

enum BottomNavigationTab { home, books, due, stats, profile }

@riverpod
class BottomNavigationState extends _$BottomNavigationState {
  @override
  BottomNavigationTab build() {
    return BottomNavigationTab.home;
  }

  void setActiveTab(BottomNavigationTab tab) {
    state = tab;
  }

  void goToHome() {
    state = BottomNavigationTab.home;
  }

  void goToBooks() {
    state = BottomNavigationTab.books;
  }

  void goToDue() {
    state = BottomNavigationTab.due;
  }

  void goToStats() {
    state = BottomNavigationTab.stats;
  }

  void goToProfile() {
    state = BottomNavigationTab.profile;
  }
}

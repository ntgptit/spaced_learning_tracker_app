import 'package:flutter/material.dart';
import 'package:slt_app/core/constants/app_constants.dart';
import 'package:slt_app/core/services/local_storage_service.dart';

/// Theme service
/// Handles theme mode preferences
class ThemeService {
  final LocalStorageService _localStorage;

  ThemeService({required LocalStorageService localStorage})
      : _localStorage = localStorage;

  /// Get current theme mode
  ThemeMode getThemeMode() {
    final themeModeStr = _localStorage.getString(AppConstants.prefKeyThemeMode);

    if (themeModeStr == null) {
      return ThemeMode.system;
    }

    switch (themeModeStr) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Save theme mode
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    String themeModeStr;

    switch (themeMode) {
      case ThemeMode.light:
        themeModeStr = 'light';
        break;
      case ThemeMode.dark:
        themeModeStr = 'dark';
        break;
      case ThemeMode.system:
        themeModeStr = 'system';
        break;
    }

    await _localStorage.saveString(AppConstants.prefKeyThemeMode, themeModeStr);
  }

  /// Set light theme
  Future<void> setLightMode() async {
    await saveThemeMode(ThemeMode.light);
  }

  /// Set dark theme
  Future<void> setDarkMode() async {
    await saveThemeMode(ThemeMode.dark);
  }

  /// Set system theme
  Future<void> setSystemMode() async {
    await saveThemeMode(ThemeMode.system);
  }

  /// Toggle between light and dark mode
  Future<ThemeMode> toggleThemeMode() async {
    final currentThemeMode = getThemeMode();
    ThemeMode newThemeMode;

    if (currentThemeMode == ThemeMode.light) {
      newThemeMode = ThemeMode.dark;
    } else {
      newThemeMode = ThemeMode.light;
    }

    await saveThemeMode(newThemeMode);
    return newThemeMode;
  }

  /// Check if currently in dark mode
  bool isDarkMode(BuildContext context) {
    final themeMode = getThemeMode();

    if (themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }

    return themeMode == ThemeMode.dark;
  }
}

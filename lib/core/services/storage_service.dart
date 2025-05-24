import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class StorageService {
  final FlutterSecureStorage _secureStorage;
  final Future<SharedPreferences> _prefs;

  StorageService({
    FlutterSecureStorage? secureStorage,
    Future<SharedPreferences>? prefs,
  })  : _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _prefs = prefs ?? SharedPreferences.getInstance();

  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.tokenKey);
    } catch (e) {
      debugPrint('Error retrieving token: $e');
      await clearTokens();
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.refreshTokenKey);
    } catch (e) {
      debugPrint('Error retrieving refresh token: $e');
      await clearTokens();
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final prefs = await _prefs;
      final userData = prefs.getString(AppConstants.userKey);

      if (userData == null) {
        return null;
      }

      return jsonDecode(userData) as Map<String, dynamic>;
    } catch (e) {
      debugPrint('Error retrieving user data: $e');
      return null;
    }
  }

  Future<bool> isDarkMode() async {
    try {
      final prefs = await _prefs;
      return prefs.getBool(AppConstants.darkModeKey) ?? false;
    } catch (e) {
      debugPrint('Error retrieving dark mode setting: $e');
      return false;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await _secureStorage.write(key: AppConstants.tokenKey, value: token);
    } catch (e) {
      debugPrint('Error saving token: $e');
      await clearTokens();
      try {
        await _secureStorage.write(key: AppConstants.tokenKey, value: token);
      } catch (e) {
        debugPrint('Failed to save token after reset: $e');
        await resetSecureStorage();
      }
    }
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _secureStorage.write(
        key: AppConstants.refreshTokenKey,
        value: refreshToken,
      );
    } catch (e) {
      debugPrint('Error saving refresh token: $e');
      await clearTokens();
      try {
        await _secureStorage.write(
          key: AppConstants.refreshTokenKey,
          value: refreshToken,
        );
      } catch (e) {
        debugPrint('Failed to save refresh token after reset: $e');
        await resetSecureStorage();
      }
    }
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final prefs = await _prefs;
      await prefs.setString(AppConstants.userKey, jsonEncode(userData));
    } catch (e) {
      debugPrint('Error saving user data: $e');
    }
  }

  Future<void> saveDarkMode(bool isDarkMode) async {
    try {
      final prefs = await _prefs;
      await prefs.setBool(AppConstants.darkModeKey, isDarkMode);
    } catch (e) {
      debugPrint('Error saving dark mode setting: $e');
    }
  }

  Future<void> clearTokens() async {
    try {
      await _secureStorage.delete(key: AppConstants.tokenKey);
      await _secureStorage.delete(key: AppConstants.refreshTokenKey);
    } catch (e) {
      debugPrint('Error clearing tokens: $e');
      await resetSecureStorage();
    }
  }

  Future<void> clearUserData() async {
    try {
      final prefs = await _prefs;
      await prefs.remove(AppConstants.userKey);
    } catch (e) {
      debugPrint('Error clearing user data: $e');
    }
  }

  Future<void> resetSecureStorage() async {
    try {
      await _secureStorage.deleteAll();
      debugPrint('Reset all secure storage due to cryptographic error');
    } catch (e) {
      debugPrint('Error resetting secure storage: $e');
    }
  }

  Future<String?> getString(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getString(key);
    } catch (e) {
      debugPrint('Error retrieving string ($key): $e');
      return null;
    }
  }

  Future<void> setString(String key, String value) async {
    try {
      final prefs = await _prefs;
      await prefs.setString(key, value);
    } catch (e) {
      debugPrint('Error setting string ($key): $e');
    }
  }

  Future<bool?> getBool(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getBool(key);
    } catch (e) {
      debugPrint('Error retrieving boolean ($key): $e');
      return null;
    }
  }

  Future<void> setBool(String key, bool value) async {
    try {
      final prefs = await _prefs;
      await prefs.setBool(key, value);
    } catch (e) {
      debugPrint('Error setting boolean ($key): $e');
    }
  }

  Future<int?> getInt(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getInt(key);
    } catch (e) {
      debugPrint('Error retrieving int ($key): $e');
      return null;
    }
  }

  Future<void> setInt(String key, int value) async {
    try {
      final prefs = await _prefs;
      await prefs.setInt(key, value);
    } catch (e) {
      debugPrint('Error setting int ($key): $e');
    }
  }

  Future<double?> getDouble(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getDouble(key);
    } catch (e) {
      debugPrint('Error retrieving double ($key): $e');
      return null;
    }
  }

  Future<void> setDouble(String key, double value) async {
    try {
      final prefs = await _prefs;
      await prefs.setDouble(key, value);
    } catch (e) {
      debugPrint('Error setting double ($key): $e');
    }
  }

  Future<List<String>?> getStringList(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.getStringList(key);
    } catch (e) {
      debugPrint('Error retrieving string list ($key): $e');
      return null;
    }
  }

  Future<void> setStringList(String key, List<String> value) async {
    try {
      final prefs = await _prefs;
      await prefs.setStringList(key, value);
    } catch (e) {
      debugPrint('Error setting string list ($key): $e');
    }
  }
}

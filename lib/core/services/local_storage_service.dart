import 'package:shared_preferences/shared_preferences.dart';

/// Local storage service
/// Wrapper around SharedPreferences for easy access
class LocalStorageService {
  final SharedPreferences _sharedPreferences;

  LocalStorageService({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  /// Save string to storage
  Future<bool> saveString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  /// Get string from storage
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  /// Save int to storage
  Future<bool> saveInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }

  /// Get int from storage
  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  /// Save double to storage
  Future<bool> saveDouble(String key, double value) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  /// Get double from storage
  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  /// Save bool to storage
  Future<bool> saveBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  /// Get bool from storage
  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  /// Save string list to storage
  Future<bool> saveStringList(String key, List<String> value) async {
    return await _sharedPreferences.setStringList(key, value);
  }

  /// Get string list from storage
  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  /// Check if storage contains key
  bool containsKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  /// Remove value from storage
  Future<bool> remove(String key) async {
    return await _sharedPreferences.remove(key);
  }

  /// Clear all values from storage
  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  /// Get all keys from storage
  Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }

  /// Get storage instance
  SharedPreferences get instance => _sharedPreferences;
}

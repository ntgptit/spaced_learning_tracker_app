import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage service
/// Wrapper around FlutterSecureStorage for easy access
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  /// Save value to secure storage
  Future<void> save(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  /// Get value from secure storage
  Future<String?> get(String key) async {
    return await _secureStorage.read(key: key);
  }

  /// Check if secure storage contains key
  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }

  /// Remove value from secure storage
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }

  /// Clear all values from secure storage
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }

  /// Save value to secure storage with options
  Future<void> saveWithOptions(
    String key,
    String value,
    IOSOptions iosOptions,
    AndroidOptions androidOptions,
  ) async {
    await _secureStorage.write(
      key: key,
      value: value,
      iOptions: iosOptions,
      aOptions: androidOptions,
    );
  }

  /// Get all values from secure storage
  Future<Map<String, String>> getAll() async {
    return await _secureStorage.readAll();
  }

  /// Get secure storage instance
  FlutterSecureStorage get instance => _secureStorage;
}

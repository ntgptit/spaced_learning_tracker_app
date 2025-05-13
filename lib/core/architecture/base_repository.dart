import 'package:slt_app/core/architecture/result.dart';

/// Base repository interface for all repositories
/// Defines common methods for all repositories
abstract class BaseRepository {
  /// Get all items
  Future<Result<List<T>>> getAll<T>();

  /// Get item by id
  Future<Result<T>> getById<T>(String id);

  /// Create item
  Future<Result<T>> create<T>(T item);

  /// Update item
  Future<Result<T>> update<T>(T item);

  /// Delete item by id
  Future<Result<bool>> delete<T>(String id);
}

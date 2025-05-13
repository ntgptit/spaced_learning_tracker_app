import 'package:slt_app/core/architecture/result.dart';

/// Base use case class for all use cases
/// [T] is the return type of the use case
/// [P] is the parameter type of the use case
abstract class UseCase<T, P> {
  /// Execute the use case with the given parameters
  Future<Result<T>> call(P params);
}

/// Use case with no parameters
abstract class NoParamsUseCase<T> extends UseCase<T, NoParams> {
  /// Execute the use case with no parameters
  @override
  Future<Result<T>> call([NoParams params = const NoParams()]);
}

/// No parameters class for use cases that don't require parameters
class NoParams {
  const NoParams();
}
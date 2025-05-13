import 'failure.dart';

/// Result class for handling success and failure states
abstract class Result<T> {
  const Result._();

  const factory Result.success(T value) = Success<T>;

  const factory Result.failure(Failure failure) = FailureResult<T>;

  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  });

  bool get isSuccess;

  bool get isFailure;

  T? get getOrNull;
}

class Success<T> extends Result<T> {
  final T value;

  const Success(this.value) : super._();

  @override
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) {
    return success(value);
  }

  @override
  bool get isSuccess => true;

  @override
  bool get isFailure => false;

  @override
  T? get getOrNull => value;
}

class FailureResult<T> extends Result<T> {
  final Failure failure;

  const FailureResult(this.failure) : super._();

  @override
  R when<R>({
    required R Function(T value) success,
    required R Function(Failure failure) failure,
  }) {
    return failure(this.failure);
  }

  @override
  bool get isSuccess => false;

  @override
  bool get isFailure => true;

  @override
  T? get getOrNull => null;
}

extension ResultExtensions<T> on Result<T> {
  T getOrDefault(T defaultValue) {
    return when(
      success: (value) => value,
      failure: (_) => defaultValue,
    );
  }

  T getOrThrow() {
    return when(
      success: (value) => value,
      failure: (failure) => throw Exception(failure.message),
    );
  }

  Result<T> onSuccess(void Function(T value) action) {
    when(
      success: action,
      failure: (_) {},
    );
    return this;
  }

  Result<T> onFailure(void Function(Failure failure) action) {
    when(
      success: (_) {},
      failure: action,
    );
    return this;
  }

  Result<R> flatMap<R>(Result<R> Function(T value) mapper) {
    return when(
      success: (value) => mapper(value),
      failure: (failure) => Result.failure(failure),
    );
  }

  Result<R> map<R>(R Function(T) mapper) {
    return when(
      success: (value) => Result.success(mapper(value)),
      failure: (failure) => Result.failure(failure),
    );
  }
}

Result<T> guard<T>(T Function() fn) {
  try {
    return Result.success(fn());
  } catch (e) {
    if (e is Failure) {
      return Result.failure(e);
    }
    return Result.failure(UnknownFailure(message: e.toString()));
  }
}

Future<Result<T>> guardFuture<T>(Future<T> Function() fn) async {
  try {
    return Result.success(await fn());
  } catch (e) {
    if (e is Failure) {
      return Result.failure(e);
    }
    return Result.failure(UnknownFailure(message: e.toString()));
  }
}

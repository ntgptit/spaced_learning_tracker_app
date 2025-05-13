import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slt_app/core/architecture/base_use_case.dart';
import 'package:slt_app/core/architecture/result.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

part 'register_use_case.g.dart';

/// Register use case parameters
class RegisterParams {
  final String name;
  final String email;
  final String password;

  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

/// Register use case provider
@riverpod
RegisterUseCase registerUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(authRepository);
}

/// Register use case
class RegisterUseCase extends UseCase<User, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<Result<User>> call(RegisterParams params) async {
    return await _authRepository.register(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

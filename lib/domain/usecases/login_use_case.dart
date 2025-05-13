import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:slt_app/core/architecture/base_use_case.dart';
import 'package:slt_app/core/architecture/result.dart';
import 'package:slt_app/domain/repositories/auth_repository.dart';

import '../entities/user.dart';

part 'login_use_case.g.dart';

/// Login use case parameters
class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}

/// Login use case provider
@riverpod
LoginUseCase loginUseCase(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUseCase(authRepository);
}

/// Login use case
class LoginUseCase extends UseCase<User, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<Result<User>> call(LoginParams params) async {
    return await _authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

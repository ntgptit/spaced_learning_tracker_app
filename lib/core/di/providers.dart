import 'package:event_bus/event_bus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/core/network/api_client.dart';
import 'package:spaced_learning_app/core/services/storage_service.dart';
import 'package:spaced_learning_app/data/repositories/auth_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/book_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/learning_stats_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/module_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/progress_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/repetition_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/user_repository_impl.dart';
import 'package:spaced_learning_app/domain/repositories/auth_repository.dart';
import 'package:spaced_learning_app/domain/repositories/book_repository.dart';
import 'package:spaced_learning_app/domain/repositories/learning_stats_repository.dart';
import 'package:spaced_learning_app/domain/repositories/module_repository.dart';
import 'package:spaced_learning_app/domain/repositories/progress_repository.dart';
import 'package:spaced_learning_app/domain/repositories/repetition_repository.dart';
import 'package:spaced_learning_app/domain/repositories/user_repository.dart';

import '../../data/repositories/learning_repository_impl.dart';
import '../../domain/repositories/learning_repository.dart';

part 'providers.g.dart';


@riverpod
ApiClient apiClient(Ref ref) => ApiClient();

@riverpod
StorageService storageService(Ref ref) => StorageService();

@Riverpod(keepAlive: true)
EventBus eventBus(Ref ref) => EventBus();



@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepositoryImpl(ref.read(apiClientProvider));

@riverpod
BookRepository bookRepository(Ref ref) =>
    BookRepositoryImpl(ref.read(apiClientProvider));

@riverpod
ModuleRepository moduleRepository(Ref ref) =>
    ModuleRepositoryImpl(ref.read(apiClientProvider));

@riverpod
ProgressRepository progressRepository(Ref ref) =>
    ProgressRepositoryImpl(ref.read(apiClientProvider));

@riverpod
RepetitionRepository repetitionRepository(Ref ref) =>
    RepetitionRepositoryImpl(ref.read(apiClientProvider));

@riverpod
UserRepository userRepository(Ref ref) =>
    UserRepositoryImpl(ref.read(apiClientProvider));

@riverpod
LearningStatsRepository learningStatsRepository(Ref ref) =>
    LearningStatsRepositoryImpl(ref.read(apiClientProvider));


@riverpod
LearningRepository learningRepository(Ref ref) {
  return LearningRepositoryImpl(ref.read(apiClientProvider));
}



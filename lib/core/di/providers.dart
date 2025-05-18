import 'package:event_bus/event_bus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spaced_learning_app/core/network/api_client.dart';
import 'package:spaced_learning_app/core/services/storage_service.dart';
import 'package:spaced_learning_app/data/repositories/auth_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/book_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/learning_progress_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/learning_stats_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/module_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/progress_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/repetition_repository_impl.dart';
import 'package:spaced_learning_app/data/repositories/user_repository_impl.dart';
import 'package:spaced_learning_app/domain/repositories/auth_repository.dart';
import 'package:spaced_learning_app/domain/repositories/book_repository.dart';
import 'package:spaced_learning_app/domain/repositories/learning_progress_repository.dart';
import 'package:spaced_learning_app/domain/repositories/learning_stats_repository.dart';
import 'package:spaced_learning_app/domain/repositories/module_repository.dart';
import 'package:spaced_learning_app/domain/repositories/progress_repository.dart';
import 'package:spaced_learning_app/domain/repositories/repetition_repository.dart';
import 'package:spaced_learning_app/domain/repositories/user_repository.dart';

import '../../data/repositories/learning_repository_impl.dart';
import '../../data/repositories/progress_repository_impl.dart';
import '../../domain/repositories/learning_repository.dart';
import '../network/api_client.dart';

part 'providers.g.dart';

// CORE SERVICES

@riverpod
ApiClient apiClient(Ref ref) => ApiClient();

@riverpod
StorageService storageService(Ref ref) => StorageService();

@Riverpod(keepAlive: true)
EventBus eventBus(Ref ref) => EventBus();

// @riverpod
// DeviceSettingsService deviceSettingsService(Ref ref) => DeviceSettingsService();
//
// // DEVICE SPECIFIC SERVICES
//
// @Riverpod(keepAlive: true)
// FutureOr<DeviceSpecificService> deviceSpecificService(Ref ref) async {
//   final deviceService = DeviceSpecificService(
//     deviceSettingsService: ref.read(deviceSettingsServiceProvider),
//   );
//   await deviceService.initialize();
//   return deviceService;
// }
//
// // NOTIFICATION SERVICES
//
// @Riverpod(keepAlive: true)
// FutureOr<NotificationService> notificationService(Ref ref) async {
//   final deviceService = await ref.watch(deviceSpecificServiceProvider.future);
//   final notificationService = NotificationService(
//     deviceSpecificService: deviceService,
//   );
//   await notificationService.initialize();
//   return notificationService;
// }
//
// @riverpod
// AlarmManagerService alarmManagerService(Ref ref) => AlarmManagerService(
//   deviceSpecificService: ref.watch(
//     deviceSpecificServiceProvider.future
//         as ProviderListenable<DeviceSpecificService>,
//   ),
// );
//
// @riverpod
// CloudReminderService cloudReminderService(Ref ref) => CloudReminderService(
//   storageService: ref.read(storageServiceProvider),
//   notificationService: ref.watch(
//     notificationServiceProvider.future
//         as ProviderListenable<NotificationService>,
//   ),
// );
//
// @Riverpod(keepAlive: true)
// FutureOr<ReminderService> reminderService(Ref ref) async {
//   final notificationService = await ref.watch(
//     notificationServiceProvider.future,
//   );
//   return ReminderService(
//     notificationService: notificationService,
//     storageService: ref.read(storageServiceProvider),
//     deviceSpecificService: await ref.watch(
//       deviceSpecificServiceProvider.future,
//     ),
//     progressRepository: ref.read(progressRepositoryProvider),
//     eventBus: ref.read(eventBusProvider),
//   );
// }

// REPOSITORIES

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

// @riverpod
// LearningProgressRepository learningProgressRepository(Ref ref) =>
//     LearningProgressRepositoryImpl(ref.read(apiClientProvider));

@riverpod
LearningRepository learningRepository(Ref ref) {
  return LearningRepositoryImpl(ref.read(apiClientProvider));
}

// DATA SERVICES

// @riverpod
// LearningDataService learningDataService(Ref ref) =>
//     LearningDataServiceImpl(ref.read(learningProgressRepositoryProvider));
//
// @Riverpod(keepAlive: true)
// FutureOr<DailyTaskChecker> dailyTaskChecker(Ref ref) async {
//   final reminderService = await ref.watch(reminderServiceProvider.future);
//
//   final dailyTaskChecker = DailyTaskChecker(
//     progressRepository: ref.read(progressRepositoryProvider),
//     storageService: ref.read(storageServiceProvider),
//     eventBus: ref.read(eventBusProvider),
//     reminderService: reminderService,
//     notificationsPlugin: FlutterLocalNotificationsPlugin(),
//   );
//
//   return dailyTaskChecker;
// }

import 'package:spaced_learning_app/domain/models/learning_module.dart';

abstract class LearningRepository {
  // Các phương thức từ cả hai service/repository

  // Từ LearningProgressRepository
  Future<List<LearningModule>> getAllModules();

  Future<Map<String, dynamic>> getDashboardStats({
    String? book,
    DateTime? date,
  });

  Future<Map<String, dynamic>> exportData();

  // Từ LearningDataService - với tên phương thức gốc để đảm bảo tương thích
  Future<List<LearningModule>>
  getModules(); // <-- QUAN TRỌNG: Giữ lại phương thức này
  List<LearningModule> filterByBook(List<LearningModule> modules, String book);

  List<LearningModule> filterByDate(
    List<LearningModule> modules,
    DateTime date,
  );

  bool isSameDay(DateTime date1, DateTime date2);

  int countDueModules(List<LearningModule> modules, {int daysThreshold = 7});

  int countCompletedModules(List<LearningModule> modules);

  List<String> getUniqueBooks(List<LearningModule> modules);

  int getActiveModulesCount(List<LearningModule> modules);

  List<LearningModule> getDueToday(List<LearningModule> modules);

  List<LearningModule> getDueThisWeek(List<LearningModule> modules);

  List<LearningModule> getDueThisMonth(List<LearningModule> modules);

  void resetCache();
}

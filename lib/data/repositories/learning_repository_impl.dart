import 'package:flutter/material.dart';
import 'package:spaced_learning_app/core/constants/api_endpoints.dart';
import 'package:spaced_learning_app/core/network/api_client.dart';
import 'package:spaced_learning_app/domain/models/learning_module.dart';
import 'package:spaced_learning_app/domain/repositories/learning_repository.dart';

class LearningRepositoryImpl implements LearningRepository {
  final ApiClient _apiClient;
  List<LearningModule>? _cachedModules;

  LearningRepositoryImpl(this._apiClient);


  @override
  Future<List<LearningModule>> getAllModules() async {
    try {
      final response = await _apiClient.get(ApiEndpoints.learningModules);

      if (response != null && response['data'] != null) {
        final List<dynamic> modulesData = response['data'];
        final modules = modulesData
            .map((data) => LearningModule.fromJson(data))
            .toList();

        return modules;
      }

      return [];
    } catch (e) {
      debugPrint('Error in getAllModules: $e');
      return [];
    }
  }

  @override
  Future<List<LearningModule>> getModules() async {
    if (_cachedModules != null) {
      return _cachedModules!;
    }

    try {
      final modules = await getAllModules();
      _cachedModules = modules;
      return modules;
    } catch (e) {
      debugPrint('Error in getModules: $e');
      return [];
    }
  }

  @override
  Future<Map<String, dynamic>> getDashboardStats({
    String? book,
    DateTime? date,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (book != null && book != 'All') {
        queryParams['book'] = book;
      }

      if (date != null) {
        queryParams['date'] = date.toIso8601String().split('T').first;
      }

      final response = await _apiClient.get(
        ApiEndpoints.dashboardStats,
        queryParameters: queryParams,
      );

      if (response != null && response['data'] != null) {
        return response['data'];
      }

      return {};
    } catch (e) {
      debugPrint('Error in getDashboardStats: $e');
      return {};
    }
  }

  @override
  Future<Map<String, dynamic>> exportData() async {
    try {
      final response = await _apiClient.post(ApiEndpoints.exportData);

      if (response != null && response['data'] != null) {
        return response['data'];
      }

      return {};
    } catch (e) {
      debugPrint('Error in exportData: $e');
      return {};
    }
  }


  @override
  List<LearningModule> filterByBook(List<LearningModule> modules, String book) {
    if (book == 'All') {
      return modules;
    }
    return modules.where((module) => module.bookName == book).toList();
  }

  @override
  List<LearningModule> filterByDate(
    List<LearningModule> modules,
    DateTime date,
  ) {
    return modules
        .where(
          (module) =>
              module.progressNextStudyDate != null &&
              isSameDay(module.progressNextStudyDate!, date),
        )
        .toList();
  }

  @override
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  int countDueModules(List<LearningModule> modules, {int daysThreshold = 7}) {
    final today = DateTime.now();
    final dueDate = today.add(Duration(days: daysThreshold));

    return modules
        .where(
          (module) =>
              module.progressNextStudyDate != null &&
              module.progressNextStudyDate!.isAfter(
                today.subtract(const Duration(days: 1)),
              ) &&
              module.progressNextStudyDate!.isBefore(dueDate),
        )
        .length;
  }

  @override
  int countCompletedModules(List<LearningModule> modules) {
    return modules
        .where((module) => (module.progressLatestPercentComplete ?? 0) == 100)
        .length;
  }

  @override
  List<String> getUniqueBooks(List<LearningModule> modules) {
    if (modules.isEmpty) return ['All'];
    final books = modules.map((module) => module.bookName).toSet().toList()
      ..sort();
    return ['All', ...books];
  }

  @override
  int getActiveModulesCount(List<LearningModule> modules) {
    return modules
        .where((module) => (module.progressLatestPercentComplete ?? 0) < 100)
        .length;
  }

  @override
  List<LearningModule> getDueToday(List<LearningModule> modules) {
    final today = DateTime.now();
    return modules
        .where(
          (module) =>
              module.progressNextStudyDate != null &&
              isSameDay(module.progressNextStudyDate!, today),
        )
        .toList();
  }

  @override
  List<LearningModule> getDueThisWeek(List<LearningModule> modules) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));

    return modules
        .where(
          (module) =>
              module.progressNextStudyDate != null &&
              module.progressNextStudyDate!.isAfter(
                weekStart.subtract(const Duration(days: 1)),
              ) &&
              module.progressNextStudyDate!.isBefore(
                weekEnd.add(const Duration(days: 1)),
              ),
        )
        .toList();
  }

  @override
  List<LearningModule> getDueThisMonth(List<LearningModule> modules) {
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);
    final monthEnd = (now.month < 12)
        ? DateTime(now.year, now.month + 1, 0)
        : DateTime(now.year + 1, 1, 0);

    return modules
        .where(
          (module) =>
              module.progressNextStudyDate != null &&
              module.progressNextStudyDate!.isAfter(
                monthStart.subtract(const Duration(days: 1)),
              ) &&
              module.progressNextStudyDate!.isBefore(
                monthEnd.add(const Duration(days: 1)),
              ),
        )
        .toList();
  }

  @override
  void resetCache() {
    _cachedModules = null;
  }
}

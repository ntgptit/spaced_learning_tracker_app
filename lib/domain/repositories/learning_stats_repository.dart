import '../models/learning_insight.dart';
import '../models/learning_stats.dart';

abstract class LearningStatsRepository {
  Future<LearningStatsDTO> getDashboardStats({bool refreshCache = false});

  Future<List<LearningInsightRespone>> getLearningInsights();
}

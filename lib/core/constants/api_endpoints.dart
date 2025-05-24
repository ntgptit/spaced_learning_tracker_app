import 'app_constants.dart';

class ApiEndpoints {
  static String basePath = AppConstants.baseUrl + AppConstants.apiPrefix;

  static final String login = '$basePath/auth/login';
  static final String register = '$basePath/auth/register';
  static final String refreshToken = '$basePath/auth/refresh-token';
  static final String validateToken = '$basePath/auth/validate';

  static final String currentUser = '$basePath/users/me';
  static final String users = '$basePath/users';

  static final String books = '$basePath/books';
  static final String bookCategories = '$basePath/books/categories';
  static final String bookSearch = '$basePath/books/search';
  static final String bookFilter = '$basePath/books/filter';

  static final String modules = '$basePath/modules';

  static String modulesByBook(String bookId) =>
      '$basePath/modules/book/$bookId';


  static final String progress = '$basePath/progress';

  static String dueProgress(String userId) => '$basePath/progress/due';

  static final String repetitions = '$basePath/repetitions';

  static String repetitionsByProgress(String progressId) =>
      '$basePath/repetitions/progress/$progressId';

  static String repetitionSchedule(String progressId) =>
      '$basePath/repetitions/progress/$progressId/schedule';


  static final String dashboardStats = '$basePath/stats/dashboard';

  static final String learningInsights = '$basePath/stats/insights';


  static final String learningModules = '$basePath/learning/modules';
  static final String dueModules = '$basePath/learning/modules/due';

  static final String uniqueBooks = '$basePath/learning/books';

  static final String exportData = '$basePath/learning/export';
}

/// App constants
/// All constants are defined here to ensure consistency across the app
class AppConstants {
  // App info
  static const String appName = 'SLT App';
  static const String appVersion = '1.0.0';
  static const String appBuildNumber = '1';

  // API endpoints
  static const String apiBaseUrl = 'https://api.example.com';
  static const String apiVersion = 'v1';
  static const String apiEndpoint = '$apiBaseUrl/$apiVersion';

  // API endpoints
  static const String authEndpoint = '$apiEndpoint/auth';
  static const String usersEndpoint = '$apiEndpoint/users';
  static const String coursesEndpoint = '$apiEndpoint/courses';
  static const String lessonsEndpoint = '$apiEndpoint/lessons';
  static const String quizzesEndpoint = '$apiEndpoint/quizzes';
  static const String examsEndpoint = '$apiEndpoint/exams';
  static const String assignmentsEndpoint = '$apiEndpoint/assignments';

  // API timeout durations
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Shared preferences keys
  static const String prefKeyToken = 'auth_token';
  static const String prefKeyRefreshToken = 'refresh_token';
  static const String prefKeyUserId = 'user_id';
  static const String prefKeyUserEmail = 'user_email';
  static const String prefKeyUsername = 'username';
  static const String prefKeyIsLoggedIn = 'is_logged_in';
  static const String prefKeyLanguage = 'language';
  static const String prefKeyThemeMode = 'theme_mode';
  static const String prefKeyFirstLaunch = 'first_launch';
  static const String prefKeyLastSync = 'last_sync';

  // Secure storage keys
  static const String secureKeyToken = 'secure_auth_token';
  static const String secureKeyRefreshToken = 'secure_refresh_token';
  static const String secureKeyUserId = 'secure_user_id';
  static const String secureKeyUserCredentials = 'secure_user_credentials';

  // Database name and version
  static const String databaseName = 'slt_app.db';
  static const int databaseVersion = 1;

  // Database tables
  static const String tableUsers = 'users';
  static const String tableCourses = 'courses';
  static const String tableLessons = 'lessons';
  static const String tableQuizzes = 'quizzes';
  static const String tableExams = 'exams';
  static const String tableAssignments = 'assignments';
  static const String tableProgress = 'progress';
  static const String tableNotifications = 'notifications';

  // Cache keys
  static const String cacheKeyUserData = 'user_data';
  static const String cacheKeyCourses = 'courses';
  static const String cacheKeyLessons = 'lessons';
  static const String cacheKeyQuizzes = 'quizzes';
  static const String cacheKeyExams = 'exams';
  static const String cacheKeyAssignments = 'assignments';

  // Cache expiration durations
  static const Duration cacheExpirationUserData = Duration(days: 1);
  static const Duration cacheExpirationCourses = Duration(hours: 12);
  static const Duration cacheExpirationLessons = Duration(hours: 6);
  static const Duration cacheExpirationQuizzes = Duration(hours: 6);
  static const Duration cacheExpirationExams = Duration(hours: 6);
  static const Duration cacheExpirationAssignments = Duration(hours: 6);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Animation durations
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Date formats
  static const String dateFormatFull = 'EEEE, MMMM d, yyyy';
  static const String dateFormatShort = 'MMM d, yyyy';
  static const String dateFormatMonthYear = 'MMMM yyyy';
  static const String dateFormatTime = 'HH:mm';
  static const String dateFormatDateTime = 'MMM d, yyyy HH:mm';
  static const String dateFormatISO = 'yyyy-MM-ddTHH:mm:ssZ';

  // Validation regexes
  static final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static final RegExp passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');
  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');
  static final RegExp urlRegex = RegExp(r'^(http|https)://[a-zA-Z0-9]+([\-\.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$');

  // Debounce durations
  static const Duration debounceDurationShort = Duration(milliseconds: 300);
  static const Duration debounceDurationMedium = Duration(milliseconds: 500);
  static const Duration debounceDurationLong = Duration(milliseconds: 800);

  // Throttle durations
  static const Duration throttleDurationShort = Duration(milliseconds: 200);
  static const Duration throttleDurationMedium = Duration(milliseconds: 400);
  static const Duration throttleDurationLong = Duration(milliseconds: 600);

  // Max values
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxCommentLength = 300;
  static const int maxSearchLength = 50;
  static const int maxUsernameLength = 30;
  static const int maxPasswordLength = 50;
  static const int maxEmailLength = 100;
  static const int maxPhoneLength = 15;
  static const int maxAddressLength = 200;

  // Min values
  static const int minPasswordLength = 8;
  static const int minUsernameLength = 3;

  // File upload limits
  static const int maxFileUploadSize = 10 * 1024 * 1024; // 10 MB
  static const int maxImageUploadSize = 5 * 1024 * 1024; // 5 MB
  static const List<String> allowedFileExtensions = [
    'pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'csv'
  ];
  static const List<String> allowedImageExtensions = [
    'jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'
  ];

  // Learning constants
  static const int maxQuizAttempts = 3;
  static const int maxExamAttempts = 1;
  static const Duration quizTimeLimit = Duration(minutes: 30);
  static const Duration examTimeLimit = Duration(hours: 2);
  static const double passingScorePercentage = 70.0;

  // Analytics event names
  static const String analyticsEventAppOpen = 'app_open';
  static const String analyticsEventLogin = 'login';
  static const String analyticsEventRegister = 'register';
  static const String analyticsEventLogout = 'logout';
  static const String analyticsEventViewCourse = 'view_course';
  static const String analyticsEventStartLesson = 'start_lesson';
  static const String analyticsEventCompleteLesson = 'complete_lesson';
  static const String analyticsEventStartQuiz = 'start_quiz';
  static const String analyticsEventCompleteQuiz = 'complete_quiz';
  static const String analyticsEventStartExam = 'start_exam';
  static const String analyticsEventCompleteExam = 'complete_exam';
  static const String analyticsEventSearch = 'search';
  static const String analyticsEventError = 'error';

  // Deep link prefixes
  static const String deepLinkPrefix = 'sltapp://';
  static const String deepLinkPrefixCourse = 'sltapp://course/';
  static const String deepLinkPrefixLesson = 'sltapp://lesson/';
  static const String deepLinkPrefixQuiz = 'sltapp://quiz/';
  static const String deepLinkPrefixExam = 'sltapp://exam/';
  static const String deepLinkPrefixAssignment = 'sltapp://assignment/';

  // Notification channels
  static const String notificationChannelDefault = 'default_channel';
  static const String notificationChannelImportant = 'important_channel';
  static const String notificationChannelReminders = 'reminders_channel';

  // Error codes
  static const String errorCodeNetwork = 'ERROR_NETWORK';
  static const String errorCodeServer = 'ERROR_SERVER';
  static const String errorCodeUnauthorized = 'ERROR_UNAUTHORIZED';
  static const String errorCodeNotFound = 'ERROR_NOT_FOUND';
  static const String errorCodeBadRequest = 'ERROR_BAD_REQUEST';
  static const String errorCodeValidation = 'ERROR_VALIDATION';
  static const String errorCodeTimeout = 'ERROR_TIMEOUT';
  static const String errorCodeCancelled = 'ERROR_CANCELLED';
  static const String errorCodeUnknown = 'ERROR_UNKNOWN';

  // Status codes
  static const int statusCodeOk = 200;
  static const int statusCodeCreated = 201;
  static const int statusCodeAccepted = 202;
  static const int statusCodeNoContent = 204;
  static const int statusCodeBadRequest = 400;
  static const int statusCodeUnauthorized = 401;
  static const int statusCodeForbidden = 403;
  static const int statusCodeNotFound = 404;
  static const int statusCodeMethodNotAllowed = 405;
  static const int statusCodeConflict = 409;
  static const int statusCodeUnprocessableEntity = 422;
  static const int statusCodeInternalServerError = 500;
  static const int statusCodeServiceUnavailable = 503;

  // Enum values as strings (used for JSON serialization)
  static const String statusActive = 'active';
  static const String statusInactive = 'inactive';
  static const String statusPending = 'pending';
  static const String statusCompleted = 'completed';
  static const String statusFailed = 'failed';
  static const String statusCancelled = 'cancelled';
  static const String statusExpired = 'expired';
  static const String statusDeleted = 'deleted';

  static const String roleAdmin = 'admin';
  static const String roleTeacher = 'teacher';
  static const String roleStudent = 'student';
  static const String roleGuest = 'guest';
}
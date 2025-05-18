// lib/core/constants/app_strings.dart

/// Class quản lý tất cả các chuỗi văn bản trong ứng dụng
///
/// Giúp dễ dàng duy trì và mở rộng nội dung văn bản
/// Được thiết kế để tách biệt nội dung văn bản khỏi logic ứng dụng
/// Hỗ trợ đa ngôn ngữ thông qua các extension
class AppStrings {
  AppStrings._(); // Private constructor to prevent instantiation

  // ---------------------- COMMON ---------------------- //
  static const String appName = 'Spaced Learning App';

  // Common action verbs
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String edit = 'Edit';
  static const String delete = 'Delete';
  static const String remove = 'Remove';
  static const String add = 'Add';
  static const String create = 'Create';
  static const String update = 'Update';
  static const String confirm = 'Confirm';
  static const String retry = 'Retry';
  static const String continue_ = 'Continue';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String finish = 'Finish';
  static const String submit = 'Submit';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String sort = 'Sort';
  static const String more = 'More';
  static const String less = 'Less';
  static const String all = 'All';
  static const String none = 'None';
  static const String select = 'Select';
  static const String skip = 'Skip';

  // Common state messages
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String noInternet = 'No internet connection';
  static const String somethingWentWrong = 'Something went wrong';
  static const String tryAgain = 'Please try again';
  static const String comingSoon = 'Coming soon';
  static const String seeAll = 'See all';
  static const String required = 'Required';
  static const String optional = 'Optional';

  // ---------------------- AUTH ---------------------- //
  static const AuthStrings auth = AuthStrings();

  // ---------------------- HOME ---------------------- //
  static const HomeStrings home = HomeStrings();

  // ---------------------- LEARNING ---------------------- //
  static const LearningStrings learning = LearningStrings();

  // ---------------------- PROFILE ---------------------- //
  static const ProfileStrings profile = ProfileStrings();

  // ---------------------- SETTINGS ---------------------- //
  static const SettingsStrings settings = SettingsStrings();

  // ---------------------- ERRORS ---------------------- //
  static const ErrorStrings errors = ErrorStrings();

  // ---------------------- STATE WIDGETS ---------------------- //
  static const StateWidgetStrings stateWidgets = StateWidgetStrings();

  // ---------------------- VALIDATION ---------------------- //
  static const ValidationStrings validation = ValidationStrings();

  // ---------------------- PLACEHOLDER ---------------------- //
  static const String placeholderTitle = 'Title placeholder';
  static const String placeholderDescription = 'Description placeholder';
  static const String placeholderMessage = 'Message placeholder';
}

/// Auth related strings
class AuthStrings {
  const AuthStrings();

  // Login
  String get loginTitle => 'Log in to your account';

  String get loginSubtitle => 'Enter your credentials to continue';

  String get email => 'Email';

  String get password => 'Password';

  String get forgotPassword => 'Forgot password?';

  String get logIn => 'Log in';

  String get dontHaveAccount => 'Don\'t have an account?';

  String get signUp => 'Sign up';

  // Register
  String get registerTitle => 'Create your account';

  String get registerSubtitle => 'Fill in your details to get started';

  String get fullName => 'Full name';

  String get confirmPassword => 'Confirm password';

  String get alreadyHaveAccount => 'Already have an account?';

  String get register => 'Register';

  // Forgot password
  String get forgotPasswordTitle => 'Forgot password';

  String get forgotPasswordSubtitle =>
      'Enter your email to reset your password';

  String get resetPassword => 'Reset password';

  String get resetPasswordSuccess => 'Password reset email sent';

  String get resetPasswordSuccessMessage =>
      'Check your email for instructions to reset your password';

  // Verification
  String get verificationTitle => 'Verify your email';

  String get verificationSubtitle =>
      'We\'ve sent a verification code to your email';

  String get verificationCode => 'Verification code';

  String get verify => 'Verify';

  String get resendCode => 'Resend code';

  String get didntReceiveCode => 'Didn\'t receive a code?';

  // Change password
  String get changePasswordTitle => 'Change password';

  String get currentPassword => 'Current password';

  String get newPassword => 'New password';

  String get confirmNewPassword => 'Confirm new password';

  String get passwordChanged => 'Password changed successfully';

  // Logout
  String get logoutTitle => 'Log out';

  String get logoutConfirmation => 'Are you sure you want to log out?';

  String get logoutSuccess => 'You have been logged out successfully';
}

/// Home screen related strings
class HomeStrings {
  const HomeStrings();

  String get welcomeBack => 'Welcome back';

  String get todaySessions => 'Today\'s sessions';

  String get upcomingLessons => 'Upcoming lessons';

  String get recentProgress => 'Recent progress';

  String get quickActions => 'Quick actions';

  String get continueStudying => 'Continue studying';

  String get exploreCategories => 'Explore categories';

  String get recommendedForYou => 'Recommended for you';

  String get dailyGoal => 'Daily goal';

  String get streakDays => 'Streak days';

  String get newContent => 'New content';

  String get viewAll => 'View all';
}

/// Learning related strings
class LearningStrings {
  const LearningStrings();

  // Course/Lesson related
  String get courses => 'Courses';

  String get lessons => 'Lessons';

  String get modules => 'Modules';

  String get topics => 'Topics';

  String get flashcards => 'Flashcards';

  String get quizzes => 'Quizzes';

  String get practice => 'Practice';

  String get startLesson => 'Start lesson';

  String get continueLesson => 'Continue lesson';

  String get completeLesson => 'Complete lesson';

  String get lessonCompleted => 'Lesson completed';

  String get courseCompleted => 'Course completed';

  // Progress tracking
  String get yourProgress => 'Your progress';

  String get progressOverview => 'Progress overview';

  String get mastered => 'Mastered';

  String get learning => 'Learning';

  String get needsReview => 'Needs review';

  String get notStarted => 'Not started';

  String get completed => 'Completed';

  String get inProgress => 'In progress';

  // Flashcards
  String get front => 'Front';

  String get back => 'Back';

  String get flip => 'Flip';

  String get know => 'I know this';

  String get dontKnow => 'Don\'t know';

  String get showAnswer => 'Show answer';

  // Quiz
  String get questionOf => 'Question {current} of {total}';

  String get checkAnswer => 'Check answer';

  String get correctAnswer => 'Correct answer';

  String get wrongAnswer => 'Wrong answer';

  String get explanation => 'Explanation';

  String get quizResults => 'Quiz results';

  String get quizCompleted => 'Quiz completed';

  String get yourScore => 'Your score';

  String get review => 'Review';

  String get tryAgain => 'Try again';

  String get timeLeft => 'Time left';

  // Study reminder
  String get studyReminder => 'Study reminder';

  String get remindMe => 'Remind me';

  String get reminderSet => 'Reminder set';
}

/// Profile related strings
class ProfileStrings {
  const ProfileStrings();

  String get myProfile => 'My profile';

  String get editProfile => 'Edit profile';

  String get accountSettings => 'Account settings';

  String get achievements => 'Achievements';

  String get statistics => 'Statistics';

  String get studyHistory => 'Study history';

  String get memberSince => 'Member since';

  String get totalStudyTime => 'Total study time';

  String get averageDailyTime => 'Average daily time';

  String get longestStreak => 'Longest streak';

  String get currentStreak => 'Current streak';

  String get completedCourses => 'Completed courses';

  String get completedLessons => 'Completed lessons';

  String get masteredConcepts => 'Mastered concepts';
}

/// Settings related strings
class SettingsStrings {
  const SettingsStrings();

  String get appSettings => 'App settings';

  String get accountSettings => 'Account settings';

  String get notificationSettings => 'Notification settings';

  String get privacySettings => 'Privacy settings';

  String get language => 'Language';

  String get theme => 'Theme';

  String get darkMode => 'Dark mode';

  String get lightMode => 'Light mode';

  String get systemDefault => 'System default';

  String get pushNotifications => 'Push notifications';

  String get emailNotifications => 'Email notifications';

  String get studyReminders => 'Study reminders';

  String get dataUsage => 'Data usage';

  String get downloadOverWifi => 'Download over Wi-Fi only';

  String get autoPlayVideos => 'Auto-play videos';

  String get privacyPolicy => 'Privacy policy';

  String get termsOfService => 'Terms of service';

  String get deleteAccount => 'Delete account';

  String get deleteAccountConfirmation =>
      'Are you sure you want to delete your account? This action cannot be undone.';

  String get helpAndSupport => 'Help and support';

  String get faq => 'FAQ';

  String get contactUs => 'Contact us';

  String get aboutApp => 'About app';

  String get version => 'Version';
}

/// Error related strings
class ErrorStrings {
  const ErrorStrings();

  String get defaultError => 'Something went wrong. Please try again.';

  String get networkError =>
      'Network error. Please check your internet connection.';

  String get timeoutError => 'The request timed out. Please try again.';

  String get serverError => 'Server error. Please try again later.';

  String get unauthorizedError => 'Unauthorized. Please log in again.';

  String get notFoundError =>
      'Not found. The requested resource does not exist.';

  String get validationError => 'Validation error. Please check your input.';

  String get unknownError => 'Unknown error occurred. Please try again.';

  String get connectionError =>
      'Connection error. Please check your internet connection.';

  String get sessionExpired => 'Your session has expired. Please log in again.';

  String get permissionDenied =>
      'Permission denied. You don\'t have access to this resource.';

  String get fileNotFound =>
      'File not found. The requested file does not exist.';

  String get fileUploadError => 'File upload error. Please try again.';

  String get fileDownloadError => 'File download error. Please try again.';

  String get unsupportedFile => 'Unsupported file type.';

  String get invalidCredentials =>
      'Invalid credentials. Please check your email and password.';

  String get invalidEmail => 'Invalid email address.';

  String get invalidPassword => 'Invalid password.';

  String get invalidInput => 'Invalid input. Please check your input.';

  String get invalidVerificationCode => 'Invalid verification code.';

  String get accountNotFound => 'Account not found.';

  String get accountAlreadyExists => 'Account already exists.';

  String get accountLocked => 'Account locked. Please contact support.';

  String get accountNotVerified =>
      'Account not verified. Please verify your email.';

  String get paymentError => 'Payment error. Please try again.';

  String get subscriptionError => 'Subscription error. Please try again.';
}

/// State widget strings
class StateWidgetStrings {
  const StateWidgetStrings();

  // Empty states
  String get emptyStateTitle => 'Nothing here';

  String get emptyStateDescription => 'There\'s nothing here yet.';

  String get noResultsFound => 'No results found';

  String get noResultsDescription =>
      'We couldn\'t find any matches for your search or filters.';

  String get noDataAvailable => 'No data available';

  String get noDataDescription => 'There\'s no data available yet.';

  String get noContentAvailable => 'No content available';

  String get noContentDescription => 'There\'s no content available yet.';

  String get emptyList => 'Empty list';

  String get emptyListDescription => 'This list is empty.';

  // Loading states
  String get loadingStateTitle => 'Loading...';

  String get loadingStateDescription =>
      'Please wait while we load your content.';

  String get processingStateTitle => 'Processing...';

  String get processingStateDescription =>
      'Please wait while we process your request.';

  String get synchronizingStateTitle => 'Synchronizing...';

  String get synchronizingStateDescription =>
      'Please wait while we synchronize your data.';

  // Error states
  String get errorStateTitle => 'Oops! Something went wrong';

  String get errorStateDescription => 'An error occurred. Please try again.';

  String get networkErrorStateTitle => 'Network error';

  String get networkErrorStateDescription =>
      'Please check your internet connection and try again.';

  String get serverErrorStateTitle => 'Server error';

  String get serverErrorStateDescription =>
      'We\'re having some issues on our end. Please try again later.';

  String get timeoutErrorStateTitle => 'Request timeout';

  String get timeoutErrorStateDescription =>
      'The request is taking too long to complete. Please try again.';

  // Success states
  String get successStateTitle => 'Success!';

  String get successStateDescription =>
      'Your action was completed successfully.';

  String get savedSuccessStateTitle => 'Saved successfully!';

  String get savedSuccessStateDescription =>
      'Your changes have been saved successfully.';

  String get createdSuccessStateTitle => 'Created successfully!';

  String get createdSuccessStateDescription =>
      'Your item has been created successfully.';

  String get updatedSuccessStateTitle => 'Updated successfully!';

  String get updatedSuccessStateDescription =>
      'Your item has been updated successfully.';

  String get deletedSuccessStateTitle => 'Deleted successfully!';

  String get deletedSuccessStateDescription =>
      'Your item has been deleted successfully.';

  // Offline states
  String get offlineStateTitle => 'You\'re offline';

  String get offlineStateDescription =>
      'Please check your internet connection and try again.';

  String get offlineContentStateTitle => 'Content unavailable offline';

  String get offlineContentStateDescription =>
      'This content requires an internet connection to load.';

  // Maintenance states
  String get maintenanceStateTitle => 'Under maintenance';

  String get maintenanceStateDescription =>
      'We\'re currently making some improvements. Please check back shortly.';

  String get scheduledMaintenanceStateTitle => 'Scheduled maintenance';

  String get scheduledMaintenanceStateDescription =>
      'We\'ll be undergoing scheduled maintenance. Please check back later.';

  // Unauthorized states
  String get unauthorizedStateTitle => 'Access denied';

  String get unauthorizedStateDescription =>
      'You don\'t have permission to access this content.';

  String get sessionExpiredStateTitle => 'Session expired';

  String get sessionExpiredStateDescription =>
      'Your session has expired. Please log in again to continue.';

  String get loginRequiredStateTitle => 'Login required';

  String get loginRequiredStateDescription =>
      'You need to be logged in to access this feature.';
}

/// Validation related strings
class ValidationStrings {
  const ValidationStrings();

  String get required => 'This field is required';

  String get invalidEmail => 'Please enter a valid email address';

  String get invalidPassword => 'Password must be at least 8 characters';

  String get passwordMismatch => 'Passwords do not match';

  String get invalidName => 'Please enter a valid name';

  String get invalidPhone => 'Please enter a valid phone number';

  String get invalidCode => 'Please enter a valid code';

  String get invalidInput => 'Please enter a valid input';

  String get invalidNumber => 'Please enter a valid number';

  String get invalidDate => 'Please enter a valid date';

  String get invalidUrl => 'Please enter a valid URL';

  String get tooShort => 'Input is too short';

  String get tooLong => 'Input is too long';

  String get minLength => 'Must be at least {length} characters';

  String get maxLength => 'Must be at most {length} characters';

  String get minValue => 'Must be at least {value}';

  String get maxValue => 'Must be at most {value}';

  // Function to replace placeholders in validation messages
  String replacePlaceholders(String message, Map<String, dynamic> values) {
    String result = message;
    values.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }

  // Example usage:
  // validation.replacePlaceholders(validation.minLength, {'length': 8})
}

/// Extension to support localization
extension AppStringsLocalization on AppStrings {
  static final Map<String, Map<String, String>> _localizedValues = {
    'vi': {
      'ok': 'OK',
      'cancel': 'Hủy',
      'save': 'Lưu',
      'edit': 'Sửa',
      'delete': 'Xóa',
      // Add more translations as needed
    },
    'fr': {
      'ok': 'OK',
      'cancel': 'Annuler',
      'save': 'Sauvegarder',
      'edit': 'Modifier',
      'delete': 'Supprimer',
      // Add more translations as needed
    },
    // Add more languages as needed
  };

  static String localize(String key, String languageCode) {
    return _localizedValues[languageCode]?[key] ?? key;
  }

  // Method to register translations
  static void registerTranslations(
    String languageCode,
    Map<String, String> translations,
  ) {
    _localizedValues[languageCode] = translations;
  }
}

// lib/core/constants/app_strings.dart

class AppStrings {
  AppStrings._();

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

  // ignore: constant_identifier_names
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
  static const String loginGeneral =
      'Login'; // Renamed from AppStrings.login to avoid conflict if any
  static const String registerGeneral =
      'Register'; // Renamed from AppStrings.register

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

  static const AuthStrings auth = AuthStrings();
  static const HomeStrings home = HomeStrings();
  static const LearningStrings learning = LearningStrings();
  static const ProfileStrings profile = ProfileStrings();
  static const SettingsStrings settings = SettingsStrings();
  static const ErrorStrings errors = ErrorStrings();
  static const StateWidgetStrings stateWidgets = StateWidgetStrings();
  static const ValidationStrings validation = ValidationStrings();

  static const String placeholderTitle = 'Title placeholder';
  static const String placeholderDescription = 'Description placeholder';
  static const String placeholderMessage = 'Message placeholder';
}

class AuthStrings {
  // Login
  final String loginTitle;
  final String appBarLogin;
  final String loggingIn;
  final String loginSubtitle;
  final String email;
  final String usernameOrEmail;
  final String enterUsernameOrEmail;
  final String password;
  final String enterPassword;
  final String forgotPassword;
  final String logInButton;
  final String dontHaveAccount;
  final String signUpLink;
  final String orLoginWith;
  final String loginWithBiometrics;
  final String biometricReason;
  final String welcomeBackLogin;

  // Register
  final String registerTitle;
  final String appBarRegister;
  final String registeringAccount;
  final String registerSubtitle;
  final String fullName;
  final String firstName;
  final String enterFirstName;
  final String lastName;
  final String enterLastName;
  final String username;
  final String enterUsername;
  final String emailHint;
  final String confirmPassword;
  final String enterConfirmPassword;
  final String alreadyHaveAccount;
  final String registerButton;

  // Forgot password
  final String forgotPasswordTitle;
  final String forgotPasswordSubtitle;
  final String sendResetLinkButton;
  final String sendingResetLink;
  final String resetLinkSentTitle;
  final String resetPasswordSuccessMessage;
  final String checkSpamFolder;
  final String backToLogin;

  // Verification
  final String verificationTitle;
  final String verificationSubtitle;
  final String verificationCode;
  final String verify;
  final String resendCode;
  final String didntReceiveCode;

  // Change password
  final String changePasswordTitle;
  final String currentPassword;
  final String newPassword;
  final String confirmNewPassword;
  final String passwordChanged;

  // Logout
  final String logoutTitle;
  final String logoutConfirmation;
  final String logoutSuccess;

  const AuthStrings({
    this.loginTitle = 'Log In to Your Account',
    this.appBarLogin = 'Log In',
    this.loggingIn = 'Logging In...',
    this.loginSubtitle = 'Enter your credentials to continue',
    this.email = 'Email',
    this.usernameOrEmail = 'Username or Email',
    this.enterUsernameOrEmail = 'Enter your username or email',
    this.password = 'Password',
    this.enterPassword = 'Enter your password',
    this.forgotPassword = 'Forgot password?',
    this.logInButton = 'Log In',
    this.dontHaveAccount = "Don't have an account?",
    this.signUpLink = 'Sign Up',
    this.orLoginWith = 'Or log in with',
    this.loginWithBiometrics = 'Login with Biometrics',
    this.biometricReason = 'Please authenticate to log in',
    this.welcomeBackLogin = 'Welcome Back!',
    this.registerTitle = 'Create Your Account',
    this.appBarRegister = 'Register',
    this.registeringAccount = 'Registering Account...',
    this.registerSubtitle = 'Fill in your details to get started',
    this.fullName = 'Full name',
    this.firstName = 'First Name',
    this.enterFirstName = 'Enter your first name',
    this.lastName = 'Last Name',
    this.enterLastName = 'Enter your last name',
    this.username = 'Username',
    this.enterUsername = 'Enter your username',
    this.emailHint = 'Enter your email address',
    this.confirmPassword = 'Confirm Password',
    this.enterConfirmPassword = 'Enter your password again',
    this.alreadyHaveAccount = 'Already have an account?',
    this.registerButton = 'Register',
    this.forgotPasswordTitle = 'Forgot Password',
    this.forgotPasswordSubtitle = 'Enter your email to reset your password',
    this.sendResetLinkButton = 'Send Reset Link',
    this.sendingResetLink = 'Sending Reset Link...',
    this.resetLinkSentTitle = 'Reset Link Sent!',
    this.resetPasswordSuccessMessage =
        'Check your email for instructions to reset your password',
    this.checkSpamFolder = 'Please check your inbox (and spam folder).',
    this.backToLogin = 'Back to Login',
    this.verificationTitle = 'Verify your email',
    this.verificationSubtitle = "We've sent a verification code to your email",
    this.verificationCode = 'Verification code',
    this.verify = 'Verify',
    this.resendCode = 'Resend code',
    this.didntReceiveCode = "Didn't receive a code?",
    this.changePasswordTitle = 'Change password',
    this.currentPassword = 'Current password',
    this.newPassword = 'New password',
    this.confirmNewPassword = 'Confirm new password',
    this.passwordChanged = 'Password changed successfully',
    this.logoutTitle = 'Log out',
    this.logoutConfirmation = 'Are you sure you want to log out?',
    this.logoutSuccess = 'You have been logged out successfully',
  });
}

class ErrorStrings {
  // Generic Errors
  final String defaultError;
  final String networkError;
  final String timeoutError;
  final String serverError;
  final String unauthorizedError;
  final String notFoundError;
  final String validationError; // General validation error
  final String unknownError;
  final String connectionError;
  final String sessionExpired;
  final String permissionDenied;
  final String fileNotFound;
  final String fileUploadError;
  final String fileDownloadError;
  final String unsupportedFile;
  final String invalidCredentials;
  final String invalidEmail;
  final String invalidPassword; // General invalid password
  final String invalidInput;
  final String invalidVerificationCode;
  final String accountNotFound;
  final String accountAlreadyExists;
  final String accountLocked;
  final String accountNotVerified;
  final String paymentError;
  final String subscriptionError;

  // Auth ViewModel Validation & Action Specific Errors
  final String usernameOrEmailRequired;
  final String passwordRequired;
  final String passwordTooShort;
  final String firstNameRequired;
  final String lastNameRequired;
  final String usernameRequired;
  final String usernameTooShort;
  final String invalidUsernameFormat;
  final String emailRequired;
  final String passwordsDoNotMatch;
  final String confirmPasswordRequired;

  // Screen/State Specific Error Titles for Auth
  final String loginFailed;
  final String registrationFailed;
  final String requestFailedTitle;

  // Biometric Errors
  final String biometricCheckFailed;
  final String biometricAuthFailedByUser;
  final String biometricAuthFailed;
  final String biometricErrorPrefix;

  const ErrorStrings({
    this.defaultError = 'Something went wrong. Please try again.',
    this.networkError = 'Network error. Please check your internet connection.',
    this.timeoutError = 'The request timed out. Please try again.',
    this.serverError = 'Server error. Please try again later.',
    this.unauthorizedError = 'Unauthorized. Please log in again.',
    this.notFoundError = 'Not found. The requested resource does not exist.',
    this.validationError = 'Validation error. Please check your input.',
    this.unknownError = 'Unknown error occurred. Please try again.',
    this.connectionError =
        'Connection error. Please check your internet connection.',
    this.sessionExpired = 'Your session has expired. Please log in again.',
    this.permissionDenied =
        "Permission denied. You don't have access to this resource.",
    this.fileNotFound = 'File not found. The requested file does not exist.',
    this.fileUploadError = 'File upload error. Please try again.',
    this.fileDownloadError = 'File download error. Please try again.',
    this.unsupportedFile = 'Unsupported file type.',
    this.invalidCredentials =
        'Invalid credentials. Please check your email and password.',
    this.invalidEmail = 'Invalid email address.',
    this.invalidPassword = 'Invalid password.',
    this.invalidInput = 'Invalid input. Please check your input.',
    this.invalidVerificationCode = 'Invalid verification code.',
    this.accountNotFound = 'Account not found.',
    this.accountAlreadyExists = 'Account already exists.',
    this.accountLocked = 'Account locked. Please contact support.',
    this.accountNotVerified = 'Account not verified. Please verify your email.',
    this.paymentError = 'Payment error. Please try again.',
    this.subscriptionError = 'Subscription error. Please try again.',
    this.usernameOrEmailRequired = 'Username or email is required.',
    this.passwordRequired = 'Password is required.',
    this.passwordTooShort = 'Password must be at least 8 characters.',
    this.firstNameRequired = 'First name is required.',
    this.lastNameRequired = 'Last name is required.',
    this.usernameRequired = 'Username is required.',
    this.usernameTooShort = 'Username must be at least 3 characters.',
    this.invalidUsernameFormat =
        'Username can only contain letters, numbers, dots, underscores, and hyphens.',
    this.emailRequired = 'Email is required.',
    this.passwordsDoNotMatch = 'Passwords do not match.',
    this.confirmPasswordRequired = 'Please confirm your password.',
    this.loginFailed = 'Login Failed',
    this.registrationFailed = 'Registration Failed',
    this.requestFailedTitle = 'Request Failed',
    this.biometricCheckFailed = 'Biometric availability check failed.',
    this.biometricAuthFailedByUser =
        'Biometric authentication cancelled or failed by user.',
    this.biometricAuthFailed = 'Biometric authentication failed.',
    this.biometricErrorPrefix = 'Biometric Error:',
  });
}

// --- Các lớp HomeStrings, LearningStrings, ProfileStrings, SettingsStrings, StateWidgetStrings, ValidationStrings và extension AppStringsLocalization giữ nguyên như file gốc của bạn ---

class HomeStrings {
  final String welcomeBack;
  final String todaySessions;
  final String upcomingLessons;
  final String recentProgress;
  final String quickActions;
  final String continueStudying;
  final String exploreCategories;
  final String recommendedForYou;
  final String dailyGoal;
  final String streakDays;
  final String newContent;
  final String viewAll;

  const HomeStrings({
    this.welcomeBack = 'Welcome back',
    this.todaySessions = "Today's sessions",
    this.upcomingLessons = 'Upcoming lessons',
    this.recentProgress = 'Recent progress',
    this.quickActions = 'Quick actions',
    this.continueStudying = 'Continue studying',
    this.exploreCategories = 'Explore categories',
    this.recommendedForYou = 'Recommended for you',
    this.dailyGoal = 'Daily goal',
    this.streakDays = 'Streak days',
    this.newContent = 'New content',
    this.viewAll = 'View all',
  });
}

class LearningStrings {
  final String courses;
  final String lessons;
  final String modules;
  final String topics;
  final String flashcards;
  final String quizzes;
  final String practice;
  final String startLesson;
  final String continueLesson;
  final String completeLesson;
  final String lessonCompleted;
  final String courseCompleted;
  final String yourProgress;
  final String progressOverview;
  final String mastered;
  final String learning;
  final String needsReview;
  final String notStarted;
  final String completed;
  final String inProgress;
  final String front;
  final String flashcardBackSide;
  final String flip;
  final String know;
  final String dontKnow;
  final String showAnswer;
  final String questionOf;
  final String checkAnswer;
  final String correctAnswer;
  final String wrongAnswer;
  final String explanation;
  final String quizResults;
  final String quizCompleted;
  final String yourScore;
  final String review;
  final String timeLeft;
  final String studyReminder;
  final String remindMe;
  final String reminderSet;

  const LearningStrings({
    this.courses = 'Courses',
    this.lessons = 'Lessons',
    this.modules = 'Modules',
    this.topics = 'Topics',
    this.flashcards = 'Flashcards',
    this.quizzes = 'Quizzes',
    this.practice = 'Practice',
    this.startLesson = 'Start lesson',
    this.continueLesson = 'Continue lesson',
    this.completeLesson = 'Complete lesson',
    this.lessonCompleted = 'Lesson completed',
    this.courseCompleted = 'Course completed',
    this.yourProgress = 'Your progress',
    this.progressOverview = 'Progress overview',
    this.mastered = 'Mastered',
    this.learning = 'Learning',
    this.needsReview = 'Needs review',
    this.notStarted = 'Not started',
    this.completed = 'Completed',
    this.inProgress = 'In progress',
    this.front = 'Front',
    this.flashcardBackSide = 'Back',
    this.flip = 'Flip',
    this.know = 'I know this',
    this.dontKnow = "Don't know",
    this.showAnswer = 'Show answer',
    this.questionOf = 'Question {current} of {total}',
    this.checkAnswer = 'Check answer',
    this.correctAnswer = 'Correct answer',
    this.wrongAnswer = 'Wrong answer',
    this.explanation = 'Explanation',
    this.quizResults = 'Quiz results',
    this.quizCompleted = 'Quiz completed',
    this.yourScore = 'Your score',
    this.review = 'Review',
    this.timeLeft = 'Time left',
    this.studyReminder = 'Study reminder',
    this.remindMe = 'Remind me',
    this.reminderSet = 'Reminder set',
  });
}

class ProfileStrings {
  final String myProfile;
  final String editProfile;
  final String achievements;
  final String statistics;
  final String studyHistory;
  final String memberSince;
  final String totalStudyTime;
  final String averageDailyTime;
  final String longestStreak;
  final String currentStreak;
  final String completedCourses;
  final String completedLessons;
  final String masteredConcepts;

  const ProfileStrings({
    this.myProfile = 'My profile',
    this.editProfile = 'Edit profile',
    this.achievements = 'Achievements',
    this.statistics = 'Statistics',
    this.studyHistory = 'Study history',
    this.memberSince = 'Member since',
    this.totalStudyTime = 'Total study time',
    this.averageDailyTime = 'Average daily time',
    this.longestStreak = 'Longest streak',
    this.currentStreak = 'Current streak',
    this.completedCourses = 'Completed courses',
    this.completedLessons = 'Completed lessons',
    this.masteredConcepts = 'Mastered concepts',
  });
}

class SettingsStrings {
  final String appSettings;
  final String accountSettings;
  final String notificationSettings;
  final String privacySettings;
  final String language;
  final String theme;
  final String darkMode;
  final String lightMode;
  final String systemDefault;
  final String pushNotifications;
  final String emailNotifications;
  final String studyReminders;
  final String dataUsage;
  final String downloadOverWifi;
  final String autoPlayVideos;
  final String privacyPolicy;
  final String termsOfService;
  final String deleteAccount;
  final String deleteAccountConfirmation;
  final String helpAndSupport;
  final String faq;
  final String contactUs;
  final String aboutApp;
  final String version;

  const SettingsStrings({
    this.appSettings = 'App settings',
    this.accountSettings = 'Account settings',
    this.notificationSettings = 'Notification settings',
    this.privacySettings = 'Privacy settings',
    this.language = 'Language',
    this.theme = 'Theme',
    this.darkMode = 'Dark mode',
    this.lightMode = 'Light mode',
    this.systemDefault = 'System default',
    this.pushNotifications = 'Push notifications',
    this.emailNotifications = 'Email notifications',
    this.studyReminders = 'Study reminders',
    this.dataUsage = 'Data usage',
    this.downloadOverWifi = 'Download over Wi-Fi only',
    this.autoPlayVideos = 'Auto-play videos',
    this.privacyPolicy = 'Privacy policy',
    this.termsOfService = 'Terms of service',
    this.deleteAccount = 'Delete account',
    this.deleteAccountConfirmation =
        'Are you sure you want to delete your account? This action cannot be undone.',
    this.helpAndSupport = 'Help and support',
    this.faq = 'FAQ',
    this.contactUs = 'Contact us',
    this.aboutApp = 'About app',
    this.version = 'Version',
  });
}

class StateWidgetStrings {
  final String emptyStateTitle;
  final String emptyStateDescription;
  final String noResultsFound;
  final String noResultsDescription;
  final String noDataAvailable;
  final String noDataDescription;
  final String noContentAvailable;
  final String noContentDescription;
  final String emptyList;
  final String emptyListDescription;
  final String loadingStateTitle;
  final String loadingStateDescription;
  final String processingStateTitle;
  final String processingStateDescription;
  final String synchronizingStateTitle;
  final String synchronizingStateDescription;
  final String errorStateTitle;
  final String errorStateDescription;
  final String networkErrorStateTitle;
  final String networkErrorStateDescription;
  final String serverErrorStateTitle;
  final String serverErrorStateDescription;
  final String timeoutErrorStateTitle;
  final String timeoutErrorStateDescription;
  final String successStateTitle;
  final String successStateDescription;
  final String savedSuccessStateTitle;
  final String savedSuccessStateDescription;
  final String createdSuccessStateTitle;
  final String createdSuccessStateDescription;
  final String updatedSuccessStateTitle;
  final String updatedSuccessStateDescription;
  final String deletedSuccessStateTitle;
  final String deletedSuccessStateDescription;
  final String offlineStateTitle;
  final String offlineStateDescription;
  final String offlineContentStateTitle;
  final String offlineContentStateDescription;
  final String maintenanceStateTitle;
  final String maintenanceStateDescription;
  final String scheduledMaintenanceStateTitle;
  final String scheduledMaintenanceStateDescription;
  final String unauthorizedStateTitle;
  final String unauthorizedStateDescription;
  final String sessionExpiredStateTitle;
  final String sessionExpiredStateDescription;
  final String loginRequiredStateTitle;
  final String loginRequiredStateDescription;

  const StateWidgetStrings({
    this.emptyStateTitle = 'Nothing here',
    this.emptyStateDescription = "There's nothing here yet.",
    this.noResultsFound = 'No results found',
    this.noResultsDescription =
        "We couldn't find any matches for your search or filters.",
    this.noDataAvailable = 'No data available',
    this.noDataDescription = "There's no data available yet.",
    this.noContentAvailable = 'No content available',
    this.noContentDescription = "There's no content available yet.",
    this.emptyList = 'Empty list',
    this.emptyListDescription = 'This list is empty.',
    this.loadingStateTitle = 'Loading...',
    this.loadingStateDescription = 'Please wait while we load your content.',
    this.processingStateTitle = 'Processing...',
    this.processingStateDescription =
        'Please wait while we process your request.',
    this.synchronizingStateTitle = 'Synchronizing...',
    this.synchronizingStateDescription =
        'Please wait while we synchronize your data.',
    this.errorStateTitle = 'Oops! Something went wrong',
    this.errorStateDescription = 'An error occurred. Please try again.',
    this.networkErrorStateTitle = 'Network error',
    this.networkErrorStateDescription =
        'Please check your internet connection and try again.',
    this.serverErrorStateTitle = 'Server error',
    this.serverErrorStateDescription =
        "We're having some issues on our end. Please try again later.",
    this.timeoutErrorStateTitle = 'Request timeout',
    this.timeoutErrorStateDescription =
        'The request is taking too long to complete. Please try again.',
    this.successStateTitle = 'Success!',
    this.successStateDescription = 'Your action was completed successfully.',
    this.savedSuccessStateTitle = 'Saved successfully!',
    this.savedSuccessStateDescription =
        'Your changes have been saved successfully.',
    this.createdSuccessStateTitle = 'Created successfully!',
    this.createdSuccessStateDescription =
        'Your item has been created successfully.',
    this.updatedSuccessStateTitle = 'Updated successfully!',
    this.updatedSuccessStateDescription =
        'Your item has been updated successfully.',
    this.deletedSuccessStateTitle = 'Deleted successfully!',
    this.deletedSuccessStateDescription =
        'Your item has been deleted successfully.',
    this.offlineStateTitle = "You're offline",
    this.offlineStateDescription =
        'Please check your internet connection and try again.',
    this.offlineContentStateTitle = 'Content unavailable offline',
    this.offlineContentStateDescription =
        'This content requires an internet connection to load.',
    this.maintenanceStateTitle = 'Under maintenance',
    this.maintenanceStateDescription =
        "We're currently making some improvements. Please check back shortly.",
    this.scheduledMaintenanceStateTitle = 'Scheduled maintenance',
    this.scheduledMaintenanceStateDescription =
        "We'll be undergoing scheduled maintenance. Please check back later.",
    this.unauthorizedStateTitle = 'Access denied',
    this.unauthorizedStateDescription =
        "You don't have permission to access this content.",
    this.sessionExpiredStateTitle = 'Session expired',
    this.sessionExpiredStateDescription =
        'Your session has expired. Please log in again to continue.',
    this.loginRequiredStateTitle = 'Login required',
    this.loginRequiredStateDescription =
        'You need to be logged in to access this feature.',
  });
}

class ValidationStrings {
  final String required;
  final String invalidEmail;
  final String invalidPassword;
  final String passwordMismatch;
  final String invalidName;
  final String invalidPhone;
  final String invalidCode;
  final String invalidInput;
  final String invalidNumber;
  final String invalidDate;
  final String invalidUrl;
  final String tooShort;
  final String tooLong;
  final String minLength;
  final String maxLength;
  final String minValue;
  final String maxValue;

  const ValidationStrings({
    this.required = 'This field is required',
    this.invalidEmail = 'Please enter a valid email address',
    this.invalidPassword = 'Password must be at least 8 characters',
    this.passwordMismatch = 'Passwords do not match',
    this.invalidName = 'Please enter a valid name',
    this.invalidPhone = 'Please enter a valid phone number',
    this.invalidCode = 'Please enter a valid code',
    this.invalidInput = 'Please enter a valid input',
    this.invalidNumber = 'Please enter a valid number',
    this.invalidDate = 'Please enter a valid date',
    this.invalidUrl = 'Please enter a valid URL',
    this.tooShort = 'Input is too short',
    this.tooLong = 'Input is too long',
    this.minLength = 'Must be at least {length} characters',
    this.maxLength = 'Must be at most {length} characters',
    this.minValue = 'Must be at least {value}',
    this.maxValue = 'Must be at most {value}',
  });

  String replacePlaceholders(String message, Map<String, dynamic> values) {
    String result = message;
    values.forEach((key, value) {
      result = result.replaceAll('{$key}', value.toString());
    });
    return result;
  }
}

extension AppStringsLocalization on AppStrings {
  static final Map<String, Map<String, String>> _localizedValues = {
    'vi': {
      'ok': 'OK',
      'cancel': 'Hủy',
      'save': 'Lưu',
      'edit': 'Sửa',
      'delete': 'Xóa',
    },
    'fr': {
      'ok': 'OK',
      'cancel': 'Annuler',
      'save': 'Sauvegarder',
      'edit': 'Modifier',
      'delete': 'Supprimer',
    },
  };

  static String localize(String key, String languageCode) {
    return _localizedValues[languageCode]?[key] ?? key;
  }

  static void registerTranslations(
    String languageCode,
    Map<String, String> translations,
  ) {
    if (_localizedValues.containsKey(languageCode)) {
      _localizedValues[languageCode]!.addAll(translations);
    } else {
      _localizedValues[languageCode] = translations;
    }
  }
}

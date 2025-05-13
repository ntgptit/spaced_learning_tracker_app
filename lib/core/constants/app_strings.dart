/// App string constants
/// All strings are defined here to ensure consistency across the app
class AppStrings {
  // App
  static const String appName = 'SLT App';

  // Common
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String close = 'Close';
  static const String submit = 'Submit';
  static const String retry = 'Retry';
  static const String next = 'Next';
  static const String previous = 'Previous';
  static const String back = 'Back';
  static const String done = 'Done';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String applyFilter = 'Apply Filter';
  static const String resetFilter = 'Reset Filter';
  static const String loading = 'Loading...';
  static const String success = 'Success';
  static const String error = 'Error';
  static const String warning = 'Warning';
  static const String info = 'Information';

  // Errors
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNoInternet =
      'No internet connection. Please check your network settings.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorServer = 'Server error. Please try again later.';
  static const String errorUnauthorized =
      'You are not authorized to access this feature.';
  static const String errorBadRequest = 'Invalid request. Please try again.';
  static const String errorNotFound = 'Resource not found.';
  static const String errorInvalidInput =
      'Please check your input and try again.';
  static const String errorEmptyData = 'No data available.';
  static const String errorSessionExpired =
      'Your session has expired. Please login again.';

  // Auth
  static const String login = 'Login';
  static const String logout = 'Logout';
  static const String register = 'Register';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  static const String changePassword = 'Change Password';
  static const String username = 'Username';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String newPassword = 'New Password';
  static const String oldPassword = 'Current Password';
  static const String rememberMe = 'Remember Me';
  static const String loginWith = 'Or Login With';
  static const String dontHaveAccount = 'Don\'t have an account?';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String createAccount = 'Create Account';
  static const String verificationCode = 'Verification Code';
  static const String sendCode = 'Send Code';
  static const String resendCode = 'Resend Code';
  static const String verifyCode = 'Verify Code';
  static const String otpSent = 'OTP has been sent to your email.';
  static const String otpVerified = 'OTP verified successfully.';
  static const String otpExpired = 'OTP has expired. Please request a new one.';
  static const String otpInvalid = 'Invalid OTP. Please try again.';

  // Validation
  static const String validationRequired = 'This field is required.';
  static const String validationEmail = 'Please enter a valid email address.';
  static const String validationPassword =
      'Password must be at least 8 characters long and include a mix of letters, numbers, and special characters.';
  static const String validationPasswordMatch = 'Passwords do not match.';
  static const String validationMinLength =
      'This field must be at least {length} characters long.';
  static const String validationMaxLength =
      'This field cannot exceed {length} characters.';
  static const String validationNumbersOnly =
      'This field only accepts numbers.';
  static const String validationLettersOnly =
      'This field only accepts letters.';
  static const String validationPhone = 'Please enter a valid phone number.';
  static const String validationUrl = 'Please enter a valid URL.';
  static const String validationDate = 'Please enter a valid date.';
  static const String validationTime = 'Please enter a valid time.';
  static const String validationDateTime =
      'Please enter a valid date and time.';

  // Empty States
  static const String emptyStateTitle = 'No data found';
  static const String emptyStateDescription =
      'There is no data available at the moment.';
  static const String emptySearchTitle = 'No results found';
  static const String emptySearchDescription =
      'Try adjusting your search or filter to find what you\'re looking for.';
  static const String emptyNotificationsTitle = 'No notifications';
  static const String emptyNotificationsDescription =
      'You don\'t have any notifications at the moment.';
  static const String emptyFavoritesTitle = 'No favorites yet';
  static const String emptyFavoritesDescription =
      'Items added to your favorites will appear here.';
  static const String emptyCartTitle = 'Your cart is empty';
  static const String emptyCartDescription =
      'Add items to your cart to proceed with checkout.';

  // Error States
  static const String errorStateTitle = 'Oops! Something went wrong';
  static const String errorStateDescription =
      'We\'re sorry, but there was an error processing your request.';
  static const String errorStateButtonText = 'Try Again';
  static const String errorStateNotFoundTitle = 'Page not found';
  static const String errorStateNotFoundDescription =
      'The page you\'re looking for doesn\'t exist or has been moved.';
  static const String errorStateNetworkTitle = 'No internet connection';
  static const String errorStateNetworkDescription =
      'Please check your internet connection and try again.';
  static const String errorStateNetworkButtonText = 'Retry';
  static const String errorStateServerTitle = 'Server error';
  static const String errorStateServerDescription =
      'Our servers are experiencing issues. Please try again later.';
  static const String errorStateUnauthorizedTitle = 'Access denied';
  static const String errorStateUnauthorizedDescription =
      'You don\'t have permission to access this feature.';
  static const String errorStateSessionExpiredTitle = 'Session expired';
  static const String errorStateSessionExpiredDescription =
      'Your session has expired. Please log in again.';
  static const String errorStateSessionExpiredButtonText = 'Login';

  // Loading States
  static const String loadingStateTitle = 'Loading...';
  static const String loadingStateDescription =
      'Please wait while we load your content.';
  static const String loadingStateProcessing = 'Processing...';
  static const String loadingStateUploading = 'Uploading...';
  static const String loadingStateDownloading = 'Downloading...';
  static const String loadingStateSaving = 'Saving...';
  static const String loadingStateUpdating = 'Updating...';

  // Success States
  static const String successStateTitle = 'Success!';
  static const String successStateDescription =
      'Your action was completed successfully.';
  static const String successStateSaved = 'Saved successfully!';
  static const String successStateUpdated = 'Updated successfully!';
  static const String successStateDeleted = 'Deleted successfully!';
  static const String successStateCreated = 'Created successfully!';
  static const String successStateUploaded = 'Uploaded successfully!';
  static const String successStateDownloaded = 'Downloaded successfully!';

  // Unauthorized States
  static const String unauthorizedStateTitle = 'Access Denied';
  static const String unauthorizedStateDescription =
      'You don\'t have permission to access this feature. Please contact your administrator or login with a different account.';
  static const String unauthorizedStateButtonText = 'Back to Home';

  // Maintenance States
  static const String maintenanceStateTitle = 'Under Maintenance';
  static const String maintenanceStateDescription =
      'We\'re currently performing maintenance on our servers. Please try again later.';

  // Offline States
  static const String offlineStateTitle = 'You\'re Offline';
  static const String offlineStateDescription =
      'Please check your internet connection and try again.';
  static const String offlineStateButtonText = 'Refresh';

  // Bottom Navigation
  static const String home = 'Home';
  static const String explore = 'Explore';
  static const String notifications = 'Notifications';
  static const String profile = 'Profile';
  static const String settings = 'Settings';

  // Settings
  static const String generalSettings = 'General Settings';
  static const String accountSettings = 'Account Settings';
  static const String notificationSettings = 'Notification Settings';
  static const String privacySettings = 'Privacy Settings';
  static const String securitySettings = 'Security Settings';
  static const String themeSettings = 'Theme Settings';
  static const String languageSettings = 'Language Settings';
  static const String darkMode = 'Dark Mode';
  static const String lightMode = 'Light Mode';
  static const String systemMode = 'System Mode';
  static const String language = 'Language';
  static const String about = 'About';
  static const String help = 'Help & Support';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String deleteAccount = 'Delete Account';

  // Dialogs
  static const String confirmDialogTitle = 'Confirm Action';
  static const String confirmDialogDescription =
      'Are you sure you want to proceed with this action?';
  static const String confirmDeleteDialogTitle = 'Confirm Delete';
  static const String confirmDeleteDialogDescription =
      'Are you sure you want to delete this item? This action cannot be undone.';
  static const String confirmLogoutDialogTitle = 'Confirm Logout';
  static const String confirmLogoutDialogDescription =
      'Are you sure you want to logout?';
  static const String confirmDeleteAccountDialogTitle = 'Delete Account';
  static const String confirmDeleteAccountDialogDescription =
      'Are you sure you want to delete your account? This action cannot be undone and will permanently delete all your data.';
  static const String confirmCancelDialogTitle = 'Discard Changes?';
  static const String confirmCancelDialogDescription =
      'Are you sure you want to discard your changes?';
  static const String confirmSubmitDialogTitle = 'Submit Form?';
  static const String confirmSubmitDialogDescription =
      'Are you sure you want to submit this form?';

  // Learning specific
  static const String courses = 'Courses';
  static const String lessons = 'Lessons';
  static const String exercises = 'Exercises';
  static const String quizzes = 'Quizzes';
  static const String exams = 'Exams';
  static const String assignments = 'Assignments';
  static const String progress = 'Progress';
  static const String score = 'Score';
  static const String grade = 'Grade';
  static const String completion = 'Completion';
  static const String startDate = 'Start Date';
  static const String endDate = 'End Date';
  static const String dueDate = 'Due Date';
  static const String duration = 'Duration';
  static const String instructor = 'Instructor';
  static const String students = 'Students';
  static const String certificate = 'Certificate';
  static const String category = 'Category';
  static const String level = 'Level';
  static const String beginner = 'Beginner';
  static const String intermediate = 'Intermediate';
  static const String advanced = 'Advanced';
  static const String completed = 'Completed';
  static const String inProgress = 'In Progress';
  static const String notStarted = 'Not Started';
  static const String passed = 'Passed';
  static const String failed = 'Failed';
  static const String startCourse = 'Start Course';
  static const String continueCourse = 'Continue Course';
  static const String startLesson = 'Start Lesson';
  static const String continueLesson = 'Continue Lesson';
  static const String startQuiz = 'Start Quiz';
  static const String submitQuiz = 'Submit Quiz';
  static const String startExam = 'Start Exam';
  static const String submitExam = 'Submit Exam';
  static const String reviewAnswers = 'Review Answers';
  static const String courseDetails = 'Course Details';
  static const String lessonDetails = 'Lesson Details';
  static const String examDetails = 'Exam Details';
  static const String quizDetails = 'Quiz Details';
  static const String assignmentDetails = 'Assignment Details';

  // Dialog Score Input
  static const String enterScore = 'Enter Score';
  static const String scoreOutOf = 'Score: {score} out of {total}';
  static const String comments = 'Comments';
  static const String addFeedback = 'Add Feedback';
  static const String saveScore = 'Save Score';
  static const String excellent = 'Excellent';
  static const String good = 'Good';
  static const String fair = 'Fair';
  static const String poor = 'Poor';
  static const String needsImprovement = 'Needs Improvement';
  static const String out = 'out of';

  // Calendar
  static const String calendar = 'Calendar';
  static const String schedule = 'Schedule';
  static const String event = 'Event';
  static const String eventDetails = 'Event Details';
  static const String addEvent = 'Add Event';
  static const String editEvent = 'Edit Event';
  static const String eventTitle = 'Event Title';
  static const String eventDescription = 'Event Description';
  static const String eventLocation = 'Event Location';
  static const String eventDate = 'Event Date';
  static const String eventTime = 'Event Time';
  static const String allDay = 'All Day';
  static const String reminder = 'Reminder';
  static const String recurringEvent = 'Recurring Event';
  static const String daily = 'Daily';
  static const String weekly = 'Weekly';
  static const String monthly = 'Monthly';
  static const String yearly = 'Yearly';

  // Form Section
  static const String personalInfo = 'Personal Information';
  static const String contactInfo = 'Contact Information';
  static const String address = 'Address';
  static const String paymentInfo = 'Payment Information';
  static const String additionalInfo = 'Additional Information';
  static const String preferences = 'Preferences';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';
  static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';
  static const String mobileNumber = 'Mobile Number';
  static const String dateOfBirth = 'Date of Birth';
  static const String gender = 'Gender';
  static const String male = 'Male';
  static const String female = 'Female';
  static const String other = 'Other';
  static const String preferNotToSay = 'Prefer not to say';
  static const String country = 'Country';
  static const String city = 'City';
  static const String state = 'State/Province';
  static const String zipCode = 'ZIP/Postal Code';
  static const String streetAddress = 'Street Address';

  // Filter Bar
  static const String sortBy = 'Sort By';
  static const String filterBy = 'Filter By';
  static const String ascending = 'Ascending';
  static const String descending = 'Descending';
  static const String dateRange = 'Date Range';
  static const String priceRange = 'Price Range';
  static const String status = 'Status';
  static const String type = 'Type';
  static const String popularity = 'Popularity';
  static const String rating = 'Rating';
  static const String newest = 'Newest';
  static const String oldest = 'Oldest';
  static const String priceHighToLow = 'Price: High to Low';
  static const String priceLowToHigh = 'Price: Low to High';
  static const String all = 'All';
  static const String today = 'Today';
  static const String yesterday = 'Yesterday';
  static const String thisWeek = 'This Week';
  static const String lastWeek = 'Last Week';
  static const String thisMonth = 'This Month';
  static const String lastMonth = 'Last Month';
  static const String thisYear = 'This Year';
  static const String lastYear = 'Last Year';
  static const String custom = 'Custom';
  static const String from = 'From';
  static const String to = 'To';

  // App Footer
  static const String version = 'Version';
  static const String copyright = '© 2025 SLT App. All rights reserved.';
  static const String poweredBy = 'Powered by Flutter';
}

// lib/core/constants/strings/dialog_strings.dart
/// Dialog, alert, and confirmation related strings

abstract class DialogStrings {
  // Dialog Actions
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String accept = 'Accept';
  static const String decline = 'Decline';
  static const String agree = 'Agree';
  static const String disagree = 'Disagree';
  static const String allow = 'Allow';
  static const String deny = 'Deny';
  static const String enable = 'Enable';
  static const String disable = 'Disable';
  static const String continue_action = 'Continue';
  static const String stop = 'Stop';
  static const String proceed = 'Proceed';
  static const String abort = 'Abort';
  static const String retry = 'Retry';
  static const String skip = 'Skip';
  static const String close = 'Close';
  static const String dismiss = 'Dismiss';
  static const String done = 'Done';
  static const String finish = 'Finish';
  static const String save = 'Save';
  static const String discard = 'Discard';
  static const String apply = 'Apply';
  static const String reset = 'Reset';
  static const String restore = 'Restore';
  static const String delete = 'Delete';
  static const String remove = 'Remove';
  static const String edit = 'Edit';
  static const String update = 'Update';
  static const String submit = 'Submit';
  static const String send = 'Send';
  static const String share = 'Share';
  static const String copy = 'Copy';
  static const String download = 'Download';
  static const String upload = 'Upload';
  static const String import = 'Import';
  static const String export = 'Export';

  // Common Dialog Titles
  static const String confirmation = 'Confirmation';
  static const String alert = 'Alert';
  static const String warning = 'Warning';
  static const String error = 'Error';
  static const String information = 'Information';
  static const String notice = 'Notice';
  static const String notification = 'Notification';
  static const String announcement = 'Announcement';
  static const String message = 'Message';
  static const String question = 'Question';
  static const String prompt = 'Prompt';
  static const String input = 'Input';
  static const String selection = 'Selection';
  static const String choice = 'Choice';
  static const String option = 'Option';
  static const String preference = 'Preference';
  static const String setting = 'Setting';
  static const String configuration = 'Configuration';
  static const String permission = 'Permission';
  static const String access = 'Access';
  static const String authorization = 'Authorization';
  static const String authentication = 'Authentication';
  static const String verification = 'Verification';
  static const String validation = 'Validation';
  static const String success = 'Success';
  static const String failure = 'Failure';
  static const String complete = 'Complete';
  static const String incomplete = 'Incomplete';
  static const String progress = 'Progress';
  static const String status = 'Status';
  static const String update_title = 'Update';
  static const String upgrade = 'Upgrade';
  static const String maintenance = 'Maintenance';
  static const String system = 'System';

  // Confirmation Messages
  static const String areYouSure = 'Are you sure?';
  static const String confirmAction = 'Please confirm this action';
  static const String confirmDeletion =
      'Are you sure you want to delete this item?';
  static const String confirmRemoval =
      'Are you sure you want to remove this item?';
  static const String confirmExit = 'Are you sure you want to exit?';
  static const String confirmClose = 'Are you sure you want to close?';
  static const String confirmCancel = 'Are you sure you want to cancel?';
  static const String confirmDiscard =
      'Are you sure you want to discard changes?';
  static const String confirmReset =
      'Are you sure you want to reset to default settings?';
  static const String confirmRestore =
      'Are you sure you want to restore from backup?';
  static const String confirmOverwrite =
      'Are you sure you want to overwrite existing data?';
  static const String confirmReplace =
      'Are you sure you want to replace this item?';
  static const String confirmLogout = 'Are you sure you want to logout?';
  static const String confirmDeleteAccount =
      'Are you sure you want to delete your account?';
  static const String confirmSave = 'Do you want to save your changes?';
  static const String confirmUpdate = 'Do you want to update this item?';
  static const String confirmSubmit = 'Do you want to submit this form?';
  static const String confirmSend = 'Do you want to send this message?';
  static const String confirmShare = 'Do you want to share this content?';
  static const String confirmPublish = 'Do you want to publish this content?';
  static const String confirmUnpublish =
      'Do you want to unpublish this content?';
  static const String confirmArchive = 'Do you want to archive this item?';
  static const String confirmUnarchive = 'Do you want to unarchive this item?';
  static const String confirmMarkAsRead = 'Do you want to mark this as read?';
  static const String confirmMarkAsUnread =
      'Do you want to mark this as unread?';
  static const String confirmClearHistory =
      'Are you sure you want to clear your history?';
  static const String confirmClearCache =
      'Are you sure you want to clear the cache?';
  static const String confirmClearData =
      'Are you sure you want to clear all data?';

  // Warning Messages
  static const String actionCannotBeUndone = 'This action cannot be undone';
  static const String dataWillBeLost = 'All data will be lost';
  static const String changesWillBeLost = 'All unsaved changes will be lost';
  static const String settingsWillBeReset =
      'All settings will be reset to default';
  static const String accountWillBeDeleted =
      'Your account will be permanently deleted';
  static const String connectionWillBeLost =
      'You will lose your current connection';
  static const String progressWillBeLost = 'Your current progress will be lost';
  static const String thisActionIsPermanent = 'This action is permanent';
  static const String cannotBeRecovered = 'This cannot be recovered';
  static const String noBackupAvailable = 'No backup is available';
  static const String requiresInternetConnection =
      'This action requires an internet connection';
  static const String mayTakeAFewMinutes = 'This may take a few minutes';
  static const String deviceMayRestart = 'Your device may restart';
  static const String appWillClose = 'The app will close';
  static const String loginRequired = 'You need to login first';
  static const String permissionRequired = 'Permission is required';
  static const String storageSpaceRequired =
      'Additional storage space is required';

  // Error Messages in Dialogs
  static const String operationFailed = 'The operation failed';
  static const String connectionFailed = 'Connection failed';
  static const String saveFailed = 'Failed to save';
  static const String loadFailed = 'Failed to load';
  static const String deleteFailed = 'Failed to delete';
  static const String updateFailed = 'Failed to update';
  static const String uploadFailed = 'Failed to upload';
  static const String downloadFailed = 'Failed to download';
  static const String syncFailed = 'Failed to sync';
  static const String loginFailed = 'Login failed';
  static const String registrationFailed = 'Registration failed';
  static const String validationFailed = 'Validation failed';
  static const String authenticationFailed = 'Authentication failed';
  static const String authorizationFailed = 'Authorization failed';
  static const String permissionDenied = 'Permission denied';
  static const String accessDenied = 'Access denied';
  static const String invalidInput = 'Invalid input';
  static const String invalidCredentials = 'Invalid credentials';
  static const String sessionExpired = 'Your session has expired';
  static const String accountLocked = 'Your account is locked';
  static const String accountSuspended = 'Your account is suspended';
  static const String serviceUnavailable = 'Service is temporarily unavailable';
  static const String maintenanceMode = 'System is under maintenance';
  static const String quotaExceeded = 'Quota exceeded';
  static const String rateLimitExceeded = 'Rate limit exceeded';
  static const String insufficientStorage = 'Insufficient storage space';
  static const String networkError = 'Network error occurred';
  static const String timeoutError = 'Request timed out';
  static const String unknownError = 'An unknown error occurred';

  // Success Messages in Dialogs
  static const String operationSuccessful = 'Operation completed successfully';
  static const String saveSuccessful = 'Saved successfully';
  static const String updateSuccessful = 'Updated successfully';
  static const String deleteSuccessful = 'Deleted successfully';
  static const String uploadSuccessful = 'Uploaded successfully';
  static const String downloadSuccessful = 'Downloaded successfully';
  static const String syncSuccessful = 'Synced successfully';
  static const String loginSuccessful = 'Login successful';
  static const String registrationSuccessful = 'Registration successful';
  static const String verificationSuccessful = 'Verification successful';
  static const String passwordChanged = 'Password changed successfully';
  static const String settingsSaved = 'Settings saved successfully';
  static const String preferencesUpdated = 'Preferences updated successfully';
  static const String profileUpdated = 'Profile updated successfully';
  static const String accountCreated = 'Account created successfully';
  static const String accountDeleted = 'Account deleted successfully';
  static const String messagesSent = 'Message sent successfully';
  static const String contentShared = 'Content shared successfully';
  static const String contentPublished = 'Content published successfully';
  static const String backupCreated = 'Backup created successfully';
  static const String backupRestored = 'Backup restored successfully';
  static const String dataExported = 'Data exported successfully';
  static const String dataImported = 'Data imported successfully';
  static const String cacheCleared = 'Cache cleared successfully';
  static const String historyCleared = 'History cleared successfully';

  // Loading Messages in Dialogs
  static const String loading = 'Loading...';
  static const String processing = 'Processing...';
  static const String saving = 'Saving...';
  static const String updating = 'Updating...';
  static const String deleting = 'Deleting...';
  static const String uploading = 'Uploading...';
  static const String downloading = 'Downloading...';
  static const String syncing = 'Syncing...';
  static const String connecting = 'Connecting...';
  static const String authenticating = 'Authenticating...';
  static const String verifying = 'Verifying...';
  static const String validating = 'Validating...';
  static const String preparing = 'Preparing...';
  static const String initializing = 'Initializing...';
  static const String configuring = 'Configuring...';
  static const String installing = 'Installing...';
  static const String uninstalling = 'Uninstalling...';
  static const String searching = 'Searching...';
  static const String filtering = 'Filtering...';
  static const String sorting = 'Sorting...';
  static const String analyzing = 'Analyzing...';
  static const String calculating = 'Calculating...';
  static const String generating = 'Generating...';
  static const String rendering = 'Rendering...';
  static const String compressing = 'Compressing...';
  static const String decompressing = 'Decompressing...';
  static const String encrypting = 'Encrypting...';
  static const String decrypting = 'Decrypting...';

  // Input Dialog Labels
  static const String enterValue = 'Enter value';
  static const String enterText = 'Enter text';
  static const String enterNumber = 'Enter number';
  static const String enterEmail = 'Enter email';
  static const String enterPassword = 'Enter password';
  static const String enterUsername = 'Enter username';
  static const String enterName = 'Enter name';
  static const String enterTitle = 'Enter title';
  static const String enterDescription = 'Enter description';
  static const String enterMessage = 'Enter message';
  static const String enterComment = 'Enter comment';
  static const String enterNote = 'Enter note';
  static const String enterTag = 'Enter tag';
  static const String enterUrl = 'Enter URL';
  static const String enterDate = 'Enter date';
  static const String enterTime = 'Enter time';
  static const String enterAmount = 'Enter amount';
  static const String enterQuantity = 'Enter quantity';
  static const String enterPercentage = 'Enter percentage';
  static const String enterScore = 'Enter score';
  static const String enterRating = 'Enter rating';
  static const String selectOption = 'Select an option';
  static const String selectDate = 'Select date';
  static const String selectTime = 'Select time';
  static const String selectFile = 'Select file';
  static const String selectImage = 'Select image';
  static const String selectVideo = 'Select video';
  static const String selectAudio = 'Select audio';
  static const String selectDocument = 'Select document';
  static const String selectColor = 'Select color';
  static const String selectFont = 'Select font';
  static const String selectLanguage = 'Select language';
  static const String selectCountry = 'Select country';
  static const String selectCurrency = 'Select currency';
  static const String selectCategory = 'Select category';

  // Permission Dialog Messages
  static const String cameraPermissionRequired =
      'Camera permission is required';
  static const String storagePermissionRequired =
      'Storage permission is required';
  static const String locationPermissionRequired =
      'Location permission is required';
  static const String microphonePermissionRequired =
      'Microphone permission is required';
  static const String notificationPermissionRequired =
      'Notification permission is required';
  static const String contactsPermissionRequired =
      'Contacts permission is required';
  static const String calendarPermissionRequired =
      'Calendar permission is required';
  static const String permissionDeniedExplanation =
      'This permission is needed for the app to function properly';
  static const String grantPermission = 'Grant Permission';
  static const String openSettings = 'Open Settings';
  static const String skipPermission = 'Skip';
  static const String remindLater = 'Remind Me Later';

  // Update Dialog Messages
  static const String updateAvailable = 'Update Available';
  static const String newVersionAvailable = 'A new version is available';
  static const String updateRecommended = 'Update is recommended';
  static const String updateRequired = 'Update is required';
  static const String criticalUpdate = 'Critical update available';
  static const String securityUpdate = 'Security update available';
  static const String bugFixUpdate = 'Bug fix update available';
  static const String featureUpdate = 'Feature update available';
  static const String updateNow = 'Update Now';
  static const String updateLater = 'Update Later';
  static const String skipUpdate = 'Skip Update';
  static const String viewChangelog = 'View Changelog';
  static const String downloadUpdate = 'Download Update';
  static const String installUpdate = 'Install Update';
  static const String whatIsNew = 'What\'s New';
  static const String versionInfo = 'Version Information';
  static const String releaseNotes = 'Release Notes';
  static const String updateSize = 'Update Size';
  static const String estimatedTime = 'Estimated Time';
}

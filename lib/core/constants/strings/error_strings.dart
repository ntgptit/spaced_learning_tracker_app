// lib/core/constants/strings/error_strings.dart
/// Error and exception related strings

abstract class ErrorStrings {
  // Generic Errors
  static const String somethingWentWrong = 'Something went wrong';
  static const String unexpectedError = 'An unexpected error occurred';
  static const String operationFailed = 'Operation failed';
  static const String requestFailed = 'Request failed';
  static const String processingError = 'Processing error';
  static const String unknownError = 'Unknown error';
  static const String internalError = 'Internal error';
  static const String systemError = 'System error';
  static const String temporaryError = 'Temporary error';
  static const String criticalError = 'Critical error';
  
  // Network Errors
  static const String networkError = 'Network error';
  static const String connectionError = 'Connection error';
  static const String noInternetConnection = 'No internet connection';
  static const String connectionTimeout = 'Connection timeout';
  static const String connectionFailed = 'Connection failed';
  static const String serverError = 'Server error';
  static const String serverUnavailable = 'Server unavailable';
  static const String serverTimeout = 'Server timeout';
  static const String badRequest = 'Bad request';
  static const String unauthorized = 'Unauthorized';
  static const String forbidden = 'Forbidden';
  static const String notFound = 'Not found';
  static const String methodNotAllowed = 'Method not allowed';
  static const String conflict = 'Conflict';
  static const String tooManyRequests = 'Too many requests';
  static const String internalServerError = 'Internal server error';
  static const String badGateway = 'Bad gateway';
  static const String serviceUnavailable = 'Service unavailable';
  static const String gatewayTimeout = 'Gateway timeout';
  
  // Authentication Errors
  static const String invalidCredentials = 'Invalid credentials';
  static const String invalidUsernameOrPassword = 'Invalid username or password';
  static const String accountNotFound = 'Account not found';
  static const String accountLocked = 'Account is locked';
  static const String accountSuspended = 'Account is suspended';
  static const String accountDeactivated = 'Account is deactivated';
  static const String accountExpired = 'Account has expired';
  static const String sessionExpired = 'Session has expired';
  static const String tokenExpired = 'Token has expired';
  static const String tokenInvalid = 'Token is invalid';
  static const String accessDenied = 'Access denied';
  static const String insufficientPermissions = 'Insufficient permissions';
  static const String authenticationRequired = 'Authentication required';
  static const String authenticationFailed = 'Authentication failed';
  static const String loginRequired = 'Login required';
  static const String reauthenticationRequired = 'Re-authentication required';
  
  // Validation Errors
  static const String validationError = 'Validation error';
  static const String invalidInput = 'Invalid input';
  static const String invalidFormat = 'Invalid format';
  static const String invalidValue = 'Invalid value';
  static const String invalidRange = 'Invalid range';
  static const String invalidLength = 'Invalid length';
  static const String invalidCharacters = 'Invalid characters';
  static const String missingRequiredField = 'Missing required field';
  static const String fieldRequired = 'Field is required';
  static const String fieldTooShort = 'Field is too short';
  static const String fieldTooLong = 'Field is too long';
  static const String duplicateValue = 'Duplicate value';
  static const String valueAlreadyExists = 'Value already exists';
  static const String invalidEmail = 'Invalid email address';
  static const String invalidPhoneNumber = 'Invalid phone number';
  static const String invalidPassword = 'Invalid password';
  static const String passwordTooWeak = 'Password is too weak';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String invalidDate = 'Invalid date';
  static const String invalidTime = 'Invalid time';
  static const String invalidUrl = 'Invalid URL';
  static const String invalidFileFormat = 'Invalid file format';
  static const String fileTooLarge = 'File is too large';
  static const String fileNotSupported = 'File type not supported';
  
  // Data Errors
  static const String dataError = 'Data error';
  static const String dataCorrupted = 'Data is corrupted';
  static const String dataNotFound = 'Data not found';
  static const String dataAlreadyExists = 'Data already exists';
  static const String dataOutdated = 'Data is outdated';
  static const String dataInconsistent = 'Data is inconsistent';
  static const String dataIntegrityError = 'Data integrity error';
  static const String databaseError = 'Database error';
  static const String databaseConnectionError = 'Database connection error';
  static const String databaseTimeout = 'Database timeout';
  static const String queryError = 'Query error';
  static const String transactionError = 'Transaction error';
  
  // Permission Errors
  static const String permissionDenied = 'Permission denied';
  static const String readPermissionDenied = 'Read permission denied';
  static const String writePermissionDenied = 'Write permission denied';
  static const String deletePermissionDenied = 'Delete permission denied';
  static const String executePermissionDenied = 'Execute permission denied';
  static const String filePermissionDenied = 'File permission denied';
  static const String storagePermissionDenied = 'Storage permission denied';
  static const String cameraPermissionDenied = 'Camera permission denied';
  static const String microphonePermissionDenied = 'Microphone permission denied';
  static const String locationPermissionDenied = 'Location permission denied';
  static const String notificationPermissionDenied = 'Notification permission denied';
  
  // Operation Errors
  static const String operationNotAllowed = 'Operation not allowed';
  static const String operationCancelled = 'Operation was cancelled';
  static const String operationTimeout = 'Operation timed out';
  static const String operationInProgress = 'Operation already in progress';
  static const String operationNotSupported = 'Operation not supported';
  static const String saveError = 'Failed to save';
  static const String loadError = 'Failed to load';
  static const String deleteError = 'Failed to delete';
  static const String updateError = 'Failed to update';
  static const String createError = 'Failed to create';
  static const String uploadError = 'Failed to upload';
  static const String downloadError = 'Failed to download';
  static const String syncError = 'Failed to sync';
  static const String exportError = 'Failed to export';
  static const String importError = 'Failed to import';
  static const String parseError = 'Failed to parse';
  static const String encryptionError = 'Encryption error';
  static const String decryptionError = 'Decryption error';
  
  // Resource Errors
  static const String resourceNotFound = 'Resource not found';
  static const String resourceUnavailable = 'Resource unavailable';
  static const String resourceLocked = 'Resource is locked';
  static const String resourceBusy = 'Resource is busy';
  static const String resourceExhausted = 'Resource exhausted';
  static const String quotaExceeded = 'Quota exceeded';
  static const String limitExceeded = 'Limit exceeded';
  static const String capacityExceeded = 'Capacity exceeded';
  static const String memoryError = 'Memory error';
  static const String diskSpaceError = 'Insufficient disk space';
  static const String storageError = 'Storage error';
  static const String deviceError = 'Device error';
  static const String hardwareError = 'Hardware error';
  
  // User Messages
  static const String pleaseCheckConnection = 'Please check your internet connection';
  static const String pleaseTryAgain = 'Please try again';
  static const String pleaseTryAgainLater = 'Please try again later';
  static const String contactSupport = 'Please contact support';
  static const String checkInputAndTryAgain = 'Please check your input and try again';
  static const String refreshAndTryAgain = 'Please refresh the page and try again';
  static const String restartAppAndTryAgain = 'Please restart the app and try again';
}
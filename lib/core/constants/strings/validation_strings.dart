// // lib/core/constants/strings/validation_strings.dart
// /// Validation related strings
//
// abstract class ValidationStrings {
//   // Required Field Messages
//   static const String fieldRequired = 'This field is required';
//   static const String usernameRequired = 'Username is required';
//   static const String emailRequired = 'Email is required';
//   static const String passwordRequired = 'Password is required';
//   static const String firstNameRequired = 'First name is required';
//   static const String lastNameRequired = 'Last name is required';
//   static const String phoneRequired = 'Phone number is required';
//   static const String addressRequired = 'Address is required';
//   static const String cityRequired = 'City is required';
//   static const String stateRequired = 'State is required';
//   static const String zipCodeRequired = 'ZIP code is required';
//   static const String countryRequired = 'Country is required';
//   static const String dateRequired = 'Date is required';
//   static const String timeRequired = 'Time is required';
//   static const String categoryRequired = 'Category is required';
//   static const String titleRequired = 'Title is required';
//   static const String descriptionRequired = 'Description is required';
//   static const String messageRequired = 'Message is required';
//   static const String subjectRequired = 'Subject is required';
//
//   // Format Validation Messages
//   static const String invalidEmail = 'Please enter a valid email address';
//   static const String invalidPhoneNumber = 'Please enter a valid phone number';
//   static const String invalidUrl = 'Please enter a valid URL';
//   static const String invalidDate = 'Please enter a valid date';
//   static const String invalidTime = 'Please enter a valid time';
//   static const String invalidNumber = 'Please enter a valid number';
//   static const String invalidInteger = 'Please enter a valid integer';
//   static const String invalidDecimal = 'Please enter a valid decimal number';
//   static const String invalidZipCode = 'Please enter a valid ZIP code';
//   static const String invalidCreditCard = 'Please enter a valid credit card number';
//   static const String invalidCvv = 'Please enter a valid CVV';
//   static const String invalidExpiryDate = 'Please enter a valid expiry date';
//
//   // Length Validation Messages
//   static const String tooShort = 'This field is too short';
//   static const String tooLong = 'This field is too long';
//   static const String usernameTooShort = 'Username must be at least 3 characters';
//   static const String usernameTooLong = 'Username cannot exceed 30 characters';
//   static const String passwordTooShort = 'Password must be at least 8 characters';
//   static const String passwordTooLong = 'Password cannot exceed 128 characters';
//   static const String firstNameTooShort = 'First name must be at least 2 characters';
//   static const String firstNameTooLong = 'First name cannot exceed 50 characters';
//   static const String lastNameTooShort = 'Last name must be at least 2 characters';
//   static const String lastNameTooLong = 'Last name cannot exceed 50 characters';
//   static const String titleTooShort = 'Title must be at least 3 characters';
//   static const String titleTooLong = 'Title cannot exceed 100 characters';
//   static const String descriptionTooShort = 'Description must be at least 10 characters';
//   static const String descriptionTooLong = 'Description cannot exceed 500 characters';
//   static const String messageTooShort = 'Message must be at least 5 characters';
//   static const String messageTooLong = 'Message cannot exceed 1000 characters';
//
//   // Password Validation Messages
//   static const String passwordsDoNotMatch = 'Passwords do not match';
//   static const String passwordTooWeak = 'Password is too weak';
//   static const String passwordMustContainUppercase = 'Password must contain at least one uppercase letter';
//   static const String passwordMustContainLowercase = 'Password must contain at least one lowercase letter';
//   static const String passwordMustContainNumber = 'Password must contain at least one number';
//   static const String passwordMustContainSpecialChar = 'Password must contain at least one special character';
//   static const String passwordCannotContainSpaces = 'Password cannot contain spaces';
//   static const String passwordCannotContainUsername = 'Password cannot contain your username';
//   static const String passwordCannotBeCommon = 'Please choose a less common password';
//   static const String confirmPasswordRequired = 'Please confirm your password';
//   static const String currentPasswordRequired = 'Current password is required';
//   static const String newPasswordRequired = 'New password is required';
//   static const String newPasswordMustBeDifferent = 'New password must be different from current password';
//
//   // Username Validation Messages
//   static const String usernameAlreadyTaken = 'Username is already taken';
//   static const String usernameNotAvailable = 'Username is not available';
//   static const String usernameInvalidCharacters = 'Username can only contain letters, numbers, dots, underscores and hyphens';
//   static const String usernameCannotStartWithNumber = 'Username cannot start with a number';
//   static const String usernameCannotStartWithSpecialChar = 'Username cannot start with a special character';
//   static const String usernameCannotEndWithSpecialChar = 'Username cannot end with a special character';
//   static const String usernameCannotContainSpaces = 'Username cannot contain spaces';
//   static const String usernameReserved = 'This username is reserved';
//
//   // Email Validation Messages
//   static const String emailAlreadyExists = 'Email address is already registered';
//   static const String emailNotRegistered = 'Email address is not registered';
//   static const String emailDomainNotAllowed = 'Email domain is not allowed';
//   static const String emailTemporaryNotAllowed = 'Temporary email addresses are not allowed';
//   static const String emailMustBeVerified = 'Email address must be verified';
//
//   // Range Validation Messages
//   static const String valueTooSmall = 'Value is too small';
//   static const String valueTooLarge = 'Value is too large';
//   static const String ageMinimum = 'You must be at least 13 years old';
//   static const String ageMaximum = 'Age cannot exceed 120 years';
//   static const String quantityMinimum = 'Quantity must be at least 1';
//   static const String quantityMaximum = 'Quantity cannot exceed 999';
//   static const String priceMinimum = 'Price must be greater than 0';
//   static const String priceMaximum = 'Price cannot exceed \$999,999';
//   static const String scoreMinimum = 'Score must be between 0 and 100';
//   static const String percentageRange = 'Percentage must be between 0 and 100';
//   static const String ratingRange = 'Rating must be between 1 and 5';
//
//   // Date Validation Messages
//   static const String dateInPast = 'Date cannot be in the past';
//   static const String dateInFuture = 'Date cannot be in the future';
//   static const String dateRangeInvalid = 'End date must be after start date';
//   static const String birthDateInvalid = 'Please enter a valid birth date';
//   static const String birthDateTooOld = 'Birth date cannot be more than 120 years ago';
//   static const String birthDateInFuture = 'Birth date cannot be in the future';
//   static const String expiryDateInPast = 'Expiry date cannot be in the past';
//   static const String startDateRequired = 'Start date is required';
//   static const String endDateRequired = 'End date is required';
//   static const String dueDateInPast = 'Due date cannot be in the past';
//
//   // File Validation Messages
//   static const String fileRequired = 'File is required';
//   static const String fileTooLarge = 'File size is too large';
//   static const String fileTypeNotSupported = 'File type is not supported';
//   static const String imageRequired = 'Image is required';
//   static const String documentRequired = 'Document is required';
//   static const String videoRequired = 'Video is required';
//   static const String audioRequired = 'Audio is required';
//   static const String maxFileSize = 'Maximum file size is 10MB';
//   static const String minFileSize = 'File size is too small';
//   static const String imageFormatNotSupported = 'Image format not supported. Please use JPG, PNG, or GIF';
//   static const String documentFormatNotSupported = 'Document format not supported. Please use PDF, DOC, or DOCX';
//   static const String videoFormatNotSupported = 'Video format not supported. Please use MP4, AVI, or MOV';
//   static const String audioFormatNotSupported = 'Audio format not supported. Please use MP3, WAV, or AAC';
//
//   // Selection Validation Messages
//   static const String selectionRequired = 'Please make a selection';
//   static const String optionRequired = 'Please select an option';
//   static const String categorySelectionRequired = 'Please select a category';
//   static const String countrySelectionRequired = 'Please select a country';
//   static const String stateSelectionRequired = 'Please select a state';
//   static const String citySelectionRequired = 'Please select a city';
//   static const String languageSelectionRequired = 'Please select a language';
//   static const String timezoneSelectionRequired = 'Please select a timezone';
//   static const String currencySelectionRequired = 'Please select a currency';
//   static const String genderSelectionRequired = 'Please select a gender';
//
//   // Terms and Conditions
//   static const String termsAcceptanceRequired = 'You must accept the terms and conditions';
//   static const String privacyPolicyAcceptanceRequired = 'You must accept the privacy policy';
//   static const String ageConfirmationRequired = 'You must confirm that you are of legal age';
//   static const String consentRequired = 'Your consent is required to proceed';
//
//   // Security Validation
//   static const String securityQuestionRequired = 'Security question is required';
//   static const String securityAnswerRequired = 'Security answer is required';
//   static const String securityAnswerTooShort = 'Security answer must be at least 3 characters';
//   static const String twoFactorCodeRequired = 'Two-factor authentication code is required';
//   static const String twoFactorCodeInvalid = 'Invalid two-factor authentication code';
//   static const String captchaRequired = 'Please complete the CAPTCHA';
//   static const String captchaInvalid = 'Invalid CAPTCHA response';
//
//   // Custom Field Validation
//   static const String customFieldRequired = 'This custom field is required';
//   static const String customFieldInvalid = 'Custom field value is invalid';
//   static const String customFieldTooShort = 'Custom field value is too short';
//   static const String customFieldTooLong = 'Custom field value is too long';
//
//   // General Validation Helpers
//   static String fieldMinLength(String fieldName, int minLength) =>
//       '$fieldName must be at least $minLength characters';
//   static String fieldMaxLength(String fieldName, int maxLength) =>
//       '$fieldName cannot exceed $maxLength characters';
//   static String fieldExactLength(String fieldName, int length) =>
//       '$fieldName must be exactly $length characters';
//   static String fieldRange(String fieldName, num min, num max) =>
//       '$fieldName must be between $min and $max';
//   static String fieldMinValue(String fieldName, num min) =>
//       '$fieldName must be at least $min';
//   static String fieldMaxValue(String fieldName, num max) =>
//       '$fieldName cannot exceed $max';
// }

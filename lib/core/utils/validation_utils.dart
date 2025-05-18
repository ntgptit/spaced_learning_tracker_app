// import '../constants/app_constants.dart';
//
// /// Validation utilities
// /// Helper methods for input validation
// class ValidationUtils {
//   /// Validate if a string is not empty
//   static bool isNotEmpty(String? value) {
//     return value != null && value.trim().isNotEmpty;
//   }
//
//   /// Validate if a string is empty
//   static bool isEmpty(String? value) {
//     return value == null || value.trim().isEmpty;
//   }
//
//   /// Validate if a string is a valid email address
//   static bool isValidEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return AppConstants.emailRegex.hasMatch(value);
//   }
//
//   /// Validate if a string is a valid password
//   /// At least 8 characters, 1 letter, 1 number, and 1 special character
//   static bool isValidPassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return AppConstants.passwordRegex.hasMatch(value);
//   }
//
//   /// Validate if a string is a valid phone number
//   static bool isValidPhone(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return AppConstants.phoneRegex.hasMatch(value);
//   }
//
//   /// Validate if a string is a valid URL
//   static bool isValidUrl(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return AppConstants.urlRegex.hasMatch(value);
//   }
//
//   /// Validate if a string contains only numbers
//   static bool isNumeric(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return RegExp(r'^[0-9]+$').hasMatch(value);
//   }
//
//   /// Validate if a string contains only letters
//   static bool isAlpha(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
//   }
//
//   /// Validate if a string contains only letters and numbers
//   static bool isAlphanumeric(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
//   }
//
//   /// Validate if a string has a minimum length
//   static bool hasMinLength(String? value, int minLength) {
//     if (value == null) {
//       return false;
//     }
//
//     return value.length >= minLength;
//   }
//
//   /// Validate if a string has a maximum length
//   static bool hasMaxLength(String? value, int maxLength) {
//     if (value == null) {
//       return true;
//     }
//
//     return value.length <= maxLength;
//   }
//
//   /// Validate if a string is a valid date in format MM/DD/YYYY
//   static bool isValidDate(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     // Check format (MM/DD/YYYY)
//     if (!RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
//       return false;
//     }
//
//     final parts = value.split('/');
//     final month = int.parse(parts[0]);
//     final day = int.parse(parts[1]);
//     final year = int.parse(parts[2]);
//
//     // Check month, day, and year ranges
//     if (month < 1 || month > 12) {
//       return false;
//     }
//
//     if (day < 1 || day > 31) {
//       return false;
//     }
//
//     if (year < 1900 || year > 2100) {
//       return false;
//     }
//
//     // Check specific month/day combinations
//     if (month == 2) {
//       // February
//       final isLeapYear =
//           (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
//       if (day > (isLeapYear ? 29 : 28)) {
//         return false;
//       }
//     } else if ([4, 6, 9, 11].contains(month) && day > 30) {
//       // April, June, September, November
//       return false;
//     }
//
//     return true;
//   }
//
//   /// Validate if a number is within a range
//   static bool isInRange(num? value, num min, num max) {
//     if (value == null) {
//       return false;
//     }
//
//     return value >= min && value <= max;
//   }
//
//   /// Validate if a string is a valid credit card number
//   static bool isValidCreditCard(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     // Remove all non-digit characters
//     final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
//
//     if (digitsOnly.length < 13 || digitsOnly.length > 19) {
//       return false;
//     }
//
//     // Luhn algorithm (mod 10)
//     int sum = 0;
//     bool alternate = false;
//
//     for (int i = digitsOnly.length - 1; i >= 0; i--) {
//       int n = int.parse(digitsOnly[i]);
//
//       if (alternate) {
//         n *= 2;
//         if (n > 9) {
//           n = (n % 10) + 1;
//         }
//       }
//
//       sum += n;
//       alternate = !alternate;
//     }
//
//     return sum % 10 == 0;
//   }
//
//   /// Validate if a string is a valid credit card expiration date (MM/YY)
//   static bool isValidCreditCardExpiration(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     // Remove all non-digit characters
//     final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
//
//     if (digitsOnly.length != 4) {
//       return false;
//     }
//
//     final month = int.parse(digitsOnly.substring(0, 2));
//     final year = int.parse(digitsOnly.substring(2, 4));
//
//     if (month < 1 || month > 12) {
//       return false;
//     }
//
//     final currentDate = DateTime.now();
//     final currentYear =
//         currentDate.year % 100; // Get last two digits of the year
//     final currentMonth = currentDate.month;
//
//     // Check if the expiration date is in the past
//     if (year < currentYear || (year == currentYear && month < currentMonth)) {
//       return false;
//     }
//
//     return true;
//   }
//
//   /// Validate if a string is a valid credit card CVV
//   static bool isValidCvv(String? value, String? cardType) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     // Remove all non-digit characters
//     final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
//
//     // AMEX CVV is 4 digits, others are 3
//     if (cardType?.toLowerCase() == 'amex') {
//       return digitsOnly.length == 4;
//     } else {
//       return digitsOnly.length == 3;
//     }
//   }
//
//   /// Validate if a string is a valid username
//   /// Letters, numbers, underscores, and hyphens only
//   static bool isValidUsername(String? value) {
//     if (value == null || value.isEmpty) {
//       return false;
//     }
//
//     return RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(value);
//   }
//
//   /// Validate if passwords match
//   static bool passwordsMatch(String? password, String? confirmPassword) {
//     if (password == null || confirmPassword == null) {
//       return false;
//     }
//
//     return password == confirmPassword;
//   }
//
//   /// Validate if a string is a valid file extension
//   static bool isValidFileExtension(
//     String? fileName,
//     List<String> allowedExtensions,
//   ) {
//     if (fileName == null || fileName.isEmpty) {
//       return false;
//     }
//
//     final extension = fileName.split('.').last.toLowerCase();
//     return allowedExtensions.contains(extension);
//   }
//
//   /// Validate if a file size is within the allowed limit
//   static bool isValidFileSize(int fileSize, int maxSizeInBytes) {
//     return fileSize <= maxSizeInBytes;
//   }
//
//   /// Generic validator function that returns an error message or null if valid
//   static String? validate(
//     String? value,
//     List<Map<String, dynamic>> validators,
//   ) {
//     for (var validator in validators) {
//       final Function validationFn = validator['validator'];
//       final String errorMessage = validator['message'];
//
//       if (!validationFn(value)) {
//         return errorMessage;
//       }
//     }
//
//     return null;
//   }
// }

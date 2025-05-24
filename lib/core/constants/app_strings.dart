// lib/core/constants/app_strings.dart
import 'package:spaced_learning_app/core/constants/strings/auth_strings.dart';
import 'package:spaced_learning_app/core/constants/strings/error_strings.dart';
import 'package:spaced_learning_app/core/constants/strings/validation_strings.dart';

/// Main barrel file that exports all string constants
///
/// This file serves as the single point of access for all string constants
/// in the application. Import this file to access any string constant.
///
/// Usage:
/// ```dart
/// import 'package:spaced_learning_app/core/constants/app_strings.dart';
///
/// Text(AuthStrings.login);
/// Text(CommonStrings.loading);
/// Text(ErrorStrings.networkError);
/// ```

// Export all string category files
export 'strings/auth_strings.dart';
export 'strings/common_strings.dart';
export 'strings/dialog_strings.dart';
export 'strings/error_strings.dart';
export 'strings/learning_strings.dart';
export 'strings/navigation_strings.dart';

/// Legacy support - redirects to new structure
/// These are kept for backward compatibility during migration
@Deprecated('Use AuthStrings.login instead')
const String login = 'Login';

@Deprecated('Use CommonStrings.loading instead')
const String loading = 'Loading...';

@Deprecated('Use ErrorStrings.somethingWentWrong instead')
const String somethingWentWrong = 'Something went wrong';

@Deprecated('Use ValidationStrings.fieldRequired instead')
const String fieldRequired = 'This field is required';

/// Helper class for organizing commonly used string combinations
abstract class AppStringHelpers {
  /// Combines multiple string constants for common UI patterns
  static String get loginScreenTitle => AuthStrings.login;

  static String get loginScreenSubtitle => AuthStrings.loginSubtitle;

  static String get registerScreenTitle => AuthStrings.register;

  static String get registerScreenSubtitle => AuthStrings.registerSubtitle;

  /// Format strings with dynamic content
  static String welcomeMessage(String name) => 'Welcome back, $name!';

  static String studySessionComplete(int cardsStudied) =>
      'Session complete! You studied $cardsStudied ${cardsStudied == 1 ? 'card' : 'cards'}.';

  static String timeRemaining(String time) => 'Time remaining: $time';

  static String progressPercent(int percent) => 'Progress: $percent%';

  static String itemsSelected(int count, int total) =>
      '$count of $total selected';

  static String filesUploaded(int count) =>
      '$count ${count == 1 ? 'file' : 'files'} uploaded successfully';

  static String lastUpdated(String timeAgo) => 'Last updated $timeAgo';

  static String dueIn(String time) => 'Due in $time';

  static String createdBy(String author) => 'Created by $author';

  static String sharedWith(int count) =>
      'Shared with $count ${count == 1 ? 'person' : 'people'}';

  /// Common error message patterns
  static String networkErrorWithRetry(String action) =>
      'Failed to $action. Please check your connection and try again.';

  static String validationErrorWithField(String fieldName) =>
      '$fieldName is required and cannot be empty.';

  static String operationFailedWithReason(String operation, String reason) =>
      'Failed to $operation: $reason';

  /// Common success message patterns
  static String operationSuccessful(String operation) =>
      '$operation completed successfully!';

  static String itemSaved(String itemType) => '$itemType saved successfully.';

  static String itemDeleted(String itemType) =>
      '$itemType deleted successfully.';

  static String itemUpdated(String itemType) =>
      '$itemType updated successfully.';

  /// Learning-specific formatted strings
  static String cardsToReview(int count) =>
      '$count ${count == 1 ? 'card' : 'cards'} ready for review';

  static String newCardsAvailable(int count) =>
      '$count new ${count == 1 ? 'card' : 'cards'} available';

  static String studyStreak(int days) =>
      '$days day${days == 1 ? '' : 's'} study streak!';

  static String deckProgress(int completed, int total) =>
      '$completed of $total cards completed';

  static String sessionTime(String duration) => 'Session time: $duration';

  static String accuracyRate(int percentage) => 'Accuracy: $percentage%';

  static String nextReviewIn(String time) => 'Next review in $time';

  static String masteredCards(int count) =>
      '$count ${count == 1 ? 'card' : 'cards'} mastered';

  /// Dialog and confirmation patterns
  static String confirmDelete(String itemName) =>
      'Are you sure you want to delete "$itemName"? This action cannot be undone.';

  static String confirmLogout() =>
      'Are you sure you want to logout? Any unsaved progress will be lost.';

  static String confirmReset(String settingName) =>
      'Are you sure you want to reset $settingName to default values?';

  static String confirmClear(String dataType) =>
      'Are you sure you want to clear all $dataType? This action cannot be undone.';

  static String formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;
      return '${hours}h ${minutes}m';
    } else if (duration.inMinutes > 0) {
      final minutes = duration.inMinutes;
      final seconds = duration.inSeconds % 60;
      return '${minutes}m ${seconds}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  /// File size formatting
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  /// Number formatting helpers
  static String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else if (number < 1000000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    }
  }

  static String formatPercent(double value) {
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  /// Pluralization helpers
  static String pluralize(int count, String singular, String plural) {
    return count == 1 ? singular : plural;
  }

  static String itemCount(int count, String itemType) {
    return '$count ${pluralize(count, itemType, '${itemType}s')}';
  }

  /// Validation message helpers
  static String lengthValidation(String fieldName, int min, int max) {
    return ValidationStrings.fieldRange(fieldName, min, max);
  }

  static String rangeValidation(String fieldName, num min, num max) {
    return ValidationStrings.fieldRange(fieldName, min, max);
  }

  /// API and network helpers
  static String httpErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return ErrorStrings.badRequest;
      case 401:
        return ErrorStrings.unauthorized;
      case 403:
        return ErrorStrings.forbidden;
      case 404:
        return ErrorStrings.notFound;
      case 429:
        return ErrorStrings.tooManyRequests;
      case 500:
        return ErrorStrings.internalServerError;
      case 502:
        return ErrorStrings.badGateway;
      case 503:
        return ErrorStrings.serviceUnavailable;
      case 504:
        return ErrorStrings.gatewayTimeout;
      default:
        return ErrorStrings.unexpectedError;
    }
  }

  /// Search and filter helpers
  static String searchResults(int count, String query) {
    if (count == 0) {
      return 'No results found for "$query"';
    } else {
      return '$count ${pluralize(count, 'result', 'results')} found for "$query"';
    }
  }

  static String filterApplied(int count) {
    return '$count ${pluralize(count, 'filter', 'filters')} applied';
  }

  /// Learning progress helpers
  static String learningProgress(int completed, int total) {
    final percentage = ((completed / total) * 100).round();
    return 'Progress: $completed/$total ($percentage%)';
  }

  static String difficultyLevel(int level) {
    switch (level) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Elementary';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Advanced';
      case 5:
        return 'Expert';
      default:
        return 'Unknown';
    }
  }

  /// Accessibility helpers
  static String accessibilityLabel(String action, String target) {
    return '$action $target';
  }

  static String accessibilityHint(String action) {
    return 'Double tap to $action';
  }

  static String accessibilityValue(String current, String max) {
    return '$current of $max';
  }
}

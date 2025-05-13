import 'package:intl/intl.dart';

/// Date utilities
/// Helper methods for date manipulation and formatting
class DateUtils {
  /// Format date to string with specific pattern
  static String formatDate(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }

  /// Format date to full date format (e.g., Monday, January 1, 2025)
  static String formatFullDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  /// Format date to short date format (e.g., Jan 1, 2025)
  static String formatShortDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  /// Format date to time format (e.g., 12:30 PM)
  static String formatTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  /// Format date to date and time format (e.g., Jan 1, 2025 12:30 PM)
  static String formatDateTime(DateTime date) {
    return DateFormat.yMMMd().add_jm().format(date);
  }

  /// Format date to ISO format (e.g., 2025-01-01T12:30:00Z)
  static String formatISODate(DateTime date) {
    return date.toIso8601String();
  }

  /// Parse string to date with specific pattern
  static DateTime? parseDate(String date, String pattern) {
    try {
      return DateFormat(pattern).parse(date);
    } catch (e) {
      return null;
    }
  }

  /// Parse ISO date string to DateTime
  static DateTime? parseISODate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  /// Check if two dates are on the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// Check if a date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDay(date, now);
  }

  /// Check if a date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  /// Check if a date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(date, tomorrow);
  }

  /// Get the start of the day (00:00:00.000)
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get the end of the day (23:59:59.999)
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Get the start of the week (Monday)
  static DateTime startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  /// Get the end of the week (Sunday)
  static DateTime endOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date
        .add(Duration(days: 7 - weekday))
        .subtract(const Duration(microseconds: 1));
  }

  /// Get the start of the month
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }

  /// Get the end of the month
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1)
        .subtract(const Duration(microseconds: 1));
  }

  /// Get the difference in days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = startOfDay(from);
    to = startOfDay(to);
    return (to.difference(from).inHours / 24).round();
  }

  /// Get the age from a birthdate
  static int getAge(DateTime birthDate) {
    final currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// Get friendly date string (Today, Yesterday, or formatted date)
  static String getFriendlyDate(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else {
      return formatShortDate(date);
    }
  }

  /// Get time ago string (e.g., 2 hours ago, 3 days ago, etc.)
  static String getTimeAgo(DateTime date) {
    final Duration difference = DateTime.now().difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  /// Add months to a date
  static DateTime addMonths(DateTime date, int months) {
    var year = date.year;
    var month = date.month + months;

    while (month > 12) {
      month -= 12;
      year++;
    }

    while (month < 1) {
      month += 12;
      year--;
    }

    // Handle invalid day (e.g., Feb 30)
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final day = date.day > daysInMonth ? daysInMonth : date.day;

    return DateTime(year, month, day, date.hour, date.minute, date.second,
        date.millisecond, date.microsecond);
  }

  /// Check if a date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Check if a date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Get a list of dates between two dates
  static List<DateTime> getDatesBetween(DateTime startDate, DateTime endDate) {
    final List<DateTime> dates = [];
    DateTime currentDate = startDate;

    while (!isSameDay(currentDate, endDate)) {
      dates.add(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }

    dates.add(endDate);

    return dates;
  }
}

import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(DateTime date, String pattern) {
    return DateFormat(pattern).format(date);
  }

  static String formatFullDate(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  static String formatShortDate(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat.yMMMd().add_jm().format(date);
  }

  static String formatISODate(DateTime date) {
    return date.toIso8601String();
  }

  static DateTime? parseDate(String date, String pattern) {
    try {
      return DateFormat(pattern).parse(date);
    } catch (e) {
      return null;
    }
  }

  static DateTime? parseISODate(String date) {
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null;
    }
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return isSameDay(date, now);
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return isSameDay(date, tomorrow);
  }

  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  static DateTime startOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  static DateTime endOfWeek(DateTime date) {
    final weekday = date.weekday;
    return date
        .add(Duration(days: 7 - weekday))
        .subtract(const Duration(microseconds: 1));
  }

  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }

  static DateTime endOfMonth(DateTime date) {
    return DateTime(
      date.year,
      date.month + 1,
    ).subtract(const Duration(microseconds: 1));
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = startOfDay(from);
    to = startOfDay(to);
    return (to.difference(from).inHours / 24).round();
  }

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

  static String getFriendlyDate(DateTime date) {
    if (isToday(date)) {
      return 'Today';
    } else if (isYesterday(date)) {
      return 'Yesterday';
    } else {
      return formatShortDate(date);
    }
  }

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

    final daysInMonth = DateTime(year, month + 1, 0).day;
    final day = date.day > daysInMonth ? daysInMonth : date.day;

    return DateTime(
      year,
      month,
      day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }

  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

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

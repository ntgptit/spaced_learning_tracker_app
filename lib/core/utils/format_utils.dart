import 'dart:math';

import 'package:intl/intl.dart';

class FormatUtils {
  static String formatNumber(num number) {
    return NumberFormat('#,##0').format(number);
  }

  static String formatDecimal(num number, {int decimalPlaces = 2}) {
    return NumberFormat('#,##0.${'0' * decimalPlaces}').format(number);
  }

  static String formatCurrency(num amount,
      {String symbol = '\$', int decimalPlaces = 2}) {
    return NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalPlaces,
    ).format(amount);
  }

  static String formatPercentage(num value, {int decimalPlaces = 1}) {
    return NumberFormat.percentPattern().format(value / 100);
  }

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

  static String formatDuration(int milliseconds) {
    final seconds = (milliseconds / 1000).floor();
    final minutes = (seconds / 60).floor();

    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  static String formatDurationHMS(int milliseconds) {
    final seconds = (milliseconds / 1000).floor();
    final minutes = (seconds / 60).floor();
    final hours = (minutes / 60).floor();

    if (hours > 0) {
      return '$hours h ${minutes % 60} m';
    } else if (minutes > 0) {
      return '$minutes m ${seconds % 60} s';
    } else {
      return '$seconds s';
    }
  }

  static String formatPhoneNumber(String phoneNumber) {
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length == 10) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    } else if (digitsOnly.length == 11 && digitsOnly[0] == '1') {
      return '(${digitsOnly.substring(1, 4)}) ${digitsOnly.substring(4, 7)}-${digitsOnly.substring(7)}';
    } else {
      return phoneNumber;
    }
  }

  static String formatCreditCardNumber(String cardNumber) {
    final digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < 4) {
      return cardNumber;
    }

    final lastFour = digitsOnly.substring(digitsOnly.length - 4);
    final masked = '*' * (digitsOnly.length - 4);

    final formattedMasked = masked
        .replaceAllMapped(
          RegExp(r'.{4}'),
          (match) => '${match.group(0)} ',
        )
        .trim();

    return '$formattedMasked $lastFour';
  }

  static String formatCreditCardExpiration(String expiration) {
    final digitsOnly = expiration.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < 2) {
      return digitsOnly;
    } else if (digitsOnly.length == 2) {
      return digitsOnly;
    } else {
      return '${digitsOnly.substring(0, 2)}/${digitsOnly.substring(2, 4)}';
    }
  }

  static String formatName(String name) {
    if (name.isEmpty) {
      return name;
    }

    return name.split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }

  static String maskEmail(String email) {
    if (!email.contains('@') || email.split('@').length != 2) {
      return email;
    }

    final parts = email.split('@');
    final name = parts[0];
    final domain = parts[1];

    if (name.length <= 2) {
      return email;
    }

    final maskedName =
        '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}';
    return '$maskedName@$domain';
  }

  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }

    return '${text.substring(0, maxLength)}...';
  }

  static String formatOrdinal(int number) {
    if (number % 100 >= 11 && number % 100 <= 13) {
      return '${number}th';
    }

    switch (number % 10) {
      case 1:
        return '${number}st';
      case 2:
        return '${number}nd';
      case 3:
        return '${number}rd';
      default:
        return '${number}th';
    }
  }

  static String formatBytes(int bytes, {int decimals = 1}) {
    if (bytes == 0) return '0 Bytes';

    const k = 1024;
    final dm = decimals < 0 ? 0 : decimals;
    const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];

    final i = (log(bytes) / log(k)).floor();

    return '${(bytes / pow(k, i)).toStringAsFixed(dm)} ${sizes[i]}';
  }
}

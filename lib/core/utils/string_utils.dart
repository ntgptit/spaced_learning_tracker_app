import 'package:flutter/foundation.dart';

class StringUtils {
  static String? sanitizeId(String id, {String? source}) {
    if (id.isEmpty) {
      final sourceInfo = source != null ? ' in $source' : '';
      debugPrint('WARNING: Empty ID detected$sourceInfo');
      return null;
    }

    final sanitizedId = id.trim();
    if (sanitizedId != id) {
      final sourceInfo = source != null ? ' in $source' : '';
      debugPrint('ID sanitized from "$id" to "$sanitizedId"$sourceInfo');
    }
    return sanitizedId;
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static String getInitials(String text, {int maxInitials = 2}) {
    if (text.isEmpty) return '';

    final parts = text.trim().split(' ');
    if (parts.length >= maxInitials) {
      return (parts.first[0] + parts.last[0]).toUpperCase();
    }
    return text.isNotEmpty ? text[0].toUpperCase() : '';
  }
}

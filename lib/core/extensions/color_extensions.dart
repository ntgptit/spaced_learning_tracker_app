// lib/core/extensions/color_extensions.dart
import 'package:flutter/material.dart';

/// Extension for semantic colors in the app theme
class SemanticColorExtension extends ThemeExtension<SemanticColorExtension> {
  // Score and rating colors
  final Color excellentColor;
  final Color goodColor;
  final Color averageColor;
  final Color belowAverageColor;
  final Color poorColor;

  // Status colors
  final Color successColor;
  final Color warningColor;
  final Color errorColor;
  final Color infoColor;
  final Color neutralColor;

  // Functional colors
  final Color disabledColor;
  final Color highlightColor;
  final Color selectedColor;
  final Color unselectedColor;

  // Custom semantic colors
  final Color newItemColor;
  final Color updatedItemColor;
  final Color deletedItemColor;
  final Color archivedColor;

  // Learning specific colors
  final Color masteringColor; // For fully mastered content
  final Color learningColor; // For in-progress learning
  final Color needsReviewColor; // For content that needs review
  final Color notStartedColor; // For content not yet started

  const SemanticColorExtension({
    required this.excellentColor,
    required this.goodColor,
    required this.averageColor,
    required this.belowAverageColor,
    required this.poorColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
    required this.infoColor,
    required this.neutralColor,
    required this.disabledColor,
    required this.highlightColor,
    required this.selectedColor,
    required this.unselectedColor,
    required this.newItemColor,
    required this.updatedItemColor,
    required this.deletedItemColor,
    required this.archivedColor,
    required this.masteringColor,
    required this.learningColor,
    required this.needsReviewColor,
    required this.notStartedColor,
  });

  /// Default light theme semantic colors
  factory SemanticColorExtension.light() {
    return const SemanticColorExtension(
      // Score colors
      excellentColor: Color(0xFF1E8E3E),
      // Green
      goodColor: Color(0xFF188038),
      // Light green
      averageColor: Color(0xFFFABC05),
      // Amber
      belowAverageColor: Color(0xFFF59E0B),
      // Orange
      poorColor: Color(0xFFD93025),
      // Red

      // Status colors
      successColor: Color(0xFF1E8E3E),
      // Green
      warningColor: Color(0xFFFFA000),
      // Orange
      errorColor: Color(0xFFD93025),
      // Red
      infoColor: Color(0xFF1A73E8),
      // Blue
      neutralColor: Color(0xFF5F6368),
      // Grey

      // Functional colors
      disabledColor: Color(0xFFDADCE0),
      // Light grey
      highlightColor: Color(0xFFE8F0FE),
      // Light blue highlight
      selectedColor: Color(0xFF1A73E8),
      // Blue for selected items
      unselectedColor: Color(0xFF5F6368),
      // Grey for unselected items

      // Custom semantic colors
      newItemColor: Color(0xFF1A73E8),
      // Blue
      updatedItemColor: Color(0xFF188038),
      // Green
      deletedItemColor: Color(0xFFEA4335),
      // Red
      archivedColor: Color(0xFF5F6368),
      // Grey

      // Learning specific colors
      masteringColor: Color(0xFF1E8E3E),
      // Mastering (Green)
      learningColor: Color(0xFF1A73E8),
      // Learning (Blue)
      needsReviewColor: Color(0xFFFA8C16),
      // Needs review (Orange)
      notStartedColor: Color(0xFF5F6368), // Not started (Grey)
    );
  }

  /// Default dark theme semantic colors
  factory SemanticColorExtension.dark() {
    return const SemanticColorExtension(
      // Score colors
      excellentColor: Color(0xFF81C995),
      // Lighter green
      goodColor: Color(0xFF7CB342),
      // Lighter green
      averageColor: Color(0xFFFDD663),
      // Lighter amber
      belowAverageColor: Color(0xFFFBBD06),
      // Lighter orange
      poorColor: Color(0xFFF28B82),
      // Lighter red

      // Status colors
      successColor: Color(0xFF81C995),
      // Lighter green
      warningColor: Color(0xFFFFCA64),
      // Lighter orange
      errorColor: Color(0xFFF28B82),
      // Lighter red
      infoColor: Color(0xFF8AB4F8),
      // Lighter blue
      neutralColor: Color(0xFFBDC1C6),
      // Lighter grey

      // Functional colors
      disabledColor: Color(0xFF5F6368),
      // Dark grey
      highlightColor: Color(0xFF1F2532),
      // Dark blue highlight
      selectedColor: Color(0xFF8AB4F8),
      // Lighter blue
      unselectedColor: Color(0xFFBDC1C6),
      // Light grey

      // Custom semantic colors
      newItemColor: Color(0xFF8AB4F8),
      // Lighter blue
      updatedItemColor: Color(0xFF81C995),
      // Lighter green
      deletedItemColor: Color(0xFFF28B82),
      // Lighter red
      archivedColor: Color(0xFFBDC1C6),
      // Light grey

      // Learning specific colors
      masteringColor: Color(0xFF81C995),
      // Lighter green
      learningColor: Color(0xFF8AB4F8),
      // Lighter blue
      needsReviewColor: Color(0xFFFFC06A),
      // Lighter orange
      notStartedColor: Color(0xFFBDC1C6), // Light grey
    );
  }

  /// Helper method to get appropriate color for score value
  Color getScoreColor(double score, {double maxScore = 100}) {
    final percentage = score / maxScore;

    if (percentage >= 0.9) return excellentColor;
    if (percentage >= 0.7) return goodColor;
    if (percentage >= 0.5) return averageColor;
    if (percentage >= 0.3) return belowAverageColor;
    return poorColor;
  }

  /// Helper method to get color based on learning status
  Color getLearningStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'mastered':
      case 'mastering':
      case 'completed':
        return masteringColor;
      case 'learning':
      case 'in progress':
        return learningColor;
      case 'needs review':
      case 'review':
        return needsReviewColor;
      case 'not started':
      default:
        return notStartedColor;
    }
  }

  /// Helper method to get appropriate color for content status
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'success':
      case 'succeeded':
      case 'completed':
        return successColor;
      case 'warning':
      case 'pending':
        return warningColor;
      case 'error':
      case 'failed':
        return errorColor;
      case 'info':
      case 'information':
        return infoColor;
      default:
        return neutralColor;
    }
  }

  @override
  ThemeExtension<SemanticColorExtension> copyWith({
    Color? excellentColor,
    Color? goodColor,
    Color? averageColor,
    Color? belowAverageColor,
    Color? poorColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    Color? neutralColor,
    Color? disabledColor,
    Color? highlightColor,
    Color? selectedColor,
    Color? unselectedColor,
    Color? newItemColor,
    Color? updatedItemColor,
    Color? deletedItemColor,
    Color? archivedColor,
    Color? masteringColor,
    Color? learningColor,
    Color? needsReviewColor,
    Color? notStartedColor,
  }) {
    return SemanticColorExtension(
      excellentColor: excellentColor ?? this.excellentColor,
      goodColor: goodColor ?? this.goodColor,
      averageColor: averageColor ?? this.averageColor,
      belowAverageColor: belowAverageColor ?? this.belowAverageColor,
      poorColor: poorColor ?? this.poorColor,
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      infoColor: infoColor ?? this.infoColor,
      neutralColor: neutralColor ?? this.neutralColor,
      disabledColor: disabledColor ?? this.disabledColor,
      highlightColor: highlightColor ?? this.highlightColor,
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      newItemColor: newItemColor ?? this.newItemColor,
      updatedItemColor: updatedItemColor ?? this.updatedItemColor,
      deletedItemColor: deletedItemColor ?? this.deletedItemColor,
      archivedColor: archivedColor ?? this.archivedColor,
      masteringColor: masteringColor ?? this.masteringColor,
      learningColor: learningColor ?? this.learningColor,
      needsReviewColor: needsReviewColor ?? this.needsReviewColor,
      notStartedColor: notStartedColor ?? this.notStartedColor,
    );
  }

  @override
  ThemeExtension<SemanticColorExtension> lerp(
    ThemeExtension<SemanticColorExtension>? other,
    double t,
  ) {
    if (other is! SemanticColorExtension) {
      return this;
    }

    return SemanticColorExtension(
      excellentColor: Color.lerp(excellentColor, other.excellentColor, t)!,
      goodColor: Color.lerp(goodColor, other.goodColor, t)!,
      averageColor: Color.lerp(averageColor, other.averageColor, t)!,
      belowAverageColor: Color.lerp(
        belowAverageColor,
        other.belowAverageColor,
        t,
      )!,
      poorColor: Color.lerp(poorColor, other.poorColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,
      newItemColor: Color.lerp(newItemColor, other.newItemColor, t)!,
      updatedItemColor: Color.lerp(
        updatedItemColor,
        other.updatedItemColor,
        t,
      )!,
      deletedItemColor: Color.lerp(
        deletedItemColor,
        other.deletedItemColor,
        t,
      )!,
      archivedColor: Color.lerp(archivedColor, other.archivedColor, t)!,
      masteringColor: Color.lerp(masteringColor, other.masteringColor, t)!,
      learningColor: Color.lerp(learningColor, other.learningColor, t)!,
      needsReviewColor: Color.lerp(
        needsReviewColor,
        other.needsReviewColor,
        t,
      )!,
      notStartedColor: Color.lerp(notStartedColor, other.notStartedColor, t)!,
    );
  }
}

/// Extension methods for ThemeData to easily access semantic colors
extension ThemeDataExtension on ThemeData {
  /// Get semantic colors from theme
  SemanticColorExtension get semanticColors =>
      extension<SemanticColorExtension>() ?? SemanticColorExtension.light();

  /// Get score color based on value
  Color getScoreColor(double score, {double maxScore = 100}) {
    // If the theme has SemanticColorExtension, use it
    final semanticExtension = extension<SemanticColorExtension>();
    if (semanticExtension != null) {
      return semanticExtension.getScoreColor(score, maxScore: maxScore);
    }

    // Fallback implementation using ColorScheme
    final percentage = score / maxScore;

    if (percentage >= 0.9) return colorScheme.primary;
    if (percentage >= 0.7) return colorScheme.tertiary;
    if (percentage >= 0.5) return colorScheme.secondary;
    if (percentage >= 0.3) return Colors.orange.shade700;
    return colorScheme.error;
  }

  /// Get learning status color
  Color getLearningStatusColor(String status) {
    final semanticExtension = extension<SemanticColorExtension>();
    if (semanticExtension != null) {
      return semanticExtension.getLearningStatusColor(status);
    }

    // Fallback implementation
    switch (status.toLowerCase()) {
      case 'mastered':
      case 'mastering':
      case 'completed':
        return colorScheme.primary;
      case 'learning':
      case 'in progress':
        return colorScheme.tertiary;
      case 'needs review':
      case 'review':
        return Colors.orange;
      case 'not started':
      default:
        return Colors.grey;
    }
  }

  /// Get status color (success, warning, error, etc.)
  Color getStatusColor(String status) {
    final semanticExtension = extension<SemanticColorExtension>();
    if (semanticExtension != null) {
      return semanticExtension.getStatusColor(status);
    }

    // Fallback implementation
    switch (status.toLowerCase()) {
      case 'success':
      case 'succeeded':
      case 'completed':
        return Colors.green;
      case 'warning':
      case 'pending':
        return Colors.orange;
      case 'error':
      case 'failed':
        return colorScheme.error;
      case 'info':
      case 'information':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

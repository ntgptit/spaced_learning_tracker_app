import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/app_dimens.dart';
import '../../../core/theme/app_theme.dart';
import '../buttons/slt_dialog_button_bar.dart';
import '../buttons/slt_primary_button.dart';
import '../buttons/slt_text_button.dart';

part 'slt_score_input_dialog_content.g.dart';

@riverpod
class ScoreValue extends _$ScoreValue {
  @override
  double build(String dialogId, {double initialValue = 70.0}) => initialValue;

  void setScore(double value) {
    state = value;
  }
}

class SltScoreInputDialogContent extends ConsumerWidget {
  final String dialogId;
  final double initialValue;
  final double minValue;
  final double maxValue;
  final int divisions;
  final String title;
  final String? subtitle;
  final String confirmText;
  final String cancelText;
  final IconData? titleIcon;

  const SltScoreInputDialogContent({
    super.key,
    required this.dialogId,
    this.initialValue = 70.0,
    this.minValue = 0.0,
    this.maxValue = 100.0,
    this.divisions = 100,
    this.title = 'Input Score',
    this.subtitle,
    this.confirmText = 'Submit',
    this.cancelText = 'Cancel',
    this.titleIcon = Icons.leaderboard_outlined,
  });

  factory SltScoreInputDialogContent._create({
    required String dialogId,
    double initialValue = 70.0,
    double minValue = 0.0,
    double maxValue = 100.0,
    int divisions = 100,
    String title = 'Input Score',
    String? subtitle,
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
    IconData? titleIcon = Icons.leaderboard_outlined,
  }) {
    return SltScoreInputDialogContent(
      dialogId: dialogId,
      initialValue: initialValue,
      minValue: minValue,
      maxValue: maxValue,
      divisions: divisions,
      title: title,
      subtitle: subtitle,
      confirmText: confirmText,
      cancelText: cancelText,
      titleIcon: titleIcon,
    );
  }

  factory SltScoreInputDialogContent.standard({
    required String dialogId,
    double initialValue = 70.0,
    String title = 'Rate Your Experience',
    String? subtitle = 'Drag the slider to rate',
    IconData titleIcon = Icons.star_outline_rounded,
  }) {
    return SltScoreInputDialogContent._create(
      dialogId: dialogId,
      initialValue: initialValue,
      title: title,
      subtitle: subtitle,
      titleIcon: titleIcon,
    );
  }

  factory SltScoreInputDialogContent.feedback({
    required String dialogId,
    double initialValue = 50.0,
    String title = 'Provide Feedback',
    String? subtitle = 'How would you rate this content?',
  }) {
    return SltScoreInputDialogContent._create(
      dialogId: dialogId,
      initialValue: initialValue,
      title: title,
      subtitle: subtitle,
      titleIcon: Icons.feedback_outlined,
      confirmText: 'Submit Feedback',
    );
  }

  factory SltScoreInputDialogContent.assessment({
    required String dialogId,
    double initialValue = 0.0,
    double maxValue = 100.0,
    String title = 'Input Test Score',
    String? subtitle = 'Move the slider to set the score',
  }) {
    return SltScoreInputDialogContent._create(
      dialogId: dialogId,
      initialValue: initialValue,
      maxValue: maxValue,
      title: title,
      subtitle: subtitle,
      titleIcon: Icons.school_outlined,
      confirmText: 'Record Score',
    );
  }

  Color _getScoreColor(
    ColorScheme colorScheme,
    BuildContext context,
    double score,
  ) {
    final percentage = (score - minValue) / (maxValue - minValue);
    final theme = Theme.of(context);
    if (theme.extension<SemanticColorExtension>() != null) {
      return theme.getScoreColor(score);
    }

    if (percentage >= 0.9) return colorScheme.primary;
    if (percentage >= 0.7) return colorScheme.tertiary;
    if (percentage >= 0.5) return colorScheme.secondary;
    if (percentage >= 0.3) return Colors.orange.shade700;
    return colorScheme.error;
  }

  Color _getContrastTextColor(Color backgroundColor, ColorScheme colorScheme) {
    return backgroundColor.computeLuminance() > 0.5
        ? colorScheme.onSurface
        : colorScheme.surface;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(
            scoreValueProvider(dialogId, initialValue: initialValue).notifier,
          )
          .setScore(initialValue.clamp(minValue, maxValue));
    });

    final scoreValue = ref.watch(
      scoreValueProvider(dialogId, initialValue: initialValue),
    );

    final scoreColor = _getScoreColor(colorScheme, context, scoreValue);
    final scoreDisplayBackgroundColor = scoreColor.withValues(alpha: 0.1);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (titleIcon != null) ...[
              Icon(
                titleIcon,
                color: colorScheme.primary,
                size: AppDimens.iconL,
              ),
              const SizedBox(width: AppDimens.spaceS),
            ],
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppDimens.spaceXS),
          Text(
            subtitle!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: AppDimens.spaceXL),
        Container(
          width: AppDimens.iconXXL * 1.8,
          height: AppDimens.iconXXL * 1.8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scoreDisplayBackgroundColor,
            border: Border.all(
              color: scoreColor.withValues(alpha: 0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: scoreColor.withValues(alpha: 0.2),
                blurRadius: AppDimens.shadowRadiusM,
                spreadRadius: AppDimens.shadowOffsetS,
              ),
            ],
          ),
          child: Center(
            child: Text(
              scoreValue.round().toString(),
              style: theme.textTheme.displayMedium?.copyWith(
                color: scoreColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppDimens.spaceXL),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: scoreColor,
            inactiveTrackColor: scoreColor.withValues(alpha: 0.25),
            thumbColor: scoreColor,
            overlayColor: scoreColor.withValues(alpha: 0.15),
            trackHeight: AppDimens.lineProgressHeightL,
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: AppDimens.radiusM,
            ),
            overlayShape: const RoundSliderOverlayShape(
              overlayRadius: AppDimens.paddingXL,
            ),
            valueIndicatorColor: colorScheme.primaryContainer,
            valueIndicatorTextStyle: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
          ),
          child: Slider(
            value: scoreValue,
            min: minValue,
            max: maxValue,
            divisions: divisions,
            label: '${scoreValue.round()}',
            onChanged: (value) {
              ref
                  .read(
                    scoreValueProvider(
                      dialogId,
                      initialValue: initialValue,
                    ).notifier,
                  )
                  .setScore(value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                minValue.round().toString(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                maxValue.round().toString(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimens.spaceXL),
        SltDialogButtonBar(
          cancelButton: SltTextButton(
            text: cancelText,
            onPressed: () => Navigator.of(context).pop(),
          ),
          confirmButton: SltPrimaryButton(
            text: confirmText,
            onPressed: () => Navigator.of(context).pop(scoreValue),
            backgroundColor: scoreColor,
            foregroundColor: _getContrastTextColor(scoreColor, colorScheme),
          ),
        ),
      ],
    );
  }

  static Future<double?> show(
    BuildContext context,
    WidgetRef ref, {
    required String dialogId,
    double initialValue = 70.0,
    double minValue = 0.0,
    double maxValue = 100.0,
    int divisions = 100,
    String title = 'Input Score',
    String? subtitle,
    String confirmText = 'Submit',
    String cancelText = 'Cancel',
    IconData? titleIcon = Icons.leaderboard_outlined,
  }) {
    ref
        .read(scoreValueProvider(dialogId, initialValue: initialValue).notifier)
        .setScore(initialValue.clamp(minValue, maxValue));

    return showDialog<double>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusXL),
          ),
          backgroundColor: Theme.of(dialogContext).colorScheme.surface,
          surfaceTintColor: Theme.of(dialogContext).colorScheme.surfaceTint,
          content: SltScoreInputDialogContent._create(
            dialogId: dialogId,
            initialValue: initialValue,
            minValue: minValue,
            maxValue: maxValue,
            divisions: divisions,
            title: title,
            subtitle: subtitle,
            confirmText: confirmText,
            cancelText: cancelText,
            titleIcon: titleIcon,
          ),
          contentPadding: const EdgeInsets.all(AppDimens.paddingXL),
        );
      },
    );
  }
}

extension ScoreColorExtension on ThemeData {
  Color getScoreColor(double score) {
    final colorScheme = this.colorScheme;
    if (score >= 90) return colorScheme.primary;
    if (score >= 70) return colorScheme.tertiary;
    if (score >= 50) return colorScheme.secondary;
    if (score >= 30) return Colors.orange.shade700;
    return colorScheme.error;
  }
}

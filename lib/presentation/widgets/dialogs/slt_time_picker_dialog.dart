import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/theme/app_dimens.dart';

part 'slt_time_picker_dialog.g.dart';

@riverpod
class SelectedTime extends _$SelectedTime {
  @override
  TimeOfDay build() => TimeOfDay.now();

  void setTime(TimeOfDay time) {
    state = time;
  }
}

class SltTimePickerDialog extends ConsumerWidget {
  final TimeOfDay initialTime;
  final String title;
  final String confirmText;
  final String cancelText;
  final bool barrierDismissible;
  final Color? dialogBackgroundColor;
  final Color? headerHelpTextColor;
  final bool use24HourFormat;
  final TimePickerEntryMode initialEntryMode;

  const SltTimePickerDialog({
    super.key,
    required this.initialTime,
    this.title = 'Select Time',
    this.confirmText = 'OK',
    this.cancelText = 'CANCEL',
    this.barrierDismissible = true,
    this.dialogBackgroundColor,
    this.headerHelpTextColor,
    this.use24HourFormat = false,
    this.initialEntryMode = TimePickerEntryMode.dial,
  });

  factory SltTimePickerDialog._create({
    required TimeOfDay initialTime,
    String title = 'Select Time',
    String confirmText = 'OK',
    String cancelText = 'CANCEL',
    bool barrierDismissible = true,
    Color? dialogBackgroundColor,
    Color? headerHelpTextColor,
    bool use24HourFormat = false,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  }) {
    return SltTimePickerDialog(
      initialTime: initialTime,
      title: title,
      confirmText: confirmText,
      cancelText: cancelText,
      barrierDismissible: barrierDismissible,
      dialogBackgroundColor: dialogBackgroundColor,
      headerHelpTextColor: headerHelpTextColor,
      use24HourFormat: use24HourFormat,
      initialEntryMode: initialEntryMode,
    );
  }

  factory SltTimePickerDialog.pickTime({
    required TimeOfDay initialTime,
    String title = 'Select Time',
    bool use24HourFormat = false,
  }) {
    return SltTimePickerDialog._create(
      initialTime: initialTime,
      title: title,
      use24HourFormat: use24HourFormat,
    );
  }

  factory SltTimePickerDialog.pickReminderTime({
    TimeOfDay? initialTime,
    String title = 'Set Reminder Time',
  }) {
    return SltTimePickerDialog._create(
      initialTime: initialTime ?? const TimeOfDay(hour: 9, minute: 0),
      title: title,
      initialEntryMode: TimePickerEntryMode.input,
    );
  }

  factory SltTimePickerDialog.pick24HourTime({
    required TimeOfDay initialTime,
    String title = 'Select Time (24h)',
  }) {
    return SltTimePickerDialog._create(
      initialTime: initialTime,
      title: title,
      use24HourFormat: true,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget timePickerDialogWidget = TimePickerDialog(
      initialTime: initialTime,
      initialEntryMode: initialEntryMode,
      helpText: title.toUpperCase(),
      confirmText: confirmText,
      cancelText: cancelText,
    );

    if (use24HourFormat) {
      timePickerDialogWidget = MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: timePickerDialogWidget,
      );
    }
    return timePickerDialogWidget;
  }

  static Future<TimeOfDay?> show(
    BuildContext context,
    WidgetRef ref, {
    required TimeOfDay initialTime,
    String title = 'Select Time',
    String confirmText = 'OK',
    String cancelText = 'CANCEL',
    bool barrierDismissible = true,
    Color? dialogBackgroundColor, // Custom background for the dialog
    Color? headerHelpTextColor, // Custom color for help text
    bool use24HourFormat = false,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
  }) async {
    ref.read(selectedTimeProvider.notifier).setTime(initialTime);

    final result = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: initialEntryMode,
      helpText: title.toUpperCase(),
      confirmText: confirmText,
      cancelText: cancelText,
      barrierDismissible: barrierDismissible,
      builder: (context, child) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        return Theme(
          data: theme.copyWith(
            colorScheme: colorScheme.copyWith(
              primary: colorScheme.primary,
              onPrimary: colorScheme.onPrimary,
              surface:
                  dialogBackgroundColor ??
                  colorScheme.surfaceContainerHigh, // Affects dialog background
              onSurface: colorScheme.onSurface,
            ),
            timePickerTheme: TimePickerThemeData(
              backgroundColor:
                  dialogBackgroundColor ?? colorScheme.surfaceContainerHigh,
              hourMinuteTextColor: colorScheme.onSurface,
              hourMinuteColor: colorScheme.surfaceContainerHighest,
              dayPeriodTextColor: colorScheme.onSurfaceVariant,
              dayPeriodColor: colorScheme.surfaceContainerHighest,
              dialHandColor: colorScheme.primary,
              dialBackgroundColor: colorScheme.surfaceContainer,
              dialTextColor: colorScheme.onSurfaceVariant,
              entryModeIconColor: colorScheme.onSurfaceVariant,
              helpTextStyle: theme.textTheme.labelLarge?.copyWith(
                color: headerHelpTextColor ?? colorScheme.onSurfaceVariant,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusL),
              ),
              elevation: AppDimens.elevationM,
              cancelButtonStyle: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                textStyle: theme.textTheme.labelLarge,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingM,
                  vertical: AppDimens.paddingS,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusCircular),
                ),
              ),
              confirmButtonStyle: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                textStyle: theme.textTheme.labelLarge,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingL,
                  vertical: AppDimens.paddingS,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusCircular),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusS),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusS),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingM,
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.primary,
                textStyle: theme.textTheme.labelLarge,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.paddingM,
                  vertical: AppDimens.paddingS,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimens.radiusCircular),
                ),
              ),
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimens.radiusL),
              ),
              backgroundColor:
                  dialogBackgroundColor ?? colorScheme.surfaceContainerHigh,
              elevation: AppDimens.elevationM,
            ),
          ),
          child: use24HourFormat
              ? MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(alwaysUse24HourFormat: true),
                  child: child!,
                )
              : child!,
        );
      },
    );

    if (result != null) {
      ref.read(selectedTimeProvider.notifier).setTime(result);
    }
    return result;
  }
}

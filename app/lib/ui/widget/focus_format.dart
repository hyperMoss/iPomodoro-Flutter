import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/focus_session.dart';

String focusDuration(BuildContext context, Duration duration) {
  final strings = S.of(context);
  if (duration > Duration.zero && duration.inMinutes == 0) {
    return '00:${duration.inSeconds.toString().padLeft(2, '0')}';
  }
  final minutes = duration.inMinutes % 60;
  return duration.inHours > 0
      ? '${duration.inHours}${strings.hours} $minutes${strings.minutes}'
      : '$minutes${strings.minutes}';
}

String focusTime(BuildContext context, DateTime time) =>
    MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(time),
      alwaysUse24HourFormat: true,
    );

String focusSourceLabel(BuildContext context, FocusSource source) {
  final strings = S.of(context);
  return switch (source) {
    FocusSource.pomodoro => strings.pomodoro,
    FocusSource.countdown => strings.timer_countdown_mode,
    FocusSource.countUp => strings.timer_count_up_mode,
    FocusSource.manual => strings.focus_manual,
  };
}

Color focusSourceColor(FocusSource source) => switch (source) {
      FocusSource.pomodoro => AppColors.PRIMARY_MAIN_COLOR,
      FocusSource.countdown => AppColors.TIMER_MAIN_COLOR,
      FocusSource.countUp => const Color(0xFF227D69),
      FocusSource.manual => const Color(0xFF8975AA),
    };

IconData focusSourceIcon(FocusSource source) => switch (source) {
      FocusSource.pomodoro => Icons.alarm_on_outlined,
      FocusSource.countdown => Icons.hourglass_bottom,
      FocusSource.countUp => Icons.timer_outlined,
      FocusSource.manual => Icons.edit_calendar_outlined,
    };

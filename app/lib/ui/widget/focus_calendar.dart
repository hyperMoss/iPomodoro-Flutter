import 'package:flutter/material.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/ui/widget/focus_format.dart';

class FocusCalendar extends StatelessWidget {
  const FocusCalendar(
      {super.key,
      required this.selected,
      required this.today,
      required this.daily,
      required this.onSelect});
  final DateTime selected;
  final DateTime today;
  final Map<DateTime, Duration> daily;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final colors = Theme.of(context).colorScheme;
    final first = DateTime(selected.year, selected.month);
    final days = DateTime(selected.year, selected.month + 1, 0).day;
    final offset = first.weekday - 1;
    final count = ((offset + days) / 7).ceil() * 7;
    return Column(children: [
      Row(children: [
        IconButton(
            tooltip: S.of(context).focus_previous,
            onPressed: () =>
                onSelect(DateTime(selected.year, selected.month - 1)),
            icon: const Icon(Icons.chevron_left)),
        Expanded(
            child: TextButton(
          onPressed: () async {
            final day = await showDatePicker(
                context: context,
                initialDate: selected,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100, 12, 31));
            if (day != null) onSelect(day);
          },
          child: Text(localizations.formatMonthYear(selected),
              style: TextStyle(
                  color: colors.onSurface, fontWeight: FontWeight.w600)),
        )),
        IconButton(
            tooltip: S.of(context).focus_next,
            onPressed: () =>
                onSelect(DateTime(selected.year, selected.month + 1)),
            icon: const Icon(Icons.chevron_right)),
      ]),
      Row(
          children: List.generate(
              7,
              (index) => Expanded(
                      child: Center(
                    child: Text(localizations.narrowWeekdays[(index + 1) % 7],
                        style: TextStyle(
                            color: colors.onSurfaceVariant, fontSize: 12)),
                  )))),
      const SizedBox(height: 8),
      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: count,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, mainAxisExtent: 48),
        itemBuilder: (context, index) {
          final number = index - offset + 1;
          if (number < 1 || number > days) return const SizedBox.shrink();
          final day = DateTime(selected.year, selected.month, number);
          final time = daily[day] ?? Duration.zero;
          final active = day == focusDay(selected);
          final isToday = day == focusDay(today);
          return Padding(
              padding: const EdgeInsets.all(2),
              child: Semantics(
                selected: active,
                label:
                    '${localizations.formatFullDate(day)}, ${focusDuration(context, time)}',
                child: Tooltip(
                    message: focusDuration(context, time),
                    child: InkWell(
                      key: ValueKey('calendar-${day.toIso8601String()}'),
                      onTap: () => onSelect(day),
                      borderRadius: BorderRadius.circular(14),
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: active ? colors.primary : null,
                            borderRadius: BorderRadius.circular(14),
                            border: isToday && !active
                                ? Border.all(color: colors.primary)
                                : null,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text('$number',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: active
                                                ? colors.onPrimary
                                                : colors.onSurface))),
                                const SizedBox(height: 3),
                                Container(
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: time > Duration.zero
                                          ? (active
                                              ? colors.onPrimary
                                              : colors.primary)
                                          : Colors.transparent,
                                    )),
                              ])),
                    )),
              ));
        },
      ),
    ]);
  }
}

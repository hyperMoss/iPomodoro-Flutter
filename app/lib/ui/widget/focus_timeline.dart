import 'package:flutter/material.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/ui/widget/focus_format.dart';

class FocusTimeline extends StatelessWidget {
  const FocusTimeline(
      {super.key,
      required this.date,
      required this.sessions,
      required this.onEdit,
      required this.onAdd});
  final DateTime date;
  final List<FocusSession> sessions;
  final ValueChanged<FocusSession> onEdit;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = Theme.of(context).colorScheme;
    final from = focusDay(date);
    final to = DateTime(date.year, date.month, date.day + 1);
    final records = sessions
        .where((session) => session.within(from, to) > Duration.zero)
        .toList()
      ..sort((a, b) => a.startedAt.compareTo(b.startedAt));
    final duration = records.fold(
        Duration.zero, (total, session) => total + session.within(from, to));
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(
            child: Text(
                MaterialLocalizations.of(context).formatMediumDate(date),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold))),
        IconButton(
            onPressed: onAdd,
            tooltip: strings.focus_add,
            icon: const Icon(Icons.add_circle_outline)),
      ]),
      Text(
          '${strings.focus_sessions} ${records.length} · ${focusDuration(context, duration)}',
          style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12)),
      const SizedBox(height: 24),
      if (records.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28),
          child: Column(children: [
            Icon(Icons.spa_outlined, size: 40, color: colors.outline),
            const SizedBox(height: 16),
            Text(strings.focus_empty, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(strings.focus_empty_hint,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12)),
            const SizedBox(height: 16),
            OutlinedButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: Text(strings.focus_add)),
          ]),
        ),
      for (final session in records) _tile(context, session, from, to),
    ]);
  }

  Widget _tile(
      BuildContext context, FocusSession session, DateTime from, DateTime to) {
    final strings = S.of(context);
    final colors = Theme.of(context).colorScheme;
    final color = focusSourceColor(session.source);
    final start = session.startedAt.isBefore(from) ? from : session.startedAt;
    final end = session.endedAt.isAfter(to) ? to : session.endedAt;
    final duration = session.within(from, to);
    final pause = end.difference(start) - duration;
    return Stack(children: [
      Positioned(
          left: 5,
          top: 9,
          bottom: 0,
          child: Container(width: 1, color: colors.outlineVariant)),
      Positioned(
          left: 0,
          top: 5,
          child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.surface,
                  border: Border.all(color: color, width: 2)))),
      Padding(
          padding: const EdgeInsets.only(left: 26, bottom: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12,
                runSpacing: 6,
                children: [
                  Text(
                      '${focusTime(context, start)} — ${focusTime(context, end)}',
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                      '${focusDuration(context, duration)}${pause.inSeconds > 0 ? ' · ${strings.focus_pause} ${focusDuration(context, pause)}' : ''}',
                      style: TextStyle(
                          fontSize: 11, color: colors.onSurfaceVariant)),
                ]),
            const SizedBox(height: 10),
            Material(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                key: ValueKey('session-${session.id}'),
                onTap: () => onEdit(session),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(focusSourceIcon(session.source),
                                color: color, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(
                                    session.title.isEmpty
                                        ? focusSourceLabel(
                                            context, session.source)
                                        : session.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600))),
                            const SizedBox(width: 8),
                            Icon(Icons.edit_outlined,
                                size: 16, color: colors.onSurfaceVariant),
                          ]),
                          const SizedBox(height: 8),
                          Text(
                              '${focusSourceLabel(context, session.source)} · ${session.outcome == FocusOutcome.completed ? strings.focus_status_completed : strings.focus_abandoned}',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: colors.onSurfaceVariant)),
                          if (session.notes.isNotEmpty)
                            Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(session.notes,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: colors.onSurfaceVariant,
                                        height: 1.5))),
                        ])),
              ),
            ),
          ])),
    ]);
  }
}

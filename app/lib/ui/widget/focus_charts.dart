import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/model/focus_statistics.dart';
import 'package:iPomodoro/ui/widget/focus_format.dart';

class FocusTrendChart extends StatelessWidget {
  const FocusTrendChart(
      {super.key,
      required this.buckets,
      required this.period,
      required this.onSelect});
  final List<FocusBucket> buckets;
  final FocusPeriod period;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final maximum = buckets.fold<int>(
        1, (value, bucket) => math.max(value, bucket.duration.inSeconds));
    final stride = buckets.length > 12 ? 5 : 1;
    String label(FocusBucket bucket) => switch (period) {
          FocusPeriod.day => '${bucket.from.hour}',
          FocusPeriod.year => '${bucket.from.month}',
          FocusPeriod.all => '${bucket.from.year}',
          _ => '${bucket.from.day}',
        };
    return Column(children: [
      SizedBox(
          height: 136,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bucket in buckets)
                Expanded(
                    child: Tooltip(
                  message:
                      '${MaterialLocalizations.of(context).formatMediumDate(bucket.from)} '
                      '${period == FocusPeriod.day ? focusTime(context, bucket.from) : ''}\n'
                      '${focusDuration(context, bucket.duration)}',
                  child: InkWell(
                    key: ValueKey('trend-${bucket.from.toIso8601String()}'),
                    onTap: () => onSelect(bucket.from),
                    child: Semantics(
                      label:
                          '${label(bucket)}: ${focusDuration(context, bucket.duration)}',
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                            height: math.max(
                                4, 136 * bucket.duration.inSeconds / maximum),
                            decoration: BoxDecoration(
                                color: bucket.duration > Duration.zero
                                    ? colors.primary
                                    : colors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(4))),
                      ),
                    ),
                  ),
                ))
            ],
          )),
      const SizedBox(height: 12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        for (var i = 0; i < buckets.length; i++)
          if (i % stride == 0 || i == buckets.length - 1)
            Text(label(buckets[i]),
                style: TextStyle(fontSize: 10, color: colors.onSurfaceVariant)),
      ]),
    ]);
  }
}

class FocusDistribution extends StatelessWidget {
  const FocusDistribution({super.key, required this.summary});
  final FocusSummary summary;

  @override
  Widget build(BuildContext context) {
    final rows = summary.bySource.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Column(children: [
      for (final entry in rows)
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Column(children: [
            Row(children: [
              Icon(focusSourceIcon(entry.key),
                  size: 18, color: focusSourceColor(entry.key)),
              const SizedBox(width: 8),
              Expanded(child: Text(focusSourceLabel(context, entry.key))),
              Text(focusDuration(context, entry.value),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 8),
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: summary.duration.inMicroseconds == 0
                      ? 0
                      : entry.value.inMicroseconds /
                          summary.duration.inMicroseconds,
                  color: focusSourceColor(entry.key),
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  minHeight: 6,
                )),
          ]),
        )
    ]);
  }
}

class FocusHeatmap extends StatefulWidget {
  const FocusHeatmap(
      {super.key,
      required this.year,
      required this.daily,
      required this.onSelect});
  final int year;
  final Map<DateTime, Duration> daily;
  final ValueChanged<DateTime> onSelect;

  @override
  State<FocusHeatmap> createState() => _FocusHeatmapState();
}

class _FocusHeatmapState extends State<FocusHeatmap> {
  ScrollController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final year = widget.year;
    final daily = widget.daily;
    final onSelect = widget.onSelect;
    final colors = Theme.of(context).colorScheme;
    final start = DateTime(year);
    final offset = start.weekday - 1;
    final days = DateTime.utc(year + 1).difference(DateTime.utc(year)).inDays;
    final weeks = ((offset + days) / 7).ceil();
    Color color(Duration duration) {
      if (duration <= Duration.zero) return colors.surfaceContainerHighest;
      final strength = duration.inMinutes < 30
          ? 0.25
          : duration.inMinutes < 60
              ? 0.5
              : duration.inMinutes < 120
                  ? 0.75
                  : 1.0;
      return Color.lerp(
          colors.surfaceContainerHighest, colors.primary, strength)!;
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      LayoutBuilder(builder: (context, constraints) {
        final latest = daily.keys
            .where((date) => date.year == year)
            .fold<DateTime?>(
                null,
                (value, date) =>
                    value == null || date.isAfter(value) ? date : value);
        final week = latest == null
            ? 0
            : (offset +
                    DateTime.utc(year, latest.month, latest.day)
                        .difference(DateTime.utc(year))
                        .inDays) ~/
                7;
        final maximum = math.max(0.0, weeks * 14.0 - constraints.maxWidth);
        _controller ??= ScrollController(
            initialScrollOffset:
                (week * 14.0 - constraints.maxWidth / 2).clamp(0.0, maximum));
        return SingleChildScrollView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                  width: weeks * 14.0,
                  height: 20,
                  child: Stack(children: [
                    for (var month = 1; month <= 12; month++)
                      Positioned(
                          left: ((offset +
                                      DateTime.utc(year, month)
                                          .difference(DateTime.utc(year))
                                          .inDays) ~/
                                  7) *
                              14.0,
                          child: Text('$month',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colors.onSurfaceVariant))),
                  ])),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                    weeks,
                    (week) => Column(
                            children: List.generate(7, (weekday) {
                          final index = week * 7 + weekday - offset;
                          if (index < 0 || index >= days) {
                            return const SizedBox(width: 14, height: 14);
                          }
                          final date = DateTime(year, 1, index + 1);
                          final duration = daily[date] ?? Duration.zero;
                          return Tooltip(
                            message:
                                '${MaterialLocalizations.of(context).formatMediumDate(date)} · ${focusDuration(context, duration)}',
                            child: Semantics(
                              label:
                                  '${MaterialLocalizations.of(context).formatFullDate(date)} ${focusDuration(context, duration)}',
                              child: InkWell(
                                  key: ValueKey(
                                      'heatmap-${date.toIso8601String()}'),
                                  onTap: () => onSelect(date),
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    margin: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        color: color(duration),
                                        borderRadius: BorderRadius.circular(3)),
                                  )),
                            ),
                          );
                        }))),
              ),
            ]));
      }),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(S.of(context).focus_less, style: const TextStyle(fontSize: 11)),
        const SizedBox(width: 6),
        for (final minutes in [0, 15, 45, 90, 120])
          Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                  color: color(Duration(minutes: minutes)),
                  borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 6),
        Text(S.of(context).focus_more, style: const TextStyle(fontSize: 11)),
      ]),
    ]);
  }
}

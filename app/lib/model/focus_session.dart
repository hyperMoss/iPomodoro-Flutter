enum FocusSource { pomodoro, countdown, countUp, manual }

enum FocusOutcome { completed, abandoned }

int _sessionSequence = 0;
String newFocusSessionId(DateTime now) =>
    '${now.microsecondsSinceEpoch}-${_sessionSequence++}';

DateTime focusDay(DateTime date) => DateTime(date.year, date.month, date.day);

class FocusInterval {
  FocusInterval(this.start, this.end) {
    if (end.isBefore(start)) throw ArgumentError('Negative focus interval');
  }

  final DateTime start;
  final DateTime end;
  Duration get duration => end.difference(start);

  Duration within(DateTime from, DateTime to) {
    final a = start.isAfter(from) ? start : from;
    final b = end.isBefore(to) ? end : to;
    return b.isAfter(a) ? b.difference(a) : Duration.zero;
  }

  Map<String, Object> toJson() => {
        'start': start.toUtc().toIso8601String(),
        'end': end.toUtc().toIso8601String(),
      };

  factory FocusInterval.fromJson(Map<String, dynamic> json) => FocusInterval(
        DateTime.parse(json['start'] as String).toLocal(),
        DateTime.parse(json['end'] as String).toLocal(),
      );
}

class FocusSession {
  FocusSession({
    required this.id,
    required this.source,
    required this.outcome,
    required this.startedAt,
    required this.endedAt,
    required List<FocusInterval> intervals,
    this.title = '',
    this.notes = '',
  }) : intervals = List.unmodifiable(intervals) {
    if (id.isEmpty || endedAt.isBefore(startedAt)) {
      throw ArgumentError('Invalid session');
    }
    var previousEnd = startedAt;
    for (final interval in intervals) {
      if (interval.start.isBefore(previousEnd) ||
          interval.end.isAfter(endedAt)) {
        throw ArgumentError(
            'Focus intervals must be ordered within the session');
      }
      previousEnd = interval.end;
    }
  }

  final String id;
  final FocusSource source;
  final FocusOutcome outcome;
  final DateTime startedAt;
  final DateTime endedAt;
  final List<FocusInterval> intervals;
  final String title;
  final String notes;

  Duration get duration => intervals.fold(
      Duration.zero, (total, interval) => total + interval.duration);
  Duration get paused => endedAt.difference(startedAt) - duration;

  Duration within(DateTime from, DateTime to) => intervals.fold(
      Duration.zero, (total, interval) => total + interval.within(from, to));

  FocusSession withDetails(String title, String notes) => FocusSession(
        id: id,
        source: source,
        outcome: outcome,
        startedAt: startedAt,
        endedAt: endedAt,
        intervals: intervals,
        title: title.trim(),
        notes: notes.trim(),
      );

  Map<String, Object> toJson() => {
        'id': id,
        'source': source.name,
        'outcome': outcome.name,
        'startedAt': startedAt.toUtc().toIso8601String(),
        'endedAt': endedAt.toUtc().toIso8601String(),
        'intervals': intervals.map((interval) => interval.toJson()).toList(),
        'title': title,
        'notes': notes,
      };

  factory FocusSession.fromJson(Map<String, dynamic> json) => FocusSession(
        id: json['id'] as String,
        source: FocusSource.values.byName(json['source'] as String),
        outcome: FocusOutcome.values.byName(json['outcome'] as String),
        startedAt: DateTime.parse(json['startedAt'] as String).toLocal(),
        endedAt: DateTime.parse(json['endedAt'] as String).toLocal(),
        intervals: (json['intervals'] as List<dynamic>)
            .map((value) =>
                FocusInterval.fromJson(value as Map<String, dynamic>))
            .toList(),
        title: json['title'] as String? ?? '',
        notes: json['notes'] as String? ?? '',
      );
}

enum FocusPeriod { day, week, month, year, all }

class FocusRange {
  FocusRange(this.from, this.to);
  final DateTime from;
  final DateTime to;

  factory FocusRange.forPeriod(
      FocusPeriod period, DateTime date, Iterable<FocusSession> sessions) {
    final day = focusDay(date);
    return switch (period) {
      FocusPeriod.day =>
        FocusRange(day, DateTime(day.year, day.month, day.day + 1)),
      FocusPeriod.week => FocusRange(
          DateTime(day.year, day.month, day.day - day.weekday + 1),
          DateTime(day.year, day.month, day.day - day.weekday + 8)),
      FocusPeriod.month => FocusRange(
          DateTime(day.year, day.month), DateTime(day.year, day.month + 1)),
      FocusPeriod.year =>
        FocusRange(DateTime(day.year), DateTime(day.year + 1)),
      FocusPeriod.all => FocusRange(
          sessions.fold(
              day,
              (first, item) => item.startedAt.isBefore(first)
                  ? focusDay(item.startedAt)
                  : first),
          sessions.fold(DateTime(day.year, day.month, day.day + 1),
              (last, item) {
            final end = focusDay(item.endedAt);
            return !end.isBefore(last)
                ? DateTime(end.year, end.month, end.day + 1)
                : last;
          })),
    };
  }
}

class FocusSummary {
  FocusSummary(Iterable<FocusSession> sessions, FocusRange range) {
    for (final session in sessions) {
      final time = session.within(range.from, range.to);
      if (time <= Duration.zero) continue;
      duration += time;
      bySource.update(session.source, (value) => value + time,
          ifAbsent: () => time);
      for (var day = focusDay(session.startedAt.isAfter(range.from)
              ? session.startedAt
              : range.from);
          day.isBefore(range.to) && day.isBefore(session.endedAt);
          day = DateTime(day.year, day.month, day.day + 1)) {
        final time =
            session.within(day, DateTime(day.year, day.month, day.day + 1));
        if (time > Duration.zero) {
          daily.update(day, (value) => value + time, ifAbsent: () => time);
        }
      }
      // Count a cross-midnight session once, on its starting day.
      if (!session.startedAt.isBefore(range.from) &&
          session.startedAt.isBefore(range.to)) {
        count++;
        if (session.outcome == FocusOutcome.abandoned) abandoned++;
      }
    }
  }

  Duration duration = Duration.zero;
  int count = 0;
  int abandoned = 0;
  int get completed => count - abandoned;
  final Map<DateTime, Duration> daily = {};
  final Map<FocusSource, Duration> bySource = {};
}

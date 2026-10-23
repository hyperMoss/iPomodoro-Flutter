import 'package:iPomodoro/model/focus_session.dart';

class FocusBucket {
  FocusBucket(this.from, this.to, Iterable<FocusSession> sessions)
      : duration = sessions.fold(Duration.zero,
            (total, session) => total + session.within(from, to));
  final DateTime from;
  final DateTime to;
  final Duration duration;
}

List<FocusBucket> focusBuckets(
    FocusPeriod period, FocusRange range, Iterable<FocusSession> sessions) {
  final buckets = <FocusBucket>[];
  var start = range.from;
  while (start.isBefore(range.to)) {
    final end = switch (period) {
      FocusPeriod.day => start.add(const Duration(hours: 1)),
      FocusPeriod.week ||
      FocusPeriod.month =>
        DateTime(start.year, start.month, start.day + 1),
      FocusPeriod.year => DateTime(start.year, start.month + 1),
      FocusPeriod.all => DateTime(start.year + 1),
    };
    final limit = end.isAfter(range.to) ? range.to : end;
    buckets.add(FocusBucket(start, limit, sessions));
    start = limit;
  }
  return buckets;
}

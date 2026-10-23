import 'package:iPomodoro/model/focus_session.dart';

enum TimerDirection { countdown, countUp }

/// Tracks active study time independently of how often the UI is refreshed.
class StudyTimer {
  StudyTimer({DateTime Function()? now}) : _now = now ?? DateTime.now;

  final DateTime Function() _now;
  Duration _elapsed = Duration.zero;
  DateTime? _startedAt;
  DateTime? _sessionStart;
  DateTime? _lastPause;
  DateTime? _finishedAt;
  String? _sessionId;
  final List<FocusInterval> _intervals = [];

  Duration get elapsed {
    final startedAt = _startedAt;
    final active =
        startedAt == null ? Duration.zero : _now().difference(startedAt);
    return _elapsed + (active.isNegative ? Duration.zero : active);
  }

  void start() {
    if (_startedAt != null) return;
    final now = _now();
    _sessionStart ??= now;
    _sessionId ??= newFocusSessionId(now);
    _startedAt = now;
    _lastPause = null;
    _finishedAt = null;
  }

  void pause() {
    final startedAt = _startedAt;
    if (startedAt == null) return;
    final now = _now();
    final end = now.isBefore(startedAt) ? startedAt : now;
    _intervals.add(FocusInterval(startedAt, end));
    _elapsed += end.difference(startedAt);
    _lastPause = end;
    _startedAt = null;
  }

  FocusSession? finish(FocusSource source, FocusOutcome outcome,
      {Duration? limit}) {
    pause();
    final start = _sessionStart;
    if (start == null || _elapsed.inSeconds == 0) return null;
    final intervals = <FocusInterval>[];
    var remaining = limit ?? _elapsed;
    for (final interval in _intervals) {
      if (remaining <= Duration.zero) break;
      final duration =
          interval.duration < remaining ? interval.duration : remaining;
      intervals
          .add(FocusInterval(interval.start, interval.start.add(duration)));
      remaining -= duration;
    }
    if (intervals.isEmpty) return null;
    _finishedAt ??= _now();
    return FocusSession(
      id: _sessionId!,
      source: source,
      outcome: outcome,
      startedAt: start,
      endedAt: limit != null && _elapsed >= limit
          ? intervals.last.end
          : (_finishedAt!.isBefore(_lastPause!) ? _lastPause! : _finishedAt!),
      intervals: intervals,
    );
  }

  void reset() {
    _elapsed = Duration.zero;
    _startedAt = null;
    _sessionStart = null;
    _sessionId = null;
    _lastPause = null;
    _finishedAt = null;
    _intervals.clear();
  }
}

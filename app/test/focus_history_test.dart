import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:iPomodoro/common/utils/focus_history.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/model/focus_statistics.dart';
import 'package:iPomodoro/model/study_timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

FocusSession sampleSession(String id, DateTime start, Duration duration,
        {FocusSource source = FocusSource.countUp,
        FocusOutcome outcome = FocusOutcome.completed}) =>
    FocusSession(
        id: id,
        source: source,
        outcome: outcome,
        startedAt: start,
        endedAt: start.add(duration),
        intervals: [FocusInterval(start, start.add(duration))]);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('completed session survives a fresh history instance and metadata edits',
      () async {
    final history = FocusHistory();
    final sample = sampleSession(
        'one', DateTime(2026, 10, 23, 9), const Duration(minutes: 25));
    await history.save(sample);
    await history.save(sample.withDetails('Reading', 'Chapter one'));
    final reloaded = FocusHistory();
    await reloaded.load();
    expect(reloaded.sessions, hasLength(1));
    expect(reloaded.sessions.single.title, 'Reading');
    expect(reloaded.sessions.single.notes, 'Chapter one');
    expect(reloaded.sessions.single.duration, const Duration(minutes: 25));
    expect(reloaded.sessions.single.startedAt, sample.startedAt);
    await reloaded.delete('one');
    final afterDelete = FocusHistory();
    await afterDelete.load();
    expect(afterDelete.sessions, isEmpty);
  });

  test('simultaneous writers and loading do not lose sessions', () async {
    final history = FocusHistory();
    await Future.wait([
      history.load(),
      for (var i = 0; i < 20; i++)
        history.save(sampleSession(
            '$i', DateTime(2026, 10, 23, i), const Duration(minutes: 1))),
    ]);
    final reloaded = FocusHistory();
    await reloaded.load();
    expect(reloaded.sessions, hasLength(20));
    expect(
        reloaded.sessions.map((session) => session.id).toSet(), hasLength(20));
  });

  test('failed write preserves saved data and a later retry succeeds once',
      () async {
    final prefs = await SharedPreferences.getInstance();
    var failing = false;
    final history = FocusHistory(preferences: () async {
      if (failing) throw StateError('Disk unavailable');
      return prefs;
    });
    final first = sampleSession(
        'one', DateTime(2026, 10, 23), const Duration(minutes: 1));
    final second = sampleSession(
        'two', DateTime(2026, 10, 23, 1), const Duration(minutes: 2));
    await history.save(first);
    failing = true;
    await expectLater(history.save(second), throwsStateError);
    expect(history.sessions.map((session) => session.id), ['one']);
    final reloaded = FocusHistory();
    await reloaded.load();
    expect(reloaded.sessions, hasLength(1));
    failing = false;
    await history.save(second);
    await history.save(second);
    expect(history.sessions, hasLength(2));
  });

  test('invalid persisted data is preserved instead of being replaced',
      () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(FocusHistory.storageKey, 'broken-json');
    final history = FocusHistory();
    await expectLater(history.load(), throwsFormatException);
    await expectLater(
        history.save(
            sampleSession('x', DateTime(2026), const Duration(minutes: 1))),
        throwsFormatException);
    expect(prefs.getString(FocusHistory.storageKey), 'broken-json');
  });

  test(
      'active intervals exclude pauses and split across midnight without double counting',
      () {
    var now = DateTime(2026, 10, 23, 23, 50);
    final timer = StudyTimer(now: () => now);
    timer.start();
    now = DateTime(2026, 10, 24, 0, 10);
    timer.pause();
    now = DateTime(2026, 10, 24, 0, 30);
    timer.start();
    now = DateTime(2026, 10, 24, 0, 40);
    final session = timer.finish(FocusSource.countUp, FocusOutcome.completed)!;
    expect(session.duration, const Duration(minutes: 30));
    expect(session.paused, const Duration(minutes: 20));
    final first = FocusSummary(
        [session],
        FocusRange.forPeriod(
            FocusPeriod.day, DateTime(2026, 10, 23), [session]));
    final second = FocusSummary(
        [session],
        FocusRange.forPeriod(
            FocusPeriod.day, DateTime(2026, 10, 24), [session]));
    expect(first.duration, const Duration(minutes: 10));
    expect(second.duration, const Duration(minutes: 20));
    expect(first.count, 1);
    expect(second.count, 0);
    expect(first.duration + second.duration, session.duration);
  });

  test('delayed countdown callback records only the planned focus time', () {
    var now = DateTime(2026, 10, 23, 9);
    final timer = StudyTimer(now: () => now)..start();
    now = now.add(const Duration(minutes: 30));
    timer.pause();
    now = now.add(const Duration(minutes: 5));
    timer.start();
    now = now.add(const Duration(minutes: 40));
    final session = timer.finish(FocusSource.countdown, FocusOutcome.completed,
        limit: const Duration(minutes: 60))!;
    expect(session.duration, const Duration(minutes: 60));
    expect(session.endedAt, DateTime(2026, 10, 23, 10, 5));
    expect(session.paused, const Duration(minutes: 5));
    final retried = timer.finish(FocusSource.countdown, FocusOutcome.completed,
        limit: const Duration(minutes: 60))!;
    expect(retried.id, session.id);
    expect(retried.endedAt, session.endedAt);
  });

  test(
      'summary, trend and source distribution conserve the same focus duration',
      () {
    final sessions = [
      sampleSession(
          'a', DateTime(2024, 2, 28, 23, 30), const Duration(hours: 1)),
      sampleSession('b', DateTime(2024, 2, 29, 10), const Duration(minutes: 10),
          source: FocusSource.pomodoro, outcome: FocusOutcome.abandoned),
      sampleSession('c', DateTime(2024, 3, 1), const Duration(minutes: 20)),
    ];
    final range =
        FocusRange.forPeriod(FocusPeriod.month, DateTime(2024, 2), sessions);
    final summary = FocusSummary(sessions, range);
    expect(summary.duration, const Duration(minutes: 70));
    expect(summary.daily.length, 2);
    expect(summary.completed, 1);
    expect(summary.abandoned, 1);
    final buckets = focusBuckets(FocusPeriod.month, range, sessions);
    expect(buckets, hasLength(29));
    expect(buckets.fold(Duration.zero, (sum, bucket) => sum + bucket.duration),
        summary.duration);
    expect(summary.daily.values.fold(Duration.zero, (a, b) => a + b),
        summary.duration);
    expect(summary.bySource.values.fold(Duration.zero, (a, b) => a + b),
        summary.duration);
  });

  test(
      'range boundaries cover Monday weeks, year changes and empty all-time data',
      () {
    final week =
        FocusRange.forPeriod(FocusPeriod.week, DateTime(2027, 1, 1), []);
    expect(week.from, DateTime(2026, 12, 28));
    expect(week.to, DateTime(2027, 1, 4));
    final all =
        FocusRange.forPeriod(FocusPeriod.all, DateTime(2026, 10, 23), []);
    expect(FocusSummary([], all).duration, Duration.zero);
    expect(focusBuckets(FocusPeriod.all, all, []), hasLength(1));
  });

  test(
      'session serialization preserves absolute times and rejects overlapping intervals',
      () {
    final session = sampleSession(
        'x', DateTime(2026, 10, 23, 10), const Duration(minutes: 1));
    final json =
        jsonDecode(jsonEncode(session.toJson())) as Map<String, dynamic>;
    final restored = FocusSession.fromJson(json);
    expect(restored.startedAt, session.startedAt);
    expect(restored.duration, session.duration);
    expect(
        () => FocusSession(
                id: 'bad',
                source: FocusSource.manual,
                outcome: FocusOutcome.completed,
                startedAt: DateTime(2026),
                endedAt: DateTime(2026, 1, 1, 2),
                intervals: [
                  FocusInterval(DateTime(2026), DateTime(2026, 1, 1, 1)),
                  FocusInterval(
                      DateTime(2026, 1, 1, 0, 30), DateTime(2026, 1, 1, 2)),
                ]),
        throwsArgumentError);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iPomodoro/common/utils/focus_history.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/ui/page/statistics_page.dart';
import 'package:iPomodoro/ui/widget/focus_session_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FocusHistory history;
  final now = DateTime(2026, 10, 23, 18);

  FocusSession record(String id, int day, int hour, int minutes, String title) {
    final start = DateTime(2026, 10, day, hour);
    final end = start.add(Duration(minutes: minutes));
    return FocusSession(
        id: id,
        source: FocusSource.pomodoro,
        outcome: FocusOutcome.completed,
        startedAt: start,
        endedAt: end,
        intervals: [FocusInterval(start, end)],
        title: title);
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    history = FocusHistory();
    await history.save(record('reading', 23, 9, 25, 'Reading'));
    await history.save(record('coding', 23, 10, 50, 'Coding'));
    await history.save(record('yesterday', 22, 10, 60, 'Yesterday'));
  });

  Future<void> open(WidgetTester tester,
      {Locale locale = const Locale('en'),
      FocusHistory? store,
      bool resize = true}) async {
    if (resize) {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
    }
    await tester.pumpWidget(MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: StatisticsPage(history: store ?? history, now: () => now)));
    await tester.pumpAndSettle();
  }

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> statistics(WidgetTester tester) => tap(
      tester,
      find.descendant(
          of: find.byType(SegmentedButton<bool>),
          matching: find.text('Statistics')));

  testWidgets(
      'calendar selection and month navigation show real daily sessions',
      (tester) async {
    await open(tester);
    expect(find.text('Reading'), findsOneWidget);
    expect(find.text('Yesterday'), findsNothing);
    await tap(
        tester,
        find.byKey(
            ValueKey('calendar-${DateTime(2026, 10, 22).toIso8601String()}')));
    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.text('Reading'), findsNothing);
    await tap(tester, find.byTooltip('Next period'));
    expect(
        find.byKey(
            ValueKey('calendar-${DateTime(2026, 11, 1).toIso8601String()}')),
        findsOneWidget);
    expect(find.text('No focus sessions on this day'), findsOneWidget);
    await tap(tester, find.byTooltip('Today'));
    expect(find.text('Reading'), findsOneWidget);
  });

  testWidgets('statistics switches periods and reflects saved totals',
      (tester) async {
    await open(tester);
    await statistics(tester);
    expect(
        find.descendant(
            of: find.byKey(const ValueKey('focus-metric-Focus time')),
            matching: find.text('2H 15M')),
        findsOneWidget);
    expect(find.text('3'), findsWidgets);
    await tap(tester, find.text('Day'));
    expect(
        find.descendant(
            of: find.byKey(const ValueKey('focus-metric-Focus time')),
            matching: find.text('1H 15M')),
        findsOneWidget);
    await tap(tester, find.text('Year'));
    expect(
        find.descendant(
            of: find.byKey(const ValueKey('focus-metric-Focus time')),
            matching: find.text('2H 15M')),
        findsOneWidget);
    await tap(tester, find.text('All'));
    expect(
        find.descendant(
            of: find.byKey(const ValueKey('focus-metric-Focus time')),
            matching: find.text('2H 15M')),
        findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('trend and heatmap selections open their daily timeline',
      (tester) async {
    await open(tester);
    await statistics(tester);
    await tap(
        tester,
        find.byKey(
            ValueKey('trend-${DateTime(2026, 10, 22).toIso8601String()}')));
    expect(find.text('Yesterday'), findsOneWidget);
    await statistics(tester);
    final vertical = find
        .byWidgetPredicate((widget) =>
            widget is Scrollable && widget.axisDirection == AxisDirection.down)
        .first;
    await tester.scrollUntilVisible(find.text('Year in focus · 2026'), 400,
        scrollable: vertical);
    await tester.pumpAndSettle();
    await tap(
        tester,
        find.byKey(
            ValueKey('heatmap-${DateTime(2026, 10, 23).toIso8601String()}')));
    expect(find.text('Reading'), findsOneWidget);
    expect(find.text('Yesterday'), findsNothing);
  });

  testWidgets('review edits persist and deletion requires confirmation',
      (tester) async {
    await open(tester);
    await tap(tester, find.byKey(const ValueKey('session-reading')));
    await tester.enterText(
        find.byKey(const ValueKey('focus-title')), 'Read chapter 2');
    await tester.enterText(find.byKey(const ValueKey('focus-notes')),
        'Try the exercises tomorrow.');
    await tap(tester, find.text('Save'));
    expect(find.text('Read chapter 2'), findsOneWidget);
    final restored = FocusHistory();
    await restored.load();
    expect(
        restored.sessions
            .firstWhere((session) => session.id == 'reading')
            .notes,
        'Try the exercises tomorrow.');
    await tap(tester, find.byKey(const ValueKey('session-reading')));
    await tap(tester, find.text('Delete session').last);
    await tap(tester, find.text('Cancel'));
    expect(history.sessions, hasLength(3));
    await tap(tester, find.text('Delete session').last);
    await tap(tester, find.text('Delete'));
    expect(history.sessions, hasLength(2));
    expect(find.text('Read chapter 2'), findsNothing);
  });

  testWidgets(
      'manual entry saves a real timed session and updates the timeline',
      (tester) async {
    await open(tester);
    await tap(tester, find.byTooltip('Add session').first);
    await tester.enterText(
        find.byKey(const ValueKey('focus-title')), 'Evening walk');
    await tap(tester, find.text('Save'));
    expect(history.sessions, hasLength(4));
    final session = history.sessions
        .firstWhere((session) => session.title == 'Evening walk');
    expect(session.source, FocusSource.manual);
    expect(session.duration, const Duration(minutes: 25));
    expect(find.text('Evening walk'), findsOneWidget);
  });

  testWidgets('future manual entry is rejected without changing history',
      (tester) async {
    await open(tester);
    await tap(tester, find.byTooltip('Next period'));
    await tap(tester, find.byTooltip('Add session').first);
    await tap(tester, find.text('Save'));
    expect(find.text('End must follow start, and cannot be in the future.'),
        findsOneWidget);
    expect(history.sessions, hasLength(3));
    expect(find.byType(FocusSessionEditor), findsOneWidget);
  });

  testWidgets('loading failure has a working retry and keeps stored data',
      (tester) async {
    var fail = true;
    final store = FocusHistory(preferences: () async {
      if (fail) throw StateError('Unavailable');
      return SharedPreferences.getInstance();
    });
    await open(tester, store: store);
    expect(
        find.text(
            'Could not load history. Your saved data has been preserved.'),
        findsOneWidget);
    fail = false;
    await tap(tester, find.text('Retry'));
    expect(find.text('Reading'), findsOneWidget);
  });

  for (final size in [const Size(320, 568), const Size(844, 390)]) {
    testWidgets('calendar and statistics fit $size with larger text',
        (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await open(tester, resize: false);
      expect(tester.takeException(), isNull);
      await statistics(tester);
      expect(tester.takeException(), isNull);
      await tap(tester, find.text('Week'));
      expect(tester.takeException(), isNull);
    });
  }
}

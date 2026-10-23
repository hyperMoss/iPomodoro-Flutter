import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iPomodoro/common/utils/config_storage.dart';
import 'package:iPomodoro/common/utils/focus_history.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/study_timer.dart';
import 'package:iPomodoro/ui/page/timer_page.dart';
import 'package:iPomodoro/ui/page/pomodoro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  late DateTime now;
  late FocusHistory history;

  setUp(() async {
    now = DateTime(2026, 1, 1);
    history = FocusHistory();
    SharedPreferences.setMockInitialValues({
      AppStorage.K_STRING_TIMER_TICKING_SOUND: 'None',
      AppStorage.K_STRING_TIMER_ALARM_SOUND: 'None',
      AppStorage.K_STRING_TIMER_NOTIFICATION: 1,
    });
    for (final name in [
      'iPomodoro',
      'dexterous.com/flutter/local_notifications'
    ]) {
      binding.defaultBinaryMessenger
          .setMockMethodCallHandler(MethodChannel(name), (_) async => true);
    }
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers'),
      (call) async {
        if (call.method == 'create') {
          final playerId = call.arguments['playerId'];
          binding.defaultBinaryMessenger.setMockMethodCallHandler(
            MethodChannel('xyz.luan/audioplayers/events/$playerId'),
            (_) async => null,
          );
        }
        return null;
      },
    );
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global'),
      (_) async => null,
    );
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('xyz.luan/audioplayers.global/events'),
      (_) async => null,
    );
    FlutterLocalNotificationsPlatform.instance =
        AndroidFlutterLocalNotificationsPlugin();
    await FlutterLocalNotificationsPlugin().initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
      ),
    );
  });

  Future<void> openTimer(
    WidgetTester tester, {
    Locale locale = const Locale('en'),
    Widget? home,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: home ?? TimerPage(now: () => now, history: history),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tap(WidgetTester tester, String label) async {
    await tester.ensureVisible(find.text(label));
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
  }

  testWidgets('count up starts, pauses, resumes, finishes and resets', (
    tester,
  ) async {
    await openTimer(tester);
    await tap(tester, 'Count up');
    expect(find.byIcon(Icons.edit), findsNothing);
    expect(find.text('00'), findsNWidgets(2));
    await tap(tester, 'start');
    now = now.add(const Duration(seconds: 65));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('01'), findsOneWidget);
    expect(find.text('05'), findsOneWidget);
    expect(
      tester
          .widget<SegmentedButton<TimerDirection>>(
            find.byType(SegmentedButton<TimerDirection>),
          )
          .onSelectionChanged,
      isNull,
    );
    await tap(tester, 'pause');
    now = now.add(const Duration(minutes: 10));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('05'), findsOneWidget);
    await tap(tester, 'continue');
    now = now.add(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('07'), findsOneWidget);
    await tap(tester, 'Finish');
    expect(find.text('Study time: 0:01:07'), findsOneWidget);
    expect(history.sessions.single.duration, const Duration(seconds: 67));
    expect(history.sessions.single.source, FocusSource.countUp);
    final restored = FocusHistory();
    await restored.load();
    expect(restored.sessions.single.duration, const Duration(seconds: 67));
    now = now.add(const Duration(minutes: 5));
    await tap(tester, 'Confirm');
    expect(find.text('00'), findsNWidgets(2));
    await tap(tester, 'Countdown');
    expect(find.text('30'), findsOneWidget);
    expect(find.byIcon(Icons.edit), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  testWidgets('countdown still pauses and resumes', (tester) async {
    await openTimer(tester);
    await tap(tester, 'start');
    now = now.add(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('29'), findsOneWidget);
    expect(find.text('59'), findsOneWidget);
    await tap(tester, 'pause');
    await tester.pump(const Duration(seconds: 10));
    expect(find.text('59'), findsOneWidget);
    await tap(tester, 'continue');
    now = now.add(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('58'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  testWidgets('idle page can be disposed without starting a timer', (
    tester,
  ) async {
    await openTimer(tester);
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('resume refreshes elapsed time before the next timer tick',
      (tester) async {
    await openTimer(tester);
    await tap(tester, 'Count up');
    await tap(tester, 'start');
    binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    now = now.add(const Duration(hours: 1, minutes: 2, seconds: 3));
    binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    expect(find.text('02'), findsOneWidget);
    expect(find.text('03'), findsOneWidget);
    await tap(tester, 'pause');
    await tap(tester, 'Finish');
    expect(find.text('Study time: 1:02:03'), findsOneWidget);
    await tap(tester, 'Confirm');
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  testWidgets('countdown completion saves once and trims background overrun',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      AppStorage.K_STRING_TIMER_HOURS: 0,
      AppStorage.K_STRING_TIMER_MINUTES: 1,
      AppStorage.K_STRING_TIMER_TICKING_SOUND: 'None',
      AppStorage.K_STRING_TIMER_ALARM_SOUND: 'None',
    });
    await openTimer(tester);
    await tap(tester, S.current.start_button);
    now = now.add(const Duration(minutes: 2));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(history.sessions, hasLength(1));
    expect(history.sessions.single.source, FocusSource.countdown);
    expect(history.sessions.single.duration, const Duration(minutes: 1));
    expect(history.sessions.single.endedAt, DateTime(2026, 1, 1, 0, 1));
    await tap(tester, S.current.timer_no);
    expect(history.sessions, hasLength(1));
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  testWidgets('save failure keeps the stopped session and retry saves once',
      (tester) async {
    var fail = true;
    final store = FocusHistory(preferences: () async {
      if (fail) throw StateError('Disk unavailable');
      return SharedPreferences.getInstance();
    });
    await openTimer(tester, home: TimerPage(now: () => now, history: store));
    await tap(tester, 'Count up');
    await tap(tester, 'start');
    now = now.add(const Duration(seconds: 42));
    await tester.pump(const Duration(seconds: 1));
    await tap(tester, 'Finish');
    expect(find.text(S.current.focus_save_error), findsOneWidget);
    expect(store.sessions, isEmpty);
    expect(find.text('42'), findsOneWidget);
    fail = false;
    await tap(tester, 'Finish');
    expect(store.sessions.single.duration, const Duration(seconds: 42));
    expect(find.text('Study time: 0:00:42'), findsOneWidget);
    await tap(tester, 'Confirm');
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  testWidgets(
      'cancelling stop resumes focus and confirming saves an abandoned record',
      (tester) async {
    await openTimer(tester);
    await tap(tester, S.current.start_button);
    now = now.add(const Duration(seconds: 10));
    await tester.pump(const Duration(seconds: 1));
    await tap(tester, S.current.give_up_button);
    now = now.add(const Duration(minutes: 10));
    await tap(tester, S.current.pomodoro_no);
    now = now.add(const Duration(seconds: 5));
    await tester.pump(const Duration(seconds: 1));
    await tap(tester, S.current.give_up_button);
    await tap(tester, S.current.pomodoro_yes);
    expect(history.sessions, hasLength(1));
    expect(history.sessions.single.outcome, FocusOutcome.abandoned);
    expect(history.sessions.single.duration, const Duration(seconds: 15));
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  testWidgets(
      'pomodoro records focus, excludes breaks and records the next cycle',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      AppStorage.K_STRING_POMODORO_HOURS: 0,
      AppStorage.K_STRING_POMODORO_MINUTES: 1,
      AppStorage.K_STRING_POMODORO_BREAK_SHORT: 1,
      AppStorage.K_STRING_POMODORO_TICKING_SOUND: 'None',
      AppStorage.K_STRING_POMODORO_ALARM_SOUND: 'None',
      AppStorage.K_STRING_POMODORO_NOTIFICATION: 1,
    });
    await openTimer(tester,
        home: PomodoroPage(now: () => now, history: history, showIntro: false));
    await tap(tester, S.current.start_button);
    now = now.add(const Duration(minutes: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(history.sessions, hasLength(1));
    expect(history.sessions.single.source, FocusSource.pomodoro);
    await tap(tester, S.current.pomodoro_ok);
    now = now.add(const Duration(minutes: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(history.sessions, hasLength(1));
    await tap(tester, S.current.pomodoro_ok);
    now = now.add(const Duration(minutes: 1));
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(history.sessions, hasLength(2));
    expect(
        history.sessions
            .fold(Duration.zero, (sum, session) => sum + session.duration),
        const Duration(minutes: 2));
    await tester.pumpWidget(const SizedBox());
    await tester.pumpAndSettle();
  });

  for (final size in [const Size(320, 568), const Size(844, 390)]) {
    testWidgets('Chinese count up fits $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await openTimer(tester, locale: const Locale('zh'));
      await tap(tester, '正计时');
      expect(
          tester.getSize(find.byType(SingleChildScrollView)).width, size.width);
      await tap(tester, '开始');
      now = now.add(const Duration(hours: 100, minutes: 1, seconds: 2));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('100'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tap(tester, '结束');
      expect(find.text('本次专注时长：100:01:02'), findsOneWidget);
      await tap(tester, '确认');
      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  }
}

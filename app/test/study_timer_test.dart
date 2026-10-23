import 'package:flutter_test/flutter_test.dart';
import 'package:iPomodoro/common/utils/time_utils.dart';
import 'package:iPomodoro/model/study_timer.dart';

void main() {
  late DateTime now;
  late StudyTimer timer;
  setUp(() {
    now = DateTime(2026, 1, 1);
    timer = StudyTimer(now: () => now);
  });

  test('starts at zero and includes time with no UI updates', () {
    expect(timer.elapsed, Duration.zero);
    timer.start();
    now = now.add(const Duration(hours: 2, minutes: 3, seconds: 4));
    expect(timer.elapsed, const Duration(hours: 2, minutes: 3, seconds: 4));
    expect(TimeUtils.calculateDate(timer.elapsed.inSeconds), [2, '03', '04']);
  });

  test('pause excludes idle time and resume keeps fractional seconds', () {
    timer.start();
    now = now.add(const Duration(milliseconds: 1500));
    timer.pause();
    now = now.add(const Duration(hours: 1));
    expect(timer.elapsed, const Duration(milliseconds: 1500));
    timer.pause();
    timer.start();
    now = now.add(const Duration(milliseconds: 500));
    expect(timer.elapsed, const Duration(seconds: 2));
  });

  test('repeated start does not discard active time', () {
    timer.start();
    now = now.add(const Duration(seconds: 5));
    timer.start();
    now = now.add(const Duration(seconds: 5));
    expect(timer.elapsed, const Duration(seconds: 10));
  });

  test('reset stops and clears the previous session', () {
    timer.start();
    now = now.add(const Duration(seconds: 8));
    timer.reset();
    now = now.add(const Duration(minutes: 5));
    expect(timer.elapsed, Duration.zero);
    timer.start();
    now = now.add(const Duration(seconds: 1));
    expect(timer.elapsed, const Duration(seconds: 1));
  });

  test('minute and hour rollovers do not wrap hours', () {
    expect(TimeUtils.calculateDate(59), [0, '00', '59']);
    expect(TimeUtils.calculateDate(60), [0, '01', '00']);
    expect(TimeUtils.calculateDate(3600), [1, '00', '00']);
    expect(TimeUtils.calculateDate(360000), [100, '00', '00']);
  });
}

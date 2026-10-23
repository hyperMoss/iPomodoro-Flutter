import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A single writer for the local history; failed writes keep the last saved state.
class FocusHistory extends ChangeNotifier {
  FocusHistory({Future<SharedPreferences> Function()? preferences})
      : _preferences = preferences ?? SharedPreferences.getInstance;

  static final instance = FocusHistory();
  static const storageKey = 'focus_history_v1';
  final Future<SharedPreferences> Function() _preferences;
  List<FocusSession> _sessions = [];
  Future<void>? _loading;
  Future<void>? _writes;
  bool _loaded = false;

  List<FocusSession> get sessions => List.unmodifiable(_sessions);

  Future<void> load() {
    if (_loaded) return Future.value();
    return _loading ??= _read().whenComplete(() => _loading = null);
  }

  Future<void> _read() async {
    final preferences = await _preferences();
    final value = preferences.getString(storageKey);
    final List<dynamic> records =
        value == null ? [] : jsonDecode(value) as List<dynamic>;
    final sessions = records
        .map((record) => FocusSession.fromJson(record as Map<String, dynamic>))
        .toList();
    _sessions = sessions;
    _loaded = true;
    notifyListeners();
  }

  Future<void> save(FocusSession session) => _change((sessions) {
        final index = sessions.indexWhere((item) => item.id == session.id);
        if (index < 0) {
          sessions.add(session);
        } else {
          sessions[index] = session;
        }
      });

  Future<void> delete(String id) =>
      _change((sessions) => sessions.removeWhere((item) => item.id == id));

  Future<void> _change(void Function(List<FocusSession>) update) {
    Future<void> perform() async {
      await load();
      final next = List<FocusSession>.of(_sessions);
      update(next);
      next.sort((a, b) => b.startedAt.compareTo(a.startedAt));
      final preferences = await _preferences();
      final saved = await preferences.setString(storageKey,
          jsonEncode(next.map((session) => session.toJson()).toList()));
      if (!saved) throw StateError('Focus history was not saved');
      _sessions = next;
      notifyListeners();
    }

    final previous = _writes;
    final write =
        previous == null ? perform() : previous.then((_) => perform());
    final tail =
        write.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    _writes = tail;
    return write.whenComplete(() {
      if (identical(_writes, tail)) _writes = null;
    });
  }
}

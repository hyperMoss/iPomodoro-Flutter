import 'package:flutter/material.dart';
import 'package:iPomodoro/common/utils/focus_history.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/ui/widget/focus_format.dart';

class FocusSessionEditor extends StatefulWidget {
  const FocusSessionEditor(
      {super.key,
      required this.history,
      required this.date,
      required this.now,
      this.session});
  final FocusHistory history;
  final DateTime date;
  final DateTime Function() now;
  final FocusSession? session;

  @override
  State<FocusSessionEditor> createState() => _FocusSessionEditorState();
}

class _FocusSessionEditorState extends State<FocusSessionEditor> {
  late final _title = TextEditingController(text: widget.session?.title ?? '');
  late final _notes = TextEditingController(text: widget.session?.notes ?? '');
  late DateTime _start;
  late DateTime _end;
  bool _busy = false;
  String? _error;
  late final _manualId = 'manual-${newFocusSessionId(widget.now())}';

  @override
  void initState() {
    super.initState();
    final now = widget.now();
    _end = widget.session?.endedAt ??
        (focusDay(widget.date) == focusDay(now)
            ? now
            : DateTime(
                widget.date.year, widget.date.month, widget.date.day, 9, 25));
    _start =
        widget.session?.startedAt ?? _end.subtract(const Duration(minutes: 25));
  }

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pick(bool start) async {
    final initial = start ? _start : _end;
    final today = focusDay(widget.now());
    final day = await showDatePicker(
        context: context,
        initialDate: initial.isAfter(today) ? today : focusDay(initial),
        firstDate: DateTime(2000),
        lastDate: today);
    if (day == null || !mounted) return;
    final time = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(initial));
    if (time == null || !mounted) return;
    final value =
        DateTime(day.year, day.month, day.day, time.hour, time.minute);
    setState(() {
      if (start) {
        _start = value;
      } else {
        _end = value;
      }
      _error = null;
    });
  }

  Future<void> _save() async {
    if (!_end.isAfter(_start) || _end.isAfter(widget.now())) {
      setState(() => _error = S.of(context).focus_invalid_time);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final session = widget.session?.withDetails(_title.text, _notes.text) ??
        FocusSession(
            id: _manualId,
            source: FocusSource.manual,
            outcome: FocusOutcome.completed,
            startedAt: _start,
            endedAt: _end,
            intervals: [FocusInterval(_start, _end)],
            title: _title.text.trim(),
            notes: _notes.text.trim());
    try {
      await widget.history.save(session);
      if (mounted) Navigator.pop(context, session);
    } catch (_) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = S.of(context).focus_save_error;
        });
      }
    }
  }

  Future<void> _delete() async {
    final strings = S.of(context);
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(strings.focus_delete),
              content: Text(strings.focus_delete_confirm),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(strings.tips_cancel)),
                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(strings.tips_delete)),
              ],
            ));
    if (confirmed != true || !mounted) return;
    setState(() => _busy = true);
    try {
      await widget.history.delete(widget.session!.id);
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) {
        setState(() {
          _busy = false;
          _error = strings.focus_save_error;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final localizations = MaterialLocalizations.of(context);
    final existing = widget.session;
    Widget timeTile(String title, DateTime value, bool start) => ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(title),
          subtitle: Text(
              '${localizations.formatMediumDate(value)}  ${focusTime(context, value)}'),
          trailing: existing == null ? const Icon(Icons.chevron_right) : null,
          onTap: existing == null && !_busy ? () => _pick(start) : null,
        );
    return PopScope(
      canPop: !_busy,
      child: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(
            24, 8, 24, MediaQuery.viewInsetsOf(context).bottom + 24),
        child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Text(existing == null ? strings.focus_add : strings.focus_edit,
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              TextField(
                  key: const ValueKey('focus-title'),
                  controller: _title,
                  enabled: !_busy,
                  maxLength: 80,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: strings.focus_title,
                      border: const OutlineInputBorder())),
              const SizedBox(height: 12),
              TextField(
                  key: const ValueKey('focus-notes'),
                  controller: _notes,
                  enabled: !_busy,
                  maxLength: 2000,
                  minLines: 3,
                  maxLines: 6,
                  decoration: InputDecoration(
                      labelText: strings.focus_notes,
                      border: const OutlineInputBorder())),
              timeTile(strings.focus_start, _start, true),
              timeTile(strings.focus_end, _end, false),
              if (existing != null)
                Wrap(spacing: 12, children: [
                  Text(focusSourceLabel(context, existing.source)),
                  Text(
                      '${strings.focus_total_time} ${focusDuration(context, existing.duration)}'),
                  if (existing.paused > Duration.zero)
                    Text(
                        '${strings.focus_pause} ${focusDuration(context, existing.paused)}'),
                ]),
              if (_error != null)
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(_error!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error))),
              const SizedBox(height: 20),
              FilledButton(
                  onPressed: _busy ? null : _save,
                  child: _busy
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(strings.tips_save)),
              if (existing != null)
                TextButton(
                    onPressed: _busy ? null : _delete,
                    child: Text(strings.focus_delete,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error))),
            ])),
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iPomodoro/common/constant/app_colors.dart';
import 'package:iPomodoro/common/utils/focus_history.dart';
import 'package:iPomodoro/generated/l10n.dart';
import 'package:iPomodoro/model/focus_session.dart';
import 'package:iPomodoro/model/focus_statistics.dart';
import 'package:iPomodoro/ui/widget/focus_calendar.dart';
import 'package:iPomodoro/ui/widget/focus_charts.dart';
import 'package:iPomodoro/ui/widget/focus_format.dart';
import 'package:iPomodoro/ui/widget/focus_session_editor.dart';
import 'package:iPomodoro/ui/widget/focus_timeline.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key, this.history, this.now});
  final FocusHistory? history;
  final DateTime Function()? now;

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  FocusHistory get _history => widget.history ?? FocusHistory.instance;
  DateTime _now() => widget.now?.call() ?? DateTime.now();
  late DateTime _date = focusDay(_now());
  bool _statistics = false;
  FocusPeriod _period = FocusPeriod.month;
  bool _loading = true;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _history.addListener(_changed);
    _load();
  }

  void _changed() {
    if (mounted) setState(() {});
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _failed = false;
    });
    try {
      await _history.load();
    } catch (_) {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _history.removeListener(_changed);
    super.dispose();
  }

  Future<void> _edit([FocusSession? session]) async {
    final result = await showModalBottomSheet<FocusSession>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (context) => FocusSessionEditor(
          history: _history, date: _date, now: _now, session: session),
    );
    if (result != null && mounted) {
      setState(() {
        _date = focusDay(result.startedAt);
        _statistics = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(S.of(context).focus_saved)));
    }
  }

  void _select(DateTime date) => setState(() => _date = focusDay(date));

  Widget _strip(Widget child) => LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: child)));

  void _movePeriod(int step) {
    final next = switch (_period) {
      FocusPeriod.day => DateTime(_date.year, _date.month, _date.day + step),
      FocusPeriod.week =>
        DateTime(_date.year, _date.month, _date.day + step * 7),
      FocusPeriod.month => DateTime(_date.year, _date.month + step),
      FocusPeriod.year => DateTime(_date.year + step, _date.month),
      FocusPeriod.all => _date,
    };
    _select(next);
  }

  Widget _card(BuildContext context, Widget child, {String? title}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(22)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (title != null) ...[
            Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
          ],
          child,
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final base = Theme.of(context);
    var scheme = ColorScheme.fromSeed(
        seedColor: AppColors.PRIMARY_MAIN_COLOR,
        brightness: base.brightness,
        primary: AppColors.PRIMARY_MAIN_COLOR);
    if (base.brightness == Brightness.light) {
      scheme = scheme.copyWith(
        surface: Colors.white,
        surfaceContainerLowest: const Color(0xFFF4F4F4),
        surfaceContainerLow: const Color(0xFFF7F7F7),
        surfaceContainerHighest: const Color(0xFFE7E7E7),
      );
    }
    return Theme(
        data: base.copyWith(colorScheme: scheme),
        child: Builder(builder: (context) {
          final colors = Theme.of(context).colorScheme;
          return Scaffold(
            backgroundColor: colors.surfaceContainerLowest,
            appBar: AppBar(
                backgroundColor: colors.surfaceContainerLowest,
                foregroundColor: colors.onSurface,
                surfaceTintColor: Colors.transparent,
                title: Text(strings.focus_statistics,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                actions: [
                  IconButton(
                      onPressed: () => _select(_now()),
                      tooltip: strings.focus_today,
                      icon: const Icon(Icons.today_outlined)),
                  IconButton(
                      onPressed: _loading || _failed ? null : () => _edit(),
                      tooltip: strings.focus_add,
                      icon: const Icon(Icons.add)),
                ]),
            body: _loading
                ? const Center(child: CircularProgressIndicator())
                : _failed
                    ? Center(
                        child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(strings.focus_load_error,
                                      textAlign: TextAlign.center),
                                  const SizedBox(height: 16),
                                  OutlinedButton(
                                      onPressed: _load,
                                      child: Text(strings.focus_retry)),
                                ])))
                    : RefreshIndicator(
                        onRefresh: _load,
                        child: Center(
                            child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 760),
                          child: ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              children: [
                                _strip(SegmentedButton<bool>(
                                  segments: [
                                    ButtonSegment(
                                        value: false,
                                        label: Text(strings.focus_timeline),
                                        icon: const Icon(
                                            Icons.calendar_month_outlined)),
                                    ButtonSegment(
                                        value: true,
                                        label: Text(strings.focus_statistics),
                                        icon: const Icon(Icons.bar_chart)),
                                  ],
                                  selected: {_statistics},
                                  onSelectionChanged: (values) => setState(
                                      () => _statistics = values.single),
                                )),
                                const SizedBox(height: 20),
                                if (!_statistics)
                                  ..._timeline(context)
                                else
                                  ..._overview(context),
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(strings.focus_device_only,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: colors.onSurfaceVariant))),
                              ]),
                        ))),
          );
        }));
  }

  List<Widget> _timeline(BuildContext context) {
    final range =
        FocusRange.forPeriod(FocusPeriod.month, _date, _history.sessions);
    final summary = FocusSummary(_history.sessions, range);
    return [
      _card(
          context,
          FocusCalendar(
              selected: _date,
              today: _now(),
              daily: summary.daily,
              onSelect: _select)),
      _card(
          context,
          FocusTimeline(
              date: _date,
              sessions: _history.sessions,
              onEdit: _edit,
              onAdd: () => _edit())),
    ];
  }

  List<Widget> _overview(BuildContext context) {
    final strings = S.of(context);
    final localizations = MaterialLocalizations.of(context);
    final range = FocusRange.forPeriod(_period, _date, _history.sessions);
    final summary = FocusSummary(_history.sessions, range);
    final periods = [
      strings.focus_day,
      strings.focus_week,
      strings.focus_month,
      strings.focus_year,
      strings.focus_all
    ];
    final rangeLabel = switch (_period) {
      FocusPeriod.day => localizations.formatMediumDate(_date),
      FocusPeriod.week =>
        '${localizations.formatShortDate(range.from)} — ${localizations.formatShortDate(range.to.subtract(const Duration(days: 1)))}',
      FocusPeriod.month => localizations.formatMonthYear(_date),
      FocusPeriod.year => '${_date.year}',
      FocusPeriod.all =>
        '${localizations.formatShortDate(range.from)} — ${localizations.formatShortDate(range.to.subtract(const Duration(days: 1)))}',
    };
    final metrics = [
      (strings.focus_total_time, focusDuration(context, summary.duration)),
      (strings.focus_days, '${summary.daily.length}'),
      (strings.focus_completed, '${summary.completed}'),
      (strings.focus_abandoned, '${summary.abandoned}'),
      (
        strings.focus_average,
        focusDuration(
            context,
            summary.daily.isEmpty
                ? Duration.zero
                : Duration(
                    microseconds: summary.duration.inMicroseconds ~/
                        summary.daily.length))
      ),
      (strings.focus_sessions, '${summary.count}'),
    ];
    final yearSummary = FocusSummary(_history.sessions,
        FocusRange(DateTime(_date.year), DateTime(_date.year + 1)));
    return [
      _strip(SegmentedButton<FocusPeriod>(
          showSelectedIcon: false,
          segments: [
            for (final period in FocusPeriod.values)
              ButtonSegment(value: period, label: Text(periods[period.index]))
          ],
          selected: {_period},
          onSelectionChanged: (values) =>
              setState(() => _period = values.single))),
      Row(children: [
        IconButton(
            onPressed:
                _period == FocusPeriod.all ? null : () => _movePeriod(-1),
            tooltip: strings.focus_previous,
            icon: const Icon(Icons.chevron_left)),
        Expanded(
            child: Text(rangeLabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant))),
        IconButton(
            onPressed: _period == FocusPeriod.all ? null : () => _movePeriod(1),
            tooltip: strings.focus_next,
            icon: const Icon(Icons.chevron_right)),
      ]),
      _card(
          context,
          LayoutBuilder(
              builder: (context, constraints) => Wrap(
                    spacing: 16,
                    runSpacing: 24,
                    children: [
                      for (final metric in metrics)
                        SizedBox(
                            key: ValueKey('focus-metric-${metric.$1}'),
                            width: (constraints.maxWidth - 16) / 2,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(metric.$1,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant)),
                                  const SizedBox(height: 8),
                                  Text(metric.$2,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w700)),
                                ]))
                    ],
                  )),
          title: strings.focus_overview),
      if (summary.duration == Duration.zero)
        _card(context,
            Text(strings.focus_no_statistics, textAlign: TextAlign.center))
      else ...[
        _card(
            context,
            FocusTrendChart(
                buckets: focusBuckets(_period, range, _history.sessions),
                period: _period,
                onSelect: (date) => setState(() {
                      _date = focusDay(date);
                      if (_period == FocusPeriod.year ||
                          _period == FocusPeriod.all) {
                        _period = _period == FocusPeriod.year
                            ? FocusPeriod.month
                            : FocusPeriod.year;
                      } else {
                        _statistics = false;
                      }
                    })),
            title: strings.focus_trend),
        _card(context, FocusDistribution(summary: summary),
            title: strings.focus_distribution),
      ],
      _card(
          context,
          FocusHeatmap(
              key: ValueKey(_date.year),
              year: _date.year,
              daily: yearSummary.daily,
              onSelect: (date) => setState(() {
                    _date = date;
                    _statistics = false;
                  })),
          title: '${strings.focus_heatmap} · ${_date.year}'),
      Text(strings.focus_statistics_note,
          style: TextStyle(
              fontSize: 11,
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurfaceVariant)),
    ];
  }
}

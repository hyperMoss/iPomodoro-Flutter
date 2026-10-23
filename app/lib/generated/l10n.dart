// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `iPomodoro`
  String get iPomodoro {
    return Intl.message(
      'iPomodoro',
      name: 'iPomodoro',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro`
  String get pomodoro {
    return Intl.message(
      'Pomodoro',
      name: 'pomodoro',
      desc: '',
      args: [],
    );
  }

  /// `Countdown`
  String get countdown {
    return Intl.message(
      'Countdown',
      name: 'countdown',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get tasks {
    return Intl.message(
      'Task',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_me {
    return Intl.message(
      'About',
      name: 'about_me',
      desc: '',
      args: [],
    );
  }

  /// `H`
  String get hours {
    return Intl.message(
      'H',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `M`
  String get minutes {
    return Intl.message(
      'M',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `iPomodoro reminder 🍅！`
  String get pomodoro_push_tips {
    return Intl.message(
      'iPomodoro reminder 🍅！',
      name: 'pomodoro_push_tips',
      desc: '',
      args: [],
    );
  }

  /// `🍌 Break time..`
  String get break_time {
    return Intl.message(
      '🍌 Break time..',
      name: 'break_time',
      desc: '',
      args: [],
    );
  }

  /// `🍅 Studing..`
  String get learn_time {
    return Intl.message(
      '🍅 Studing..',
      name: 'learn_time',
      desc: '',
      args: [],
    );
  }

  /// `🍅 Pomodoro learning`
  String get pomodoro_time {
    return Intl.message(
      '🍅 Pomodoro learning',
      name: 'pomodoro_time',
      desc: '',
      args: [],
    );
  }

  /// `give up`
  String get give_up_button {
    return Intl.message(
      'give up',
      name: 'give_up_button',
      desc: '',
      args: [],
    );
  }

  /// `start`
  String get start_button {
    return Intl.message(
      'start',
      name: 'start_button',
      desc: '',
      args: [],
    );
  }

  /// `pause`
  String get pause_button {
    return Intl.message(
      'pause',
      name: 'pause_button',
      desc: '',
      args: [],
    );
  }

  /// `continue`
  String get continue_button {
    return Intl.message(
      'continue',
      name: 'continue_button',
      desc: '',
      args: [],
    );
  }

  /// `Prompt`
  String get tips_text {
    return Intl.message(
      'Prompt',
      name: 'tips_text',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to give up 🍅 Pomodoro time?`
  String get pomodoro_give_up_tips {
    return Intl.message(
      'Are you sure you want to give up 🍅 Pomodoro time?',
      name: 'pomodoro_give_up_tips',
      desc: '',
      args: [],
    );
  }

  /// `No(💪)`
  String get pomodoro_no {
    return Intl.message(
      'No(💪)',
      name: 'pomodoro_no',
      desc: '',
      args: [],
    );
  }

  /// `Yes(😭)`
  String get pomodoro_yes {
    return Intl.message(
      'Yes(😭)',
      name: 'pomodoro_yes',
      desc: '',
      args: [],
    );
  }

  /// `Keep on fighting!`
  String get tips_come_on {
    return Intl.message(
      'Keep on fighting!',
      name: 'tips_come_on',
      desc: '',
      args: [],
    );
  }

  /// `Congratulation`
  String get tips_congratulation {
    return Intl.message(
      'Congratulation',
      name: 'tips_congratulation',
      desc: '',
      args: [],
    );
  }

  /// `Start the {x_pomodoro} 🍅 Pomodoro time!`
  String pomodoro_next_times(Object x_pomodoro) {
    return Intl.message(
      'Start the $x_pomodoro 🍅 Pomodoro time!',
      name: 'pomodoro_next_times',
      desc: '',
      args: [x_pomodoro],
    );
  }

  /// `The {x_pomodoro} Pomodoro clock has been completed, take a break, ☕️ add energy!`
  String pomodoro_next_break(Object x_pomodoro) {
    return Intl.message(
      'The $x_pomodoro Pomodoro clock has been completed, take a break, ☕️ add energy!',
      name: 'pomodoro_next_break',
      desc: '',
      args: [x_pomodoro],
    );
  }

  /// `Well✊`
  String get pomodoro_ok {
    return Intl.message(
      'Well✊',
      name: 'pomodoro_ok',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro settings`
  String get pomodoro_settings {
    return Intl.message(
      'Pomodoro settings',
      name: 'pomodoro_settings',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro duration`
  String get pomodoro_duration {
    return Intl.message(
      'Pomodoro duration',
      name: 'pomodoro_duration',
      desc: '',
      args: [],
    );
  }

  /// `Short break duration`
  String get pomodoro_short_break_duration {
    return Intl.message(
      'Short break duration',
      name: 'pomodoro_short_break_duration',
      desc: '',
      args: [],
    );
  }

  /// `Long break duration`
  String get pomodoro_long_break_duration {
    return Intl.message(
      'Long break duration',
      name: 'pomodoro_long_break_duration',
      desc: '',
      args: [],
    );
  }

  /// `Long break delay`
  String get pomodoro_logn_break_delay {
    return Intl.message(
      'Long break delay',
      name: 'pomodoro_logn_break_delay',
      desc: '',
      args: [],
    );
  }

  /// `{pomodoro_time} minutes`
  String pomodoro_minutes(Object pomodoro_time) {
    return Intl.message(
      '$pomodoro_time minutes',
      name: 'pomodoro_minutes',
      desc: '',
      args: [pomodoro_time],
    );
  }

  /// `{pomodoro_hours} hours {pomodoro_minutes} minutes`
  String pomodoro_hours_minutes(
      Object pomodoro_hours, Object pomodoro_minutes) {
    return Intl.message(
      '$pomodoro_hours hours $pomodoro_minutes minutes',
      name: 'pomodoro_hours_minutes',
      desc: '',
      args: [pomodoro_hours, pomodoro_minutes],
    );
  }

  /// `{pomodoro_times} Pomodoro times`
  String pomodoro_times(Object pomodoro_times) {
    return Intl.message(
      '$pomodoro_times Pomodoro times',
      name: 'pomodoro_times',
      desc: '',
      args: [pomodoro_times],
    );
  }

  /// `Allows background push notifications`
  String get background_push_tips {
    return Intl.message(
      'Allows background push notifications',
      name: 'background_push_tips',
      desc: '',
      args: [],
    );
  }

  /// `Countdown background sound`
  String get play_clock_ticking_sound {
    return Intl.message(
      'Countdown background sound',
      name: 'play_clock_ticking_sound',
      desc: '',
      args: [],
    );
  }

  /// `Countdown end sound`
  String get alarm_sound {
    return Intl.message(
      'Countdown end sound',
      name: 'alarm_sound',
      desc: '',
      args: [],
    );
  }

  /// `On`
  String get switch_on {
    return Intl.message(
      'On',
      name: 'switch_on',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get switch_off {
    return Intl.message(
      'Off',
      name: 'switch_off',
      desc: '',
      args: [],
    );
  }

  /// `Timer reminder⏳！`
  String get timer_push_tips {
    return Intl.message(
      'Timer reminder⏳！',
      name: 'timer_push_tips',
      desc: '',
      args: [],
    );
  }

  /// `Time learning`
  String get timer_learn {
    return Intl.message(
      'Time learning',
      name: 'timer_learn',
      desc: '',
      args: [],
    );
  }

  /// `⏳ Studing..`
  String get timer_learning {
    return Intl.message(
      '⏳ Studing..',
      name: 'timer_learning',
      desc: '',
      args: [],
    );
  }

  /// `⌛ Countdown learning`
  String get timer_learn_tips {
    return Intl.message(
      '⌛ Countdown learning',
      name: 'timer_learn_tips',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to give up ⏳ Countdown time?`
  String get timer_give_up_tips {
    return Intl.message(
      'Are you sure you want to give up ⏳ Countdown time?',
      name: 'timer_give_up_tips',
      desc: '',
      args: [],
    );
  }

  /// `Current ⏳ countdown has been completed! Do you continue the next?`
  String get timer_congratulation_next {
    return Intl.message(
      'Current ⏳ countdown has been completed! Do you continue the next?',
      name: 'timer_congratulation_next',
      desc: '',
      args: [],
    );
  }

  /// `No(😂)`
  String get timer_no {
    return Intl.message(
      'No(😂)',
      name: 'timer_no',
      desc: '',
      args: [],
    );
  }

  /// `Continue(👊)`
  String get timer_continue {
    return Intl.message(
      'Continue(👊)',
      name: 'timer_continue',
      desc: '',
      args: [],
    );
  }

  /// `Countdown settings`
  String get timer_settings {
    return Intl.message(
      'Countdown settings',
      name: 'timer_settings',
      desc: '',
      args: [],
    );
  }

  /// `Countdown duration`
  String get timer_duration {
    return Intl.message(
      'Countdown duration',
      name: 'timer_duration',
      desc: '',
      args: [],
    );
  }

  /// `Timing task`
  String get countdown_tasks {
    return Intl.message(
      'Timing task',
      name: 'countdown_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Add a new task`
  String get countdown_add {
    return Intl.message(
      'Add a new task',
      name: 'countdown_add',
      desc: '',
      args: [],
    );
  }

  /// `No task`
  String get countdown_empty {
    return Intl.message(
      'No task',
      name: 'countdown_empty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm that you want to delete this task of "{title}"?`
  String countdown_delete_tips(Object title) {
    return Intl.message(
      'Confirm that you want to delete this task of "$title"?',
      name: 'countdown_delete_tips',
      desc: '',
      args: [title],
    );
  }

  /// `Timing task settings`
  String get countdown_settings {
    return Intl.message(
      'Timing task settings',
      name: 'countdown_settings',
      desc: '',
      args: [],
    );
  }

  /// `Sort by the list of tasks`
  String get countdown_tasks_sort {
    return Intl.message(
      'Sort by the list of tasks',
      name: 'countdown_tasks_sort',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get tips_no {
    return Intl.message(
      'No',
      name: 'tips_no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get tips_yes {
    return Intl.message(
      'Yes',
      name: 'tips_yes',
      desc: '',
      args: [],
    );
  }

  /// `Modify`
  String get tips_modify {
    return Intl.message(
      'Modify',
      name: 'tips_modify',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get tips_delete {
    return Intl.message(
      'Delete',
      name: 'tips_delete',
      desc: '',
      args: [],
    );
  }

  /// `null`
  String get tips_empty {
    return Intl.message(
      'null',
      name: 'tips_empty',
      desc: '',
      args: [],
    );
  }

  /// `{year}-{month}-{day} {hour}:{minute} {weekday}`
  String date_format(Object year, Object month, Object day, Object hour,
      Object minute, Object weekday) {
    return Intl.message(
      '$year-$month-$day $hour:$minute $weekday',
      name: 'date_format',
      desc: '',
      args: [year, month, day, hour, minute, weekday],
    );
  }

  /// `Asc by add date`
  String get tips_sort_id_asc {
    return Intl.message(
      'Asc by add date',
      name: 'tips_sort_id_asc',
      desc: '',
      args: [],
    );
  }

  /// `Desc order by add date`
  String get tips_sort_id_desc {
    return Intl.message(
      'Desc order by add date',
      name: 'tips_sort_id_desc',
      desc: '',
      args: [],
    );
  }

  /// `Asc by task date`
  String get tips_sort_date_asc {
    return Intl.message(
      'Asc by task date',
      name: 'tips_sort_date_asc',
      desc: '',
      args: [],
    );
  }

  /// `Desc by task date`
  String get tips_sort_date_desc {
    return Intl.message(
      'Desc by task date',
      name: 'tips_sort_date_desc',
      desc: '',
      args: [],
    );
  }

  /// `Asc by date of modify`
  String get tips_sort_modify_asc {
    return Intl.message(
      'Asc by date of modify',
      name: 'tips_sort_modify_asc',
      desc: '',
      args: [],
    );
  }

  /// `Desc by date of modify`
  String get tips_sort_modify_desc {
    return Intl.message(
      'Desc by date of modify',
      name: 'tips_sort_modify_desc',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get tips_unknown {
    return Intl.message(
      'Unknown',
      name: 'tips_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get tips_monday {
    return Intl.message(
      'Monday',
      name: 'tips_monday',
      desc: '',
      args: [],
    );
  }

  /// `Tuesday`
  String get tips_tuesday {
    return Intl.message(
      'Tuesday',
      name: 'tips_tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wednesday`
  String get tips_wednesday {
    return Intl.message(
      'Wednesday',
      name: 'tips_wednesday',
      desc: '',
      args: [],
    );
  }

  /// `Thursday`
  String get tips_thursday {
    return Intl.message(
      'Thursday',
      name: 'tips_thursday',
      desc: '',
      args: [],
    );
  }

  /// `Friday`
  String get tips_friday {
    return Intl.message(
      'Friday',
      name: 'tips_friday',
      desc: '',
      args: [],
    );
  }

  /// `Saturday`
  String get tips_saturday {
    return Intl.message(
      'Saturday',
      name: 'tips_saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sunday`
  String get tips_sunday {
    return Intl.message(
      'Sunday',
      name: 'tips_sunday',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get tips_app_about {
    return Intl.message(
      'About App',
      name: 'tips_app_about',
      desc: '',
      args: [],
    );
  }

  /// `Pomodoro management and study planning, mom no longer has to worry about my study! No more distractions! No more delay! Efficient! Focus! , So that everyone can be more focused when studying, and learn quickly and easily get!\n \n1. Pomodoro learning mode, using the Pomodoro Technique for learning, allowing you to combine work and rest!\n2. Timed learning mode, learn according to the set time, learn as long as you want!\n3. Timed task mode, countdown days, task records, daily learning tasks! Put an end to learning without goals! Satisfy your thirst for learning!`
  String get tips_app_desc {
    return Intl.message(
      'Pomodoro management and study planning, mom no longer has to worry about my study! No more distractions! No more delay! Efficient! Focus! , So that everyone can be more focused when studying, and learn quickly and easily get!\n \n1. Pomodoro learning mode, using the Pomodoro Technique for learning, allowing you to combine work and rest!\n2. Timed learning mode, learn according to the set time, learn as long as you want!\n3. Timed task mode, countdown days, task records, daily learning tasks! Put an end to learning without goals! Satisfy your thirst for learning!',
      name: 'tips_app_desc',
      desc: '',
      args: [],
    );
  }

  /// `Hello, iPomodoro! This is a Pomodoro time management and planning App, no longer distracted! No more delay! Efficient! Focus! A good tool for learning! iOS download: {AppStoreUrl}，Android download：Google Play Store`
  String tips_app_share_textd(Object AppStoreUrl) {
    return Intl.message(
      'Hello, iPomodoro! This is a Pomodoro time management and planning App, no longer distracted! No more delay! Efficient! Focus! A good tool for learning! iOS download: $AppStoreUrl，Android download：Google Play Store',
      name: 'tips_app_share_textd',
      desc: '',
      args: [AppStoreUrl],
    );
  }

  /// `Task`
  String get tips_task {
    return Intl.message(
      'Task',
      name: 'tips_task',
      desc: '',
      args: [],
    );
  }

  /// `Task name`
  String get tips_task_name {
    return Intl.message(
      'Task name',
      name: 'tips_task_name',
      desc: '',
      args: [],
    );
  }

  /// `Task time`
  String get tips_task_time {
    return Intl.message(
      'Task time',
      name: 'tips_task_time',
      desc: '',
      args: [],
    );
  }

  /// `Task tags`
  String get tips_task_tags {
    return Intl.message(
      'Task tags',
      name: 'tips_task_tags',
      desc: '',
      args: [],
    );
  }

  /// `'Task names and time cannot be empty!'`
  String get tips_task_empty {
    return Intl.message(
      '\'Task names and time cannot be empty!\'',
      name: 'tips_task_empty',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get tips_save {
    return Intl.message(
      'Save',
      name: 'tips_save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get tips_cancel {
    return Intl.message(
      'Cancel',
      name: 'tips_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get tips_confirm {
    return Intl.message(
      'Confirm',
      name: 'tips_confirm',
      desc: '',
      args: [],
    );
  }

  /// `To choose time`
  String get tips_select_time {
    return Intl.message(
      'To choose time',
      name: 'tips_select_time',
      desc: '',
      args: [],
    );
  }

  /// `Set brightness`
  String get set_screen_brightness {
    return Intl.message(
      'Set brightness',
      name: 'set_screen_brightness',
      desc: '',
      args: [],
    );
  }

  /// `In order to save power`
  String get set_screen_brightness_desc {
    return Intl.message(
      'In order to save power',
      name: 'set_screen_brightness_desc',
      desc: '',
      args: [],
    );
  }

  /// `In-app review`
  String get set_app_review {
    return Intl.message(
      'In-app review',
      name: 'set_app_review',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to rate {AppName}!`
  String set_app_review_desc(Object AppName) {
    return Intl.message(
      'Welcome to rate $AppName!',
      name: 'set_app_review_desc',
      desc: '',
      args: [AppName],
    );
  }

  /// `Store to review`
  String get set_appstore_review {
    return Intl.message(
      'Store to review',
      name: 'set_appstore_review',
      desc: '',
      args: [],
    );
  }

  /// `Write a review {AppName}`
  String set_appstore_review_desc(Object AppName) {
    return Intl.message(
      'Write a review $AppName',
      name: 'set_appstore_review_desc',
      desc: '',
      args: [AppName],
    );
  }

  /// `Share`
  String get set_share_friend {
    return Intl.message(
      'Share',
      name: 'set_share_friend',
      desc: '',
      args: [],
    );
  }

  /// `Learn with friends around you!`
  String get set_share_friend_desc {
    return Intl.message(
      'Learn with friends around you!',
      name: 'set_share_friend_desc',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get set_feedback {
    return Intl.message(
      'Feedback',
      name: 'set_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Needs or bugs are welcome`
  String get set_feedback_desc {
    return Intl.message(
      'Needs or bugs are welcome',
      name: 'set_feedback_desc',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get set_email_connect {
    return Intl.message(
      'Email',
      name: 'set_email_connect',
      desc: '',
      args: [],
    );
  }

  /// `Any questions, please to us`
  String get set_email_connect_desc {
    return Intl.message(
      'Any questions, please to us',
      name: 'set_email_connect_desc',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get set_privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'set_privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `User Use Service Agreement`
  String get set_privacy_policy_desc {
    return Intl.message(
      'User Use Service Agreement',
      name: 'set_privacy_policy_desc',
      desc: '',
      args: [],
    );
  }

  /// `Open source`
  String get set_open_source {
    return Intl.message(
      'Open source',
      name: 'set_open_source',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to follow`
  String get set_open_source_desc {
    return Intl.message(
      'Welcome to follow',
      name: 'set_open_source_desc',
      desc: '',
      args: [],
    );
  }

  /// `Focus more`
  String get set_focus {
    return Intl.message(
      'Focus more',
      name: 'set_focus',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to author's blog`
  String get set_focus_desc {
    return Intl.message(
      'Welcome to author\'s blog',
      name: 'set_focus_desc',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get set_recommend {
    return Intl.message(
      'More',
      name: 'set_recommend',
      desc: '',
      args: [],
    );
  }

  /// `Developer recommendations`
  String get set_recommend_desc {
    return Intl.message(
      'Developer recommendations',
      name: 'set_recommend_desc',
      desc: '',
      args: [],
    );
  }

  /// `Set Language`
  String get set_localizetion {
    return Intl.message(
      'Set Language',
      name: 'set_localizetion',
      desc: '',
      args: [],
    );
  }

  /// `Change app language`
  String get set_localizetion_desc {
    return Intl.message(
      'Change app language',
      name: 'set_localizetion_desc',
      desc: '',
      args: [],
    );
  }

  /// `You need to agree to the "User Privacy Policy Agreement", click the "Agree" button to agree to continue to use; if you do not agree, please click "Reject" to exit the application.`
  String get privacy_policy_tips {
    return Intl.message(
      'You need to agree to the "User Privacy Policy Agreement", click the "Agree" button to agree to continue to use; if you do not agree, please click "Reject" to exit the application.',
      name: 'privacy_policy_tips',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get privacy_policy_agree {
    return Intl.message(
      'Agree',
      name: 'privacy_policy_agree',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get privacy_policy_reject {
    return Intl.message(
      'Reject',
      name: 'privacy_policy_reject',
      desc: '',
      args: [],
    );
  }

  /// `Page color settings`
  String get theme_style_title {
    return Intl.message(
      'Page color settings',
      name: 'theme_style_title',
      desc: '',
      args: [],
    );
  }

  /// `Select navigation bar color`
  String get theme_style_title_bar_color {
    return Intl.message(
      'Select navigation bar color',
      name: 'theme_style_title_bar_color',
      desc: '',
      args: [],
    );
  }

  /// `Select background color`
  String get theme_style_title_background_color {
    return Intl.message(
      'Select background color',
      name: 'theme_style_title_background_color',
      desc: '',
      args: [],
    );
  }

  /// `Restore to default color`
  String get theme_style_default_color {
    return Intl.message(
      'Restore to default color',
      name: 'theme_style_default_color',
      desc: '',
      args: [],
    );
  }

  /// `Save current changes`
  String get theme_style_save_color {
    return Intl.message(
      'Save current changes',
      name: 'theme_style_save_color',
      desc: '',
      args: [],
    );
  }
  String get timer_tab {
    return Intl.message(
      'Timer',
      name: 'timer_tab',
      args: [],
    );
  }

  String get timer_countdown_mode {
    return Intl.message(
      'Countdown',
      name: 'timer_countdown_mode',
      args: [],
    );
  }

  String get timer_count_up_mode {
    return Intl.message(
      'Count up',
      name: 'timer_count_up_mode',
      args: [],
    );
  }

  String get timer_count_up_tips {
    return Intl.message(
      'Start from zero, finish when you are ready',
      name: 'timer_count_up_tips',
      args: [],
    );
  }

  String get timer_finish {
    return Intl.message(
      'Finish',
      name: 'timer_finish',
      args: [],
    );
  }

  String get timer_session_complete {
    return Intl.message(
      'Session complete',
      name: 'timer_session_complete',
      args: [],
    );
  }

  String timer_session_duration(String duration) {
    return Intl.message(
      'Study time: $duration',
      name: 'timer_session_duration',
      args: [duration],
    );
  }

  String get focus_statistics {
    return Intl.message("Statistics", name: 'focus_statistics', args: []);
  }

  String get focus_timeline {
    return Intl.message("Timeline", name: 'focus_timeline', args: []);
  }

  String get focus_overview {
    return Intl.message("Overview", name: 'focus_overview', args: []);
  }

  String get focus_day {
    return Intl.message("Day", name: 'focus_day', args: []);
  }

  String get focus_week {
    return Intl.message("Week", name: 'focus_week', args: []);
  }

  String get focus_month {
    return Intl.message("Month", name: 'focus_month', args: []);
  }

  String get focus_year {
    return Intl.message("Year", name: 'focus_year', args: []);
  }

  String get focus_all {
    return Intl.message("All", name: 'focus_all', args: []);
  }

  String get focus_today {
    return Intl.message("Today", name: 'focus_today', args: []);
  }

  String get focus_total_time {
    return Intl.message("Focus time", name: 'focus_total_time', args: []);
  }

  String get focus_days {
    return Intl.message("Active days", name: 'focus_days', args: []);
  }

  String get focus_completed {
    return Intl.message("Completed", name: 'focus_completed', args: []);
  }

  String get focus_abandoned {
    return Intl.message("Stopped early", name: 'focus_abandoned', args: []);
  }

  String get focus_sessions {
    return Intl.message("Sessions", name: 'focus_sessions', args: []);
  }

  String get focus_average {
    return Intl.message("Daily average", name: 'focus_average', args: []);
  }

  String get focus_trend {
    return Intl.message("Trend", name: 'focus_trend', args: []);
  }

  String get focus_distribution {
    return Intl.message("By mode", name: 'focus_distribution', args: []);
  }

  String get focus_heatmap {
    return Intl.message("Year in focus", name: 'focus_heatmap', args: []);
  }

  String get focus_less {
    return Intl.message("Less", name: 'focus_less', args: []);
  }

  String get focus_more {
    return Intl.message("More", name: 'focus_more', args: []);
  }

  String get focus_empty {
    return Intl.message("No focus sessions on this day", name: 'focus_empty', args: []);
  }

  String get focus_empty_hint {
    return Intl.message("Finish a timer or add a past session.", name: 'focus_empty_hint', args: []);
  }

  String get focus_no_statistics {
    return Intl.message("Your progress will appear here after your first session.", name: 'focus_no_statistics', args: []);
  }

  String get focus_add {
    return Intl.message("Add session", name: 'focus_add', args: []);
  }

  String get focus_edit {
    return Intl.message("Review session", name: 'focus_edit', args: []);
  }

  String get focus_title {
    return Intl.message("What did you focus on?", name: 'focus_title', args: []);
  }

  String get focus_notes {
    return Intl.message("Notes and reflections", name: 'focus_notes', args: []);
  }

  String get focus_start {
    return Intl.message("Start time", name: 'focus_start', args: []);
  }

  String get focus_end {
    return Intl.message("End time", name: 'focus_end', args: []);
  }

  String get focus_pause {
    return Intl.message("Paused", name: 'focus_pause', args: []);
  }

  String get focus_manual {
    return Intl.message("Manual entry", name: 'focus_manual', args: []);
  }

  String get focus_saved {
    return Intl.message("Saved to your calendar", name: 'focus_saved', args: []);
  }

  String get focus_save_error {
    return Intl.message("Could not save. Your session is kept here; please retry.", name: 'focus_save_error', args: []);
  }

  String get focus_load_error {
    return Intl.message("Could not load history. Your saved data has been preserved.", name: 'focus_load_error', args: []);
  }

  String get focus_retry {
    return Intl.message("Retry", name: 'focus_retry', args: []);
  }

  String get focus_delete {
    return Intl.message("Delete session", name: 'focus_delete', args: []);
  }

  String get focus_delete_confirm {
    return Intl.message("Delete this focus session? This cannot be undone.", name: 'focus_delete_confirm', args: []);
  }

  String get focus_invalid_time {
    return Intl.message("End must follow start, and cannot be in the future.", name: 'focus_invalid_time', args: []);
  }

  String get focus_date {
    return Intl.message("Date", name: 'focus_date', args: []);
  }

  String get focus_previous {
    return Intl.message("Previous period", name: 'focus_previous', args: []);
  }

  String get focus_next {
    return Intl.message("Next period", name: 'focus_next', args: []);
  }

  String get focus_statistics_note {
    return Intl.message("Time includes completed and stopped sessions. Pauses and breaks are excluded. Sessions are counted on their start date. Daily average uses active days.", name: 'focus_statistics_note', args: []);
  }

  String get focus_device_only {
    return Intl.message("Saved on this device", name: 'focus_device_only', args: []);
  }

  String get focus_detail {
    return Intl.message("Session details", name: 'focus_detail', args: []);
  }

  String get focus_save_retry {
    return Intl.message("Retry saving", name: 'focus_save_retry', args: []);
  }

  String get focus_status_completed => Intl.message("Completed", name: "focus_status_completed", args: []);

}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

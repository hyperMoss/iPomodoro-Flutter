// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(title) =>
      "Confirm that you want to delete this task of \"${title}\"?";

  static String m1(year, month, day, hour, minute, weekday) =>
      "${year}-${month}-${day} ${hour}:${minute} ${weekday}";

  static String m2(pomodoro_hours, pomodoro_minutes) =>
      "${pomodoro_hours} hours ${pomodoro_minutes} minutes";

  static String m3(pomodoro_time) => "${pomodoro_time} minutes";

  static String m4(x_pomodoro) =>
      "The ${x_pomodoro} Pomodoro clock has been completed, take a break, ☕️ add energy!";

  static String m5(x_pomodoro) => "Start the ${x_pomodoro} 🍅 Pomodoro time!";

  static String m6(pomodoro_times) => "${pomodoro_times} Pomodoro times";

  static String m7(AppName) => "Welcome to rate ${AppName}!";

  static String m8(AppName) => "Write a review ${AppName}";

  static String m9(AppStoreUrl) =>
      "Hello, iPomodoro! This is a Pomodoro time management and planning App, no longer distracted! No more delay! Efficient! Focus! A good tool for learning! iOS download: ${AppStoreUrl}，Android download：Google Play Store";

  static String m10(duration) => "Study time: ${duration}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "focus_status_completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "focus_statistics": MessageLookupByLibrary.simpleMessage("Statistics"),
        "focus_timeline": MessageLookupByLibrary.simpleMessage("Timeline"),
        "focus_overview": MessageLookupByLibrary.simpleMessage("Overview"),
        "focus_day": MessageLookupByLibrary.simpleMessage("Day"),
        "focus_week": MessageLookupByLibrary.simpleMessage("Week"),
        "focus_month": MessageLookupByLibrary.simpleMessage("Month"),
        "focus_year": MessageLookupByLibrary.simpleMessage("Year"),
        "focus_all": MessageLookupByLibrary.simpleMessage("All"),
        "focus_today": MessageLookupByLibrary.simpleMessage("Today"),
        "focus_total_time": MessageLookupByLibrary.simpleMessage("Focus time"),
        "focus_days": MessageLookupByLibrary.simpleMessage("Active days"),
        "focus_completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "focus_abandoned": MessageLookupByLibrary.simpleMessage("Stopped early"),
        "focus_sessions": MessageLookupByLibrary.simpleMessage("Sessions"),
        "focus_average": MessageLookupByLibrary.simpleMessage("Daily average"),
        "focus_trend": MessageLookupByLibrary.simpleMessage("Trend"),
        "focus_distribution": MessageLookupByLibrary.simpleMessage("By mode"),
        "focus_heatmap": MessageLookupByLibrary.simpleMessage("Year in focus"),
        "focus_less": MessageLookupByLibrary.simpleMessage("Less"),
        "focus_more": MessageLookupByLibrary.simpleMessage("More"),
        "focus_empty": MessageLookupByLibrary.simpleMessage("No focus sessions on this day"),
        "focus_empty_hint": MessageLookupByLibrary.simpleMessage("Finish a timer or add a past session."),
        "focus_no_statistics": MessageLookupByLibrary.simpleMessage("Your progress will appear here after your first session."),
        "focus_add": MessageLookupByLibrary.simpleMessage("Add session"),
        "focus_edit": MessageLookupByLibrary.simpleMessage("Review session"),
        "focus_title": MessageLookupByLibrary.simpleMessage("What did you focus on?"),
        "focus_notes": MessageLookupByLibrary.simpleMessage("Notes and reflections"),
        "focus_start": MessageLookupByLibrary.simpleMessage("Start time"),
        "focus_end": MessageLookupByLibrary.simpleMessage("End time"),
        "focus_pause": MessageLookupByLibrary.simpleMessage("Paused"),
        "focus_manual": MessageLookupByLibrary.simpleMessage("Manual entry"),
        "focus_saved": MessageLookupByLibrary.simpleMessage("Saved to your calendar"),
        "focus_save_error": MessageLookupByLibrary.simpleMessage("Could not save. Your session is kept here; please retry."),
        "focus_load_error": MessageLookupByLibrary.simpleMessage("Could not load history. Your saved data has been preserved."),
        "focus_retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "focus_delete": MessageLookupByLibrary.simpleMessage("Delete session"),
        "focus_delete_confirm": MessageLookupByLibrary.simpleMessage("Delete this focus session? This cannot be undone."),
        "focus_invalid_time": MessageLookupByLibrary.simpleMessage("End must follow start, and cannot be in the future."),
        "focus_date": MessageLookupByLibrary.simpleMessage("Date"),
        "focus_previous": MessageLookupByLibrary.simpleMessage("Previous period"),
        "focus_next": MessageLookupByLibrary.simpleMessage("Next period"),
        "focus_statistics_note": MessageLookupByLibrary.simpleMessage("Time includes completed and stopped sessions. Pauses and breaks are excluded. Sessions are counted on their start date. Daily average uses active days."),
        "focus_device_only": MessageLookupByLibrary.simpleMessage("Saved on this device"),
        "focus_detail": MessageLookupByLibrary.simpleMessage("Session details"),
        "focus_save_retry": MessageLookupByLibrary.simpleMessage("Retry saving"),
        "timer_tab": MessageLookupByLibrary.simpleMessage("Timer"),
        "timer_countdown_mode": MessageLookupByLibrary.simpleMessage("Countdown"),
        "timer_count_up_mode": MessageLookupByLibrary.simpleMessage("Count up"),
        "timer_count_up_tips": MessageLookupByLibrary.simpleMessage("Start from zero, finish when you are ready"),
        "timer_finish": MessageLookupByLibrary.simpleMessage("Finish"),
        "timer_session_complete": MessageLookupByLibrary.simpleMessage("Session complete"),
        "timer_session_duration": m10,
        "about_me": MessageLookupByLibrary.simpleMessage("About"),
        "alarm_sound":
            MessageLookupByLibrary.simpleMessage("Countdown end sound"),
        "background_push_tips": MessageLookupByLibrary.simpleMessage(
            "Allows background push notifications"),
        "break_time": MessageLookupByLibrary.simpleMessage("🍌 Break time.."),
        "continue_button": MessageLookupByLibrary.simpleMessage("continue"),
        "countdown": MessageLookupByLibrary.simpleMessage("Countdown"),
        "countdown_add": MessageLookupByLibrary.simpleMessage("Add a new task"),
        "countdown_delete_tips": m0,
        "countdown_empty": MessageLookupByLibrary.simpleMessage("No task"),
        "countdown_settings":
            MessageLookupByLibrary.simpleMessage("Timing task settings"),
        "countdown_tasks": MessageLookupByLibrary.simpleMessage("Timing task"),
        "countdown_tasks_sort":
            MessageLookupByLibrary.simpleMessage("Sort by the list of tasks"),
        "date_format": m1,
        "days": MessageLookupByLibrary.simpleMessage("Days"),
        "give_up_button": MessageLookupByLibrary.simpleMessage("give up"),
        "hours": MessageLookupByLibrary.simpleMessage("H"),
        "iPomodoro": MessageLookupByLibrary.simpleMessage("iPomodoro"),
        "learn_time": MessageLookupByLibrary.simpleMessage("🍅 Studing.."),
        "minutes": MessageLookupByLibrary.simpleMessage("M"),
        "pause_button": MessageLookupByLibrary.simpleMessage("pause"),
        "play_clock_ticking_sound":
            MessageLookupByLibrary.simpleMessage("Countdown background sound"),
        "pomodoro": MessageLookupByLibrary.simpleMessage("Pomodoro"),
        "pomodoro_duration":
            MessageLookupByLibrary.simpleMessage("Pomodoro duration"),
        "pomodoro_give_up_tips": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to give up 🍅 Pomodoro time?"),
        "pomodoro_hours_minutes": m2,
        "pomodoro_logn_break_delay":
            MessageLookupByLibrary.simpleMessage("Long break delay"),
        "pomodoro_long_break_duration":
            MessageLookupByLibrary.simpleMessage("Long break duration"),
        "pomodoro_minutes": m3,
        "pomodoro_next_break": m4,
        "pomodoro_next_times": m5,
        "pomodoro_no": MessageLookupByLibrary.simpleMessage("No(💪)"),
        "pomodoro_ok": MessageLookupByLibrary.simpleMessage("Well✊"),
        "pomodoro_push_tips":
            MessageLookupByLibrary.simpleMessage("iPomodoro reminder 🍅！"),
        "pomodoro_settings":
            MessageLookupByLibrary.simpleMessage("Pomodoro settings"),
        "pomodoro_short_break_duration":
            MessageLookupByLibrary.simpleMessage("Short break duration"),
        "pomodoro_time":
            MessageLookupByLibrary.simpleMessage("🍅 Pomodoro learning"),
        "pomodoro_times": m6,
        "pomodoro_yes": MessageLookupByLibrary.simpleMessage("Yes(😭)"),
        "privacy_policy_agree": MessageLookupByLibrary.simpleMessage("Agree"),
        "privacy_policy_reject": MessageLookupByLibrary.simpleMessage("Reject"),
        "privacy_policy_tips": MessageLookupByLibrary.simpleMessage(
            "You need to agree to the \"User Privacy Policy Agreement\", click the \"Agree\" button to agree to continue to use; if you do not agree, please click \"Reject\" to exit the application."),
        "set_app_review": MessageLookupByLibrary.simpleMessage("In-app review"),
        "set_app_review_desc": m7,
        "set_appstore_review":
            MessageLookupByLibrary.simpleMessage("Store to review"),
        "set_appstore_review_desc": m8,
        "set_email_connect": MessageLookupByLibrary.simpleMessage("Email"),
        "set_email_connect_desc":
            MessageLookupByLibrary.simpleMessage("Any questions, please to us"),
        "set_feedback": MessageLookupByLibrary.simpleMessage("Feedback"),
        "set_feedback_desc":
            MessageLookupByLibrary.simpleMessage("Needs or bugs are welcome"),
        "set_focus": MessageLookupByLibrary.simpleMessage("Focus more"),
        "set_focus_desc":
            MessageLookupByLibrary.simpleMessage("Welcome to author\'s blog"),
        "set_localizetion":
            MessageLookupByLibrary.simpleMessage("Set Language"),
        "set_localizetion_desc":
            MessageLookupByLibrary.simpleMessage("Change app language"),
        "set_open_source": MessageLookupByLibrary.simpleMessage("Open source"),
        "set_open_source_desc":
            MessageLookupByLibrary.simpleMessage("Welcome to follow"),
        "set_privacy_policy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "set_privacy_policy_desc":
            MessageLookupByLibrary.simpleMessage("User Use Service Agreement"),
        "set_recommend": MessageLookupByLibrary.simpleMessage("More"),
        "set_recommend_desc":
            MessageLookupByLibrary.simpleMessage("Developer recommendations"),
        "set_screen_brightness":
            MessageLookupByLibrary.simpleMessage("Set brightness"),
        "set_screen_brightness_desc":
            MessageLookupByLibrary.simpleMessage("In order to save power"),
        "set_share_friend": MessageLookupByLibrary.simpleMessage("Share"),
        "set_share_friend_desc": MessageLookupByLibrary.simpleMessage(
            "Learn with friends around you!"),
        "start_button": MessageLookupByLibrary.simpleMessage("start"),
        "switch_off": MessageLookupByLibrary.simpleMessage("Off"),
        "switch_on": MessageLookupByLibrary.simpleMessage("On"),
        "tasks": MessageLookupByLibrary.simpleMessage("Task"),
        "theme_style_default_color":
            MessageLookupByLibrary.simpleMessage("Restore to default color"),
        "theme_style_save_color":
            MessageLookupByLibrary.simpleMessage("Save current changes"),
        "theme_style_title":
            MessageLookupByLibrary.simpleMessage("Page color settings"),
        "theme_style_title_background_color":
            MessageLookupByLibrary.simpleMessage("Select background color"),
        "theme_style_title_bar_color":
            MessageLookupByLibrary.simpleMessage("Select navigation bar color"),
        "timer_congratulation_next": MessageLookupByLibrary.simpleMessage(
            "Current ⏳ countdown has been completed! Do you continue the next?"),
        "timer_continue": MessageLookupByLibrary.simpleMessage("Continue(👊)"),
        "timer_duration":
            MessageLookupByLibrary.simpleMessage("Countdown duration"),
        "timer_give_up_tips": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to give up ⏳ Countdown time?"),
        "timer_learn": MessageLookupByLibrary.simpleMessage("Time learning"),
        "timer_learn_tips":
            MessageLookupByLibrary.simpleMessage("⌛ Countdown learning"),
        "timer_learning": MessageLookupByLibrary.simpleMessage("⏳ Studing.."),
        "timer_no": MessageLookupByLibrary.simpleMessage("No(😂)"),
        "timer_push_tips":
            MessageLookupByLibrary.simpleMessage("Timer reminder⏳！"),
        "timer_settings":
            MessageLookupByLibrary.simpleMessage("Countdown settings"),
        "tips_app_about": MessageLookupByLibrary.simpleMessage("About App"),
        "tips_app_desc": MessageLookupByLibrary.simpleMessage(
            "Pomodoro management and study planning, mom no longer has to worry about my study! No more distractions! No more delay! Efficient! Focus! , So that everyone can be more focused when studying, and learn quickly and easily get!\n \n1. Pomodoro learning mode, using the Pomodoro Technique for learning, allowing you to combine work and rest!\n2. Timed learning mode, learn according to the set time, learn as long as you want!\n3. Timed task mode, countdown days, task records, daily learning tasks! Put an end to learning without goals! Satisfy your thirst for learning!"),
        "tips_app_share_textd": m9,
        "tips_cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "tips_come_on":
            MessageLookupByLibrary.simpleMessage("Keep on fighting!"),
        "tips_confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "tips_congratulation":
            MessageLookupByLibrary.simpleMessage("Congratulation"),
        "tips_delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "tips_empty": MessageLookupByLibrary.simpleMessage("null"),
        "tips_friday": MessageLookupByLibrary.simpleMessage("Friday"),
        "tips_modify": MessageLookupByLibrary.simpleMessage("Modify"),
        "tips_monday": MessageLookupByLibrary.simpleMessage("Monday"),
        "tips_no": MessageLookupByLibrary.simpleMessage("No"),
        "tips_saturday": MessageLookupByLibrary.simpleMessage("Saturday"),
        "tips_save": MessageLookupByLibrary.simpleMessage("Save"),
        "tips_select_time":
            MessageLookupByLibrary.simpleMessage("To choose time"),
        "tips_sort_date_asc":
            MessageLookupByLibrary.simpleMessage("Asc by task date"),
        "tips_sort_date_desc":
            MessageLookupByLibrary.simpleMessage("Desc by task date"),
        "tips_sort_id_asc":
            MessageLookupByLibrary.simpleMessage("Asc by add date"),
        "tips_sort_id_desc":
            MessageLookupByLibrary.simpleMessage("Desc order by add date"),
        "tips_sort_modify_asc":
            MessageLookupByLibrary.simpleMessage("Asc by date of modify"),
        "tips_sort_modify_desc":
            MessageLookupByLibrary.simpleMessage("Desc by date of modify"),
        "tips_sunday": MessageLookupByLibrary.simpleMessage("Sunday"),
        "tips_task": MessageLookupByLibrary.simpleMessage("Task"),
        "tips_task_empty": MessageLookupByLibrary.simpleMessage(
            "\'Task names and time cannot be empty!\'"),
        "tips_task_name": MessageLookupByLibrary.simpleMessage("Task name"),
        "tips_task_tags": MessageLookupByLibrary.simpleMessage("Task tags"),
        "tips_task_time": MessageLookupByLibrary.simpleMessage("Task time"),
        "tips_text": MessageLookupByLibrary.simpleMessage("Prompt"),
        "tips_thursday": MessageLookupByLibrary.simpleMessage("Thursday"),
        "tips_tuesday": MessageLookupByLibrary.simpleMessage("Tuesday"),
        "tips_unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "tips_wednesday": MessageLookupByLibrary.simpleMessage("Wednesday"),
        "tips_yes": MessageLookupByLibrary.simpleMessage("Yes")
      };
}

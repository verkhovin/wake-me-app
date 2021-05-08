import 'dart:io';

import 'package:alarm/backend/alarm_api.dart';
import 'package:alarm/backend/dto/Alarm.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmService {
  static const PREF_ALARMS_IDS_KEY = "applied_alarms_pref";
  static var api = AlarmAPI();

  static Future<void> fetchAndScheduleAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    Set<int> scheduledAlarmsIds = getScheduledAlarmsIds(prefs);

    List<Alarm> nextAlarms = await api.getNextAlarms();
    var remainingAlarms =
        nextAlarms.where((element) => !scheduledAlarmsIds.contains(element.id)).toSet();

    scheduleAlarms(remainingAlarms);

    scheduledAlarmsIds.addAll(remainingAlarms.map((e) => e.id).toList());
    saveScheduledAlarms(prefs, scheduledAlarmsIds);
  }

  static void saveScheduledAlarms(
      SharedPreferences prefs, Set<int> scheduledAlarmsIds) {
    prefs.setStringList(
        PREF_ALARMS_IDS_KEY, scheduledAlarmsIds.map((i) => i.toString()).toList());
  }

  static Set<int>  getScheduledAlarmsIds(SharedPreferences prefs) {
    var ids = prefs.getStringList(PREF_ALARMS_IDS_KEY);
    if (ids == null) {
      return Set<int>();
    }
    return ids.map((s) => int.parse(s)).toSet();
  }

  static void scheduleAlarms(Iterable<Alarm> remainingAlarms) {
    remainingAlarms.forEach((alarm) {
      AndroidAlarmManager.oneShotAt(
          alarm.dateTime, alarm.length, playAlarm, alarmClock: true, allowWhileIdle: true);
    });
  }

  static void playAlarm(int id) {
    FlutterRingtonePlayer.play(
      android: AndroidSounds.alarm,
      ios: IosSounds.alarm,
      looping: false,
      volume: 100,
      asAlarm: true,
    );
    sleep(Duration(seconds: id));
    FlutterRingtonePlayer.stop();
  }
}

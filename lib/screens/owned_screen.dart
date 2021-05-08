import 'dart:async';

import 'package:alarm/backend/alarm_api.dart';
import 'package:alarm/backend/auth_api.dart';
import 'package:alarm/screens/alarms_list_generic_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OwnedScreen extends AlarmsListScreen {
  OwnedScreen({Key key}) : super((alarm) => alarm.destination, "Sent wake ups", AlarmAPI().getOwnedAlarms, true, key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends AlarmsListScreenState {
  @override
  void initState() {
    // AuthAPI().logout();
    final storage = new FlutterSecureStorage();
    storage.containsKey(key: AuthAPI.TOKEN_STORAGE_KEY)
    .then((value) {
      if (value) {
        // AndroidAlarmManager.initialize()
        //     .then((value) => AndroidAlarmManager.periodic(
        //         Duration(minutes: 1),
        //         13,
        //         // Random().nextInt(pow(2, 30).toInt()) + 30,
        //         AlarmService.fetchAndScheduleAlarms,
        //         exact: true));
      } else {
        Navigator.pushReplacementNamed(context, "/register");
      }
    });
    super.initState();
  }
}

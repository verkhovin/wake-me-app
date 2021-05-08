import 'dart:convert';

import 'package:alarm/backend/api.dart';

import 'dto/Alarm.dart';

class AlarmAPI {
  Future<List<Alarm>> getNextAlarms() {
    return _getAlarmsList("/alarms/next");
  }

  Future<List<Alarm>> getOwnedAlarms() {
    return _getAlarmsList("/alarms/owned");
  }

  Future<List<Alarm>> getPassedAlarms() {
    return _getAlarmsList("/alarms/passed");
  }

  Future<void> createAlarm(Alarm alarm) {
    return Api.post("/alarms", body: jsonEncode(alarm));
  }

  Future<List<Alarm>> _getAlarmsList(String url) async {
    var response = await Api.get(url);
    Iterable items = response['items'];
    return items.map((item) => Alarm.fromJson(item)).toList();
  }
}
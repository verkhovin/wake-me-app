import 'package:alarm/backend/alarm_api.dart';
import 'package:alarm/screens/alarms_list_generic_screen.dart';

class PassedAlarmsScreen extends AlarmsListScreen {
  PassedAlarmsScreen() : super((alarm) => alarm.owner, "Received wake ups", AlarmAPI().getPassedAlarms, false);
}

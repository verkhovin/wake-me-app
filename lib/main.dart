import 'package:alarm/screens/create_alarm_screen.dart';
import 'package:alarm/screens/home_screen.dart';
import 'package:alarm/screens/owned_screen.dart';
import 'package:alarm/screens/login_screen.dart';
import 'package:alarm/screens/passed_alarms_screen.dart';
import 'package:alarm/screens/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFFc8b6ff),
        accentColor: Color(0xFFc8b6ff),
        canvasColor: Color(0xfffffbf8),
        cardColor: Color(0xfffffbf8)
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/owned': (context) => OwnedScreen(),
        '/create': (context) => CreateAlarmScreen(),
        '/passed': (context) => PassedAlarmsScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen()
      },
    );
  }
}

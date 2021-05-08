import 'package:alarm/backend/auth_api.dart';
import 'package:alarm/service/alarm_service.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'WAKE ME APP',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff6a72bb),
                              backgroundColor: Colors.white38),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color(0xFFc8b6ff),
                    image: DecorationImage(
                        repeat: ImageRepeat.repeat,
                        image: AssetImage('assets/back.jpg'))),
              ),
              ListTile(
                leading: Icon(Icons.send),
                title: Text('Sent wake ups'),
                onTap: () {
                  Navigator.pushNamed(context, "/owned");
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications_active),
                title: Text('Received wake ups'),
                onTap: () {
                  Navigator.pushNamed(context, "/passed");
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  await AuthAPI().logout();
                  initState();
                },
              )
            ],
          ),
        ),
        body: Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/create");
                  },
                  color: Color(0xFFc8b6ff),
                  textColor: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.alarm,
                        size: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Column(
                          children: [
                            Text('WAKE UP',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold)),
                            Text('SOMEBODY',
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                  padding: EdgeInsets.all(80),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ],
        )));
  }

  @override
  void initState() {
    final storage = new FlutterSecureStorage();
    storage.containsKey(key: AuthAPI.TOKEN_STORAGE_KEY).then((value) {
      if (value) {
        AndroidAlarmManager.initialize()
            .then((value) => AndroidAlarmManager.periodic(
                Duration(minutes: 1),
                13,
                // Random().nextInt(pow(2, 30).toInt()) + 30,
                AlarmService.fetchAndScheduleAlarms,
                exact: true));
      } else {
        Navigator.pushReplacementNamed(context, "/register");
      }
    });
    super.initState();
  }
}

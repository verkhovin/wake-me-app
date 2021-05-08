import 'dart:async';

import 'package:alarm/backend/dto/Alarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AlarmsListScreen extends StatefulWidget {
  final String Function(Alarm) _personFunc;
  final String _title;
  final Future<List<Alarm>> Function() _getList;
  final bool _canAdd;

  AlarmsListScreen(this._personFunc, this._title, this._getList, this._canAdd,
      {Key key})
      : super(key: key);

  @override
  AlarmsListScreenState createState() => AlarmsListScreenState();
}

class AlarmsListScreenState extends State<AlarmsListScreen> {
  Future<List<Alarm>> _alarmsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget._title),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              onPressed: getAlarms,
            ),
          ],
        ),
        body: Container(
            child: FutureBuilder<List<Alarm>>(
                future: _alarmsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var alarm = snapshot.data[index];
                        return Card(
                          elevation: 3,
                          child: ListTile(
                            title: Row(
                              children: [
                                Expanded(
                                    child: Text(widget._personFunc(alarm),
                                        softWrap: true),
                                    flex: 9),
                                Expanded(
                                    child: Text(DateFormat('yyyy-MM-dd – kk:mm')
                                        .format(alarm.dateTime)),
                                    flex: 6),
                                // Expanded(
                                //   child: Text(alarm.length.toString() + "s"),
                                // ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Expanded(
                                    child: Text(alarm.message, softWrap: true),
                                    flex: 9),
                                alarm.dateTime.isAfter(DateTime.now())
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        child: Icon(
                                            Icons.done,
                                            size: 20,
                                            color: Colors.lightGreen,
                                          ),
                                        ),

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return new CircularProgressIndicator();
                })),
        floatingActionButton: widget._canAdd
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create');
                },
                tooltip: 'Add',
                child: Icon(Icons.alarm),
              )
            : null);
  }

  void getAlarms() {
    setState(() {
      _alarmsFuture = widget._getList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAlarms();
  }
}

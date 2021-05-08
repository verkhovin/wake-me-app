import 'package:alarm/backend/alarm_api.dart';
import 'package:alarm/backend/dto/Alarm.dart';
import 'package:alarm/common/exceptions.dart';
import 'package:alarm/common/showsnack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class CreateAlarmScreen extends StatefulWidget {
  @override
  _CreateAlarmScreenState createState() => _CreateAlarmScreenState();
}

class _CreateAlarmScreenState extends State<CreateAlarmScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Set an alarm for somebody"),
          actions: [
            IconButton(
                icon: Icon(Icons.done),
                onPressed: createAlarm)
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  FormBuilderTextField(
                    name: 'destination',
                    decoration: InputDecoration(
                      labelText: 'Username (who we will wake up)',
                    ),
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderDateTimePicker(
                      name: 'dateTime',
                      initialValue: DateTime.now().add(Duration(hours: 3)),
                      decoration: InputDecoration(
                        labelText: 'Where to ring',
                      ),
                    format: DateFormat("yyyy-MM-dd'T'hh:mm:ss"),
                  ),
                  FormBuilderTextField(
                    name: 'length',
                    decoration: InputDecoration(
                      labelText: 'How long to ring? (seconds)',
                    ),
                    // valueTransformer: (text) => num.tryParse(text),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.max(context, 30)
                    ]),
                    keyboardType: TextInputType.number,
                  ),
                  FormBuilderTextField(
                    name: 'message',
                    decoration: InputDecoration(
                      labelText: 'Small message',
                    ),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.maxLength(context, 50)]),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  Future<void> createAlarm() async {
    try {
      _formKey.currentState.save();
      if (_formKey.currentState.validate()) {
        var value = _formKey.currentState.value;
        await AlarmAPI().createAlarm(Alarm(
            0,
            int.parse(value["length"]),
            value["dateTime"],
            value["owner"],
            value["destination"],
            value["message"]));
        Navigator.pop(context);
      }

    } on AppException catch (e) {
      showsnack(context, e.message);
    } on Exception catch (e) {
      showsnack(context, "Something gone wrong :(");
    }
  }
}

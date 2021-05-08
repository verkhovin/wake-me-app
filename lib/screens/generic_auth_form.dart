import 'package:alarm/common/showsnack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GenericAuthForm extends StatefulWidget {
  final String _title;
  final Future<void> Function(String login, String password) _authAction;

  const GenericAuthForm(this._title, this._authAction, {Key key})
      : super(key: key);

  @override
  _GenericAuthFormState createState() => _GenericAuthFormState();
}

class _GenericAuthFormState extends State<GenericAuthForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'username',
                  decoration: InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  // valueTransformer: (text) => num.tryParse(text),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(context),
                  ]),
                ),

              ],
            ),
          ),
          MaterialButton(child: Text(widget._title), onPressed: doAuthAction,)
        ],),
    );
  }

  Future<void> doAuthAction() async {
    try {
      _formKey.currentState.save();
      if (_formKey.currentState.validate()) {
        var value = _formKey.currentState.value;
        await widget._authAction(value["username"], value["password"]);
        Navigator.pushReplacementNamed(context, "/");
      }
    } on Exception catch (e) {
      print(e);
      showsnack(context, "Login error");
    }
  }
}
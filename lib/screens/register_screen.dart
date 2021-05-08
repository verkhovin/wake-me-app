import 'package:alarm/backend/auth_api.dart';
import 'package:alarm/screens/generic_auth_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Sign up")), body: Container(
      child: Column(
        children: [
          GenericAuthForm("Sign up", AuthAPI().register),
          TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/login'), child: Text('Already have an account'))
        ],
      ),
    ));
  }
}

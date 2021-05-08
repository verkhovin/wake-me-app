import 'package:alarm/backend/auth_api.dart';
import 'package:alarm/screens/generic_auth_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Sign in")), body: Container(
      child: Column(
        children: [
          GenericAuthForm("Sign In", AuthAPI().login),
          TextButton(onPressed: () => Navigator.pushReplacementNamed(context, '/register'), child: Text('Sign Up'))
        ],
      ),
    ));
  }
}

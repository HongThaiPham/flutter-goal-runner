import 'package:flutter/material.dart';
import 'package:fluttergoalrunner/src/ui/widgets/sign_in_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Goal Runner"),
          elevation: 0.0,
        ),
        body: Container(
          padding: new EdgeInsets.all(16.0),
          decoration: new BoxDecoration(color: Colors.white),
          alignment: new Alignment(0.0, 0.0),
          child: new SignInForm(),
        ));
  }
}

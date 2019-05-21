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
        body: new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: new AssetImage("assets/images/bg_login.jpg"),
            fit: BoxFit.cover),
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange[600], Colors.orange]),
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.star_border,
                  size: 80,
                  color: Colors.white,
                ),
                new Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: new Text(
                    "Goal Runner",
                    style: new TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.bottomCenter,
                  child: new SignInForm(),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:fluttergoalrunner/src/blocs/login_bloc.dart';
import 'package:fluttergoalrunner/src/blocs/login_bloc_provider.dart';
import 'package:fluttergoalrunner/src/utils/strings.dart';

import '../goals_list.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  LoginBloc _loginBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc = LoginBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
//        emailField(),
//        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
//        passwordField(),
//        Container(margin: EdgeInsets.only(top: 5.0, bottom: 5.0)),
        submitButton()
      ],
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: _loginBloc.password,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return TextField(
          onChanged: _loginBloc.changePassword,
          obscureText: true,
          decoration: new InputDecoration(
              hintText: StringConstant.passwordHint, errorText: snapshot.error),
        );
      },
    );
  }

  Widget emailField() {
    return StreamBuilder(
        stream: _loginBloc.email,
        builder: (context, snapshot) {
          return TextField(
            onChanged: _loginBloc.changeEmail,
            decoration: InputDecoration(
                hintText: StringConstant.emailHint, errorText: snapshot.error),
          );
        });
  }

  Widget submitButton() {
    return StreamBuilder(
        stream: _loginBloc.signInStatus,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
            return button();
          } else {
            return CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation(Colors.white),
            );
          }
        });
  }

  Widget button() {
    return new FlatButton.icon(
      onPressed: () {
        authenticateUser();
      },
      icon: new Icon(Icons.account_circle),
      label: new Text(StringConstant.loginButton),
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      textColor: Colors.white,
      color: Colors.blue,
    );
  }

  void authenticateUser() {
    _loginBloc.showProgressBar(true);
    _loginBloc.login().then((user) {
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => GoalsList(user.uid)));
      }
    });
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text(StringConstant.errorMessage),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'blocs/goals_bloc_provider.dart';
import 'blocs/login_bloc_provider.dart';
import 'ui/login_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: GoalsBlocProvider(
        child: new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Goal Runner",
          theme: new ThemeData(
            accentColor: Colors.white,
            primaryColor: Colors.orange,
          ),
          home: new LoginScreen(),
        ),
      ),
    );
  }
}

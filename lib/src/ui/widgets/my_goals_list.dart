import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttergoalrunner/src/blocs/goals_bloc.dart';
import 'package:fluttergoalrunner/src/blocs/goals_bloc_provider.dart';
import 'package:fluttergoalrunner/src/models/goal.dart';

class MyGoalsListScreen extends StatefulWidget {
  final String _emailAddress;

  MyGoalsListScreen(this._emailAddress);

  @override
  _MyGoalsListScreenState createState() => _MyGoalsListScreenState();
}

class _MyGoalsListScreenState extends State<MyGoalsListScreen> {
  GoalsBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = GoalsBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0.0, 0.0),
      child: StreamBuilder(
          stream: _bloc.myGoalList(widget._emailAddress),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot doc = snapshot.data;
              List<Goal> goalsList = _bloc.mapToList(doc: doc);
              if (goalsList.isNotEmpty) {
                return buildList(goalsList);
              } else {
                return Text("No Goals");
              }
            } else {
              return Text("No Goals");
            }
          }),
    );
  }

//  using the Dismissible widget to remove a goal from my list. Just swipe left and you will get ride off that particular item.

  ListView buildList(List<Goal> goalsList) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: goalsList.length,
        itemBuilder: (context, index) {
          final item = goalsList[index];
          return Dismissible(
              key: Key(item.id.toString()),
              onDismissed: (direction) {
                _bloc.removeGoal(item.title, widget._emailAddress);
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(
                  goalsList[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(goalsList[index].message),
              ));
        });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

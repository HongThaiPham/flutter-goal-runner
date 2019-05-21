import 'package:flutter/material.dart';
import 'package:fluttergoalrunner/src/ui/widgets/my_goals_list.dart';
import 'package:fluttergoalrunner/src/ui/widgets/people_goals_list.dart';
import 'package:fluttergoalrunner/src/utils/strings.dart';

import 'add_goal.dart';

class GoalsList extends StatefulWidget {
  final String _emailAddress;

  GoalsList(this._emailAddress);

  @override
  _GoalsListState createState() => _GoalsListState();
}

class _GoalsListState extends State<GoalsList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          StringConstant.goalListTitle,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0.0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          tabs: <Tab>[
            new Tab(text: StringConstant.worldTab),
            new Tab(text: StringConstant.myTab),
          ],
        ),
      ),
      body: new TabBarView(controller: _tabController, children: <Widget>[
        PeopleGoalsListScreen(),
        MyGoalsListScreen(widget._emailAddress),
      ]),
      floatingActionButton: _bottomButtons(),
    );
  }

  Widget _bottomButtons() {
    if (_tabController.index == 1) {
      return FloatingActionButton(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddGoalScreen(widget._emailAddress)));
          });
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }
}

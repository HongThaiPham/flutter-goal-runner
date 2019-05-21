//As our data layer(resources) is set. It’s time to create the Repository class since it will be the bridge between the BLoC layer and the Data layer

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttergoalrunner/src/resources/firestore_provider.dart';
import 'package:fluttergoalrunner/src/resources/mlkit_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();
  final _mlkitProvider = MLkitProvider();

  Future<int> authenticateuser(String email, String password) =>
      _firestoreProvider.authenticateUser(email, password);

  Future<FirebaseUser> authenticateFirebase() =>
      _firestoreProvider.authenticateFirebase();

  Future<void> registerUser(String email, String password) =>
      _firestoreProvider.registerUser(email, password);

  Future<String> extractText(var image) => _mlkitProvider.getImage(image);

  Future<void> uploadGoal(String email, String title, String goal) =>
      _firestoreProvider.uploadGoal(email, title, goal);

  Stream<DocumentSnapshot> myGoalList(String email) =>
      _firestoreProvider.myGoalList(email);

  Stream<QuerySnapshot> otherGoalList() => _firestoreProvider.othersGoalList();

  void removeGoal(String title, String email) =>
      _firestoreProvider.removeGoal(title, email);
}

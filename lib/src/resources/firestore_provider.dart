import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirestoreProvider {
  Firestore _fireStore = Firestore.instance;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'openid', 'profile'],
  );

  Stream<DocumentSnapshot> myGoalList(String documentId) =>
      _fireStore.collection("users").document(documentId).snapshots();

  Stream<QuerySnapshot> othersGoalList() => _fireStore
      .collection('users')
      .where("goalAdded", isEqualTo: true)
      .snapshots();

  Future<int> authenticateUser(String email, String password) async {
    final QuerySnapshot result = await _fireStore
        .collection("users")
        .where("email", isEqualTo: email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;
    if (docs.length > 0 && docs[0].data["password"] == password) {
      return 1;
    } else {
      return 0;
    }
  }

  Future<FirebaseUser> authenticateFirebase() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        await _firebaseAuth.signInWithCredential(credential);

    final DocumentSnapshot doc =
        await _fireStore.collection("users").document(user.uid).get();

    if (doc.data == null) {
      await _fireStore.collection("users").document(user.uid).setData({
        "email": user.email,
        "photoUrl": user.photoUrl,
        "displayName": user.displayName,
        "goalAdded": false
      });
    }
    return user;
  }

  Future<void> registerUser(String email, String password) async {
    return _fireStore
        .collection("users")
        .document(email)
        .setData({'email': email, 'password': password, 'goalAdded': false});
  }

  Future<void> uploadGoal(String uid, String title, String goal) async {
    DocumentSnapshot doc =
        await _fireStore.collection("users").document(uid).get();
    Map<String, String> goals = doc.data["goals"] != null
        ? doc.data["goals"].cast<String, String>()
        : null;
    if (goals != null) {
      goals[title] = goal;
    } else {
      goals = Map();
      goals[title] = goal;
    }
    return _fireStore
        .collection("users")
        .document(uid)
        .setData({'goals': goals, 'goalAdded': true}, merge: true);
  }

  void removeGoal(String title, String documentId) async {
    DocumentSnapshot doc =
        await _fireStore.collection("users").document(documentId).get();
    Map<String, String> goals = doc.data["goals"].cast<String, String>();
    goals.remove(title);
    if (goals.isNotEmpty) {
      _fireStore
          .collection("users")
          .document(documentId)
          .updateData({"goals": goals});
    } else {
      _fireStore
          .collection("users")
          .document(documentId)
          .updateData({"goals": FieldValue.delete(), "goalAdded": false});
    }
  }
}

import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/client.dart';
import '../models/doula.dart';
import '../states/appState.dart';
import '../actions/waitAction.dart';

class CreateUserAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  CreateUserAction(this.email, this.password)
      : assert(email != null && password != null);

  @override
  Future<AppState> reduce() async {
    print("Attempting to create user with email: $email");

    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    String userId = user.uid;
    print("User created with id: $userId");

    if (userId != null && userId.length > 0) {
      User applicant = new User(userId, email);
      print("new client: ${applicant.toString()}");
      return state.copy(currentUser: applicant);
    }

    print("error: user id returned from firebase: $userId");
    return null;
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class CreateDoulaUserDocument extends ReduxAction<AppState> {
  final Doula user;

  CreateDoulaUserDocument(this.user) : assert(user != null);

  @override
  Future<AppState> reduce() async {
    print(
        "Attempting to add this doula ${user.toString()} to the users collection");

    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(user.userid).setData({
      "userid": user.userid,
      "name": user.name,
      "userType": user.userType,
    });

    // TODO add phones and dates as a json list
    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("specifics")
        .add({
      "phones": user.phones.join(", "),
      "bday": user.bday,
      "email": user.email,
      "bio": user.bio,
      "certified": user.certified,
      "certInProgress": user.certInProgress,
      "certProgram": user.certProgram,
      "birthsNeeded": user.birthsNeeded
    });

    // TODO applicationState, update application state to submitted

    return null;
  }
}

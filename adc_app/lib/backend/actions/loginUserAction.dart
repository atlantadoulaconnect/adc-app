import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../models/admin.dart';
import '../models/client.dart';
import '../models/doula.dart';
import '../states/appState.dart';
import '../actions/waitAction.dart';

class LoginUserAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginUserAction(this.email, this.password)
      : assert(email != null && password != null);

  @override
  Future<AppState> reduce() async {
    print("Attempting to login user with email: $email");

    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;
      String userId = user.uid;

      if (userId.length > 0 && userId != null) {
      } else {
        // invalid user id
        return state.copy(loginError: "Invalid response from database");
      }
    } catch (e) {
      // TODO set login error
      return null;
    }
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class LogoutUserAction extends ReduxAction<AppState> {
  // TODO persist everything to local storage
  LogoutUserAction();

  @override
  Future<AppState> reduce() async {
    print("Attempting to logout user with email: ${state.currentUser.email}");
    try {
      await FirebaseAuth.instance.signOut();
      print("signout success");
      // clearing state object
      return state.copy(currentUser: null, waiting: false);
    } catch (e) {
      print("sign out error $e");
      return null;
    }
  }
}

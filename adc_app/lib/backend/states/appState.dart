import 'dart:math';

import 'package:meta/meta.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class AppState {
  final User currentUser;
  final bool waiting;
  // TODO State object for all the errors

  AppState({this.currentUser, this.waiting});

  static AppState initialState() {
    // TODO check if user is signed in
//    FirebaseUser curr = FirebaseAuth.getInstance().
//    print("current user: $curr");
    return AppState(currentUser: null, waiting: false);
  }

  AppState copy({User currentUser, bool waiting, String loginError}) {
    return AppState(
        currentUser: currentUser ?? this.currentUser,
        waiting: waiting ?? this.waiting);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AppState &&
            runtimeType == other.runtimeType &&
            currentUser == other.currentUser &&
            waiting == other.waiting;
  }

  @override
  int get hashCode {
    return currentUser.hashCode ^ waiting.hashCode;
  }

  @override
  String toString() {
    String type = "none";
    if (currentUser != null && currentUser.userType != null) {
      type = currentUser.userType;
    }
    return "\nAppState:\n\tCurrent User (type: $type): ${this.currentUser.toString()}\n\twaiting: ${this.waiting}";
  }
}

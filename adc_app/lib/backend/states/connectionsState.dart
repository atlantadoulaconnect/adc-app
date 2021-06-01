import 'common.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

// not serialized. Every time app is started up the new connections should be established
@immutable
class ConnectionsState {
  // final bool internetConn: connected to internet?
  final FirebaseAuth auth; // Firebase Auth
  final Firestore fs; // Firestore
  final FirebaseDatabase rtdb; // Realtime Database
  // cloud storage (for profile photos)
  // track internet connection

  ConnectionsState({this.auth, this.fs, this.rtdb});

  static ConnectionsState initialState() {
    return ConnectionsState(
        auth: FirebaseAuth.instance,
        fs: Firestore.instance,
        rtdb: FirebaseDatabase.instance);
  }

  ConnectionsState copy(
      {FirebaseAuth auth, Firestore fs, FirebaseDatabase rtdb}) {
    return ConnectionsState(
        auth: auth ?? this.auth, fs: fs ?? this.fs, rtdb: rtdb ?? this.rtdb);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectionsState &&
          runtimeType == other.runtimeType &&
          auth == other.auth &&
          fs == other.fs &&
          rtdb == other.rtdb;

  @override
  int get hashCode => auth.hashCode ^ fs.hashCode ^ rtdb.hashCode;

  @override
  String toString() {
    return 'ConnectionsState{auth: $auth, fs: $fs, rtdb: $rtdb}';
  }
}

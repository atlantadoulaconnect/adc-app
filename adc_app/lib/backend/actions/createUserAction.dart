import 'dart:async';

import 'common.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import '../actions/waitAction.dart';

class CreateUserAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  CreateUserAction(this.email, this.password)
      : assert(email != null && password != null);

  @override
  Future<AppState> reduce() async {
    print("Attempting to create user with email: $email");

    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      String userId = user.uid;
      print("User created with id: $userId");

      if (userId != null && userId.length > 0) {
        User applicant = new User(userId, email);
        print("new user: ${applicant.toString()}");
        return state.copy(currentUser: applicant);
      }
    } on PlatformException catch (e) {
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        // TODO set sign up error
        print("email already in use");
      }
    }

    return null;
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class CreateAdminUserDocument extends ReduxAction<AppState> {
  final Admin user;

  CreateAdminUserDocument(this.user)
      : assert(user != null && user.userType == "admin");

  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(user.userid).setData({
      "userid": user.userid,
      "name": user.name,
      "userType": user.userType,
      "email": user.email
    });

    return null;
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class UpdateAdminUserDocument extends ReduxAction<AppState> {
  final Admin user;

  UpdateAdminUserDocument(this.user)
      : assert(user != null && user.userType == "admin");
  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(user.userid).updateData({
      "userid": user.userid,
      "name": user.name,
    });

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "email": user.email,
    });

    return null;
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));

}

class CreateClientUserDocument extends ReduxAction<AppState> {
  final Client user;

  CreateClientUserDocument(this.user)
      : assert(user != null && user.userType == "client");

  @override
  Future<AppState> reduce() async {
    print(
        "Attempting to add this client ${user.toString()} to the users collection");

    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(user.userid).setData({
      "userid": user.userid,
      "name": user.name,
      "userType": user.userType,
    });

    // handle special cases: phones, emergency contacts, deliveryTypes

    // previous birth categories should only show if liveBirths > 0

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .setData({
      "phones": user.phones.join(", "),
      "bday": user.bday,
      "email": user.email,
      "dueDate": user.dueDate,
      "birthLocation": user.birthLocation,
      "birthType": user.birthType,
      "epidural": user.epidural,
      "cesarean": user.cesarean,
      "liveBirths": user.liveBirths,
      "preterm": user.preterm,
      "lowWeight": user.lowWeight,
      "deliveryTypes": user.deliveryTypes.join(", "),
      "multiples": user.multiples,
      "meetBefore": user.meetBefore,
      "homeVisit": user.homeVisit,
      "photoRelease": user.photoRelease
    });
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class UpdateClientUserDocument extends ReduxAction<AppState> {
  final Client user;

  UpdateClientUserDocument(this.user)
      : assert(user != null && user.userType == "client");
  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(user.userid).updateData({
      "userid": user.userid,
      "name": user.name,
    });

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "phones": user.phones.join(", "),
      "bday": user.bday,
      "email": user.email,
    });

    return null;
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class CreateDoulaUserDocument extends ReduxAction<AppState> {
  final Doula user;

  CreateDoulaUserDocument(this.user)
      : assert(user != null && user.userType == "doula");

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
        .collection("userData")
        .document("specifics")
        .setData({
      "phones": user.phones.join(", "),
      "bday": user.bday,
      "email": user.email,
      "bio": user.bio,
      "certified": user.certified,
      "certInProgress": user.certInProgress,
      "certProgram": user.certProgram,
      "birthsNeeded": user.birthsNeeded
    });

    await dbRef.collection("applications").document(user.userid).setData({
      "userid": user.userid,
      "name": user.name,
      "type": user.userType,
      "status": "submitted",
      "dateSubmitted": "${currentUnixTime()}"
    });

    // TODO applicationState, update application state to submitted

    return null;
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class UpdateDoulaUserDocument extends ReduxAction<AppState> {
  final Doula user;

  UpdateDoulaUserDocument(this.user)
      : assert(user != null && user.userType == "doula");
  @override
  Future<AppState> reduce() async {
    print(
        "Attempting to update this doula ${user.toString()} to the users collection");
    final dbRef = Firestore.instance;
    await dbRef.collection("users").document(user.userid).updateData({
      "userid": user.userid,
      "name": user.name,
    });

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .updateData({
      "bday": user.bday,
      "email": user.email,
      "bio": user.bio,
      "certified": user.certified,
      "certInProgress": user.certInProgress,
      "certProgram": user.certProgram,
      "birthsNeeded": user.birthsNeeded
    });

    return null;
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));

}



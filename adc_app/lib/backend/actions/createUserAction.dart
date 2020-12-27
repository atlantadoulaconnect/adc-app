import 'dart:async';
import 'package:adc_app/backend/util/UserErrorException.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'common.dart';

// creates a user (email/password) with firebase
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
        // adding user to firestore
        final dbRef = Firestore.instance;

        // add user to the collection of users
        await dbRef
            .collection("users")
            .document(userId)
            .setData({"userid": userId, "status": "incomplete" });

        // TODO trying to see if this works
        FirebaseMessaging _fcm;
        String token = await _fcm.getToken();
        print("FirebaseMessaging token: $token");

        await dbRef
            .collection("users")
            .document(userId)
            .setData({"deviceToken": token});

        // get the admin info
        QuerySnapshot adminQuery = await Firestore.instance
            .collection("users")
            .where("userType", isEqualTo: "admin")
            .getDocuments();
        DocumentSnapshot admin = adminQuery.documents[0];

        // add admin to CLIENT's contact list
        await dbRef
            .collection("users")
            .document(userId)
            .collection("contacts")
            .document(admin["userid"])
            .setData({
          "name": admin["name"],
          "userid": admin["userid"],
          "userType": admin["userType"],
          "isRecent": true
        });

        await dbRef
            .collection("users")
            .document(userId)
            .collection("userData")
            .document("specifics")
            .setData({
          "email": email,
        });

        User applicant = new User(userId, email);
        return state.copy(currentUser: applicant);
      }
    } on PlatformException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
          {
            throw UserErrorException("Email is already in use");
          }
          break;
        default:
          {
            throw UserErrorException("There was an internal error");
          }
      }
    }

    return null;
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

// adds an admin document to firestore
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

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

// Creates the User object to be used by the local appState
// invoked when a user selects an application from the AppType page
class CreateUserFromApp extends ReduxAction<AppState> {
  final String userid;
  final String email;
  final String userType;
  final String userStatus;

  CreateUserFromApp({this.userid, this.email, this.userType, this.userStatus});

  @override
  AppState reduce() {
    if (userType == "client") {
      Client current = Client(
          userid: userid, email: email, userType: userType, status: userStatus);
      return state.copy(currentUser: current);
    }

    Doula current = Doula(
        userid: userid, email: email, userType: userType, status: userStatus);
    return state.copy(currentUser: current);
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

class SubmitClientUser extends ReduxAction<AppState> {
  SubmitClientUser();

  @override
  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;

    Client user = state.currentUser as Client;

    // udpate userType and status
    await dbRef.collection("users").document(user.userid).updateData({
      "status": "submitted",
      "name": user.name,
      "userType": user.userType,
    });

    if (user.liveBirths > 0) {
      await dbRef
          .collection("users")
          .document(user.userid)
          .collection("userData")
          .document("specifics")
          .updateData({
        "phones": phonesToDB(user.phones),
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
        "deliveryTypes": user.deliveryTypes,
        "multiples": user.multiples,
        "meetBefore": user.meetBefore,
        "homeVisit": user.homeVisit,
        "photoRelease": user.photoRelease,
        "emergencyContacts": emgContactsToDB(user.emergencyContacts),
      });
    } else {
      await dbRef
          .collection("users")
          .document(user.userid)
          .collection("userData")
          .document("specifics")
          .updateData({
        "phones": phonesToDB(user.phones),
        "bday": user.bday,
        "email": user.email,
        "dueDate": user.dueDate,
        "birthLocation": user.birthLocation,
        "birthType": user.birthType,
        "epidural": user.epidural,
        "cesarean": user.cesarean,
        "liveBirths": user.liveBirths,
        "meetBefore": user.meetBefore,
        "homeVisit": user.homeVisit,
        "photoRelease": user.photoRelease,
        "emergencyContacts": emgContactsToDB(user.emergencyContacts),
      });
      user.preterm = null;
      user.lowWeight = null;
      user.deliveryTypes = null;
      user.multiples = null;
    }

    return state.copy(
        currentUser: (state.currentUser as Client).copy(status: "submitted"));
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

class SubmitDoulaUser extends ReduxAction<AppState> {
  SubmitDoulaUser();

  Future<AppState> reduce() async {
    final dbRef = Firestore.instance;

    Doula user = state.currentUser as Doula;

    await dbRef.collection("users").document(user.userid).updateData({
      "status": "submitted",
      "name": user.name,
      "userType": user.userType,
    });

    if (user.certInProgress) {
      await dbRef
          .collection("users")
          .document(user.userid)
          .collection("userData")
          .document("specifics")
          .updateData({
        "phones": phonesToDB(user.phones),
        "bday": user.bday,
        "email": user.email,
        "bio": user.bio,
        "photoRelease": user.photoRelease,
        "certified": user.certified,
        "certInProgress": user.certInProgress,
        "certProgram": user.certProgram,
        "birthsNeeded": user.birthsNeeded,
        "unavailableDates": user.availableDates,
      });
    } else {
      await dbRef
          .collection("users")
          .document(user.userid)
          .collection("userData")
          .document("specifics")
          .updateData({
        "phones": phonesToDB(user.phones),
        "bday": user.bday,
        "email": user.email,
        "bio": user.bio,
        "photoRelease": user.photoRelease,
        "certified": user.certified,
        "certInProgress": user.certInProgress,
        "unavailableDates": user.availableDates,
      });

      user.certProgram = null;
      user.birthsNeeded = null;
    }

    return state.copy(
        currentUser: (state.currentUser as Doula).copy(status: "submitted"));
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

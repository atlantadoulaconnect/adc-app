import 'dart:async';
import 'package:adc_app/backend/util/UserErrorException.dart';

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
        // add Admin as first contact and chat

        User applicant = new User(userId, email);

        print("adding admin as first contact");

        print("new user: ${applicant.toString()}");
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

// adds an client document to firestore
class CreateClientUserDocument extends ReduxAction<AppState> {
  final Client user;

  CreateClientUserDocument(this.user)
      : assert(user != null && user.userType == "client");

  @override
  Future<AppState> reduce() async {
    print(
        "Attempting to add this client ${user.toString()} to the users collection");

    final dbRef = Firestore.instance;

    // add user to the collection of users
    await dbRef.collection("users").document(user.userid).setData({
      "userid": user.userid,
      "status": "submitted",
      "name": user.name,
      "userType": user.userType,
    });

    // get the admin info
    QuerySnapshot adminQuery = await Firestore.instance
        .collection("users")
        .where("userType", isEqualTo: "admin")
        .getDocuments();
    DocumentSnapshot admin = adminQuery.documents[0];

    // add admin to CLIENT's contact list
    await dbRef
        .collection("users")
        .document(user.userid)
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
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .setData({
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
      "appContacts": state.messagesState.appContacts,
//      "chats": state.messagesState.chats != null
//          ? state.messagesState.chats.toList()
//          : null,
    });
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

// adds an doula document to firestore
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
      "status": "submitted",
      "name": user.name,
      "userType": user.userType,
    });

    QuerySnapshot adminQuery = await Firestore.instance
        .collection("users")
        .where("userType", isEqualTo: "admin")
        .getDocuments();
    DocumentSnapshot admin = adminQuery.documents[0];

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("contacts")
        .document(admin["userid"])
        .setData({
      "name": admin["name"],
      "userid": admin["userid"],
      "userType": "Admin",
      "isRecent": true
    });

    // handle special cases: phones, UNavailable dates

    await dbRef
        .collection("users")
        .document(user.userid)
        .collection("userData")
        .document("specifics")
        .setData({
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
      "appContacts": state.messagesState.appContacts,
//      "chats": state.messagesState.chats != null ? state.messagesState.chats.toList() : null,
    });

    // TODO applicationState, update application state to submitted
    return null;
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

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
}

import 'package:adc_app/backend/util/UserErrorException.dart';

import 'common.dart';
import '../util/persistence.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../actions/loadingAction.dart';

class LoginUserAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginUserAction(this.email, this.password)
      : assert(email != null && password != null);

  AppState populateAdmin(
      String userId, DocumentSnapshot basics, DocumentSnapshot specifics) {
    Admin user = Admin();
    AppState currState = AppState.initialState();

    Persistence.loadUserFile(userId).then((File userFile) {
      if (userFile != null) {
        currState = AppState.fromJson(jsonDecode(userFile.readAsStringSync()));
        user = currState.currentUser;
      }
    });

    // overwrite local info with server info
    user.userid = userId;
    user.userType = "admin";

    // copy ensures that local values will not be overwritten by nulls
    user = user.copy(name: basics["name"]);

    if (specifics != null) {
      user.email = specifics["email"];
    }

    return currState.copy(currentUser: user);
  }

  AppState populateClient(
      String userId, DocumentSnapshot basics, DocumentSnapshot specifics) {
    Client user = Client();
    AppState currState = AppState.initialState();

    Persistence.loadUserFile(userId).then((File userFile) {
      if (userFile != null) {
        currState = AppState.fromJson(jsonDecode(userFile.readAsStringSync()));
        user = currState.currentUser;
      }
    });

    // overwrite local info with guaranteed server info
    user.userid = userId;
    user.userType = "client";

    // copy ensures that local values will not be overwritten by nulls
    if (specifics != null) {
      // userData/specifics doc is created when application has been submitted
      user = user.copy(
        name: basics["name"],
        status: basics["status"],
        bday: specifics["bday"],
        birthLocation: specifics["birthLocation"],
        birthType: specifics["birthType"],
        cesarean: specifics["cesarean"],
        deliveryTypes: convertStringArray(specifics["deliveryTypes"]),
        dueDate: specifics["dueDate"],
        email: specifics["email"],
        epidural: specifics["epidural"],
        preterm: specifics["preterm"],
        homeVisit: specifics["homeVisit"],
        liveBirths: specifics["liveBirths"],
        lowWeight: specifics["lowWeight"],
        meetBefore: specifics["meetBefore"],
        multiples: specifics["multiples"],
        phones: convertPhones(specifics["phones"]),
        photoRelease: specifics["photoRelease"],
        emergencyContacts: convertEmgContacts(specifics["emergencyContacts"]),
        primaryDoulaId: specifics["primaryDoulaId"],
        primaryDoulaName: specifics["primaryDoulaName"],
        backupDoulaId: specifics["backupDoulaId"],
        backupDoulaName: specifics["backupDoulaName"],
      );
    }

    return currState.copy(currentUser: user);
  }

  AppState populateDoula(
      String userId, DocumentSnapshot basics, DocumentSnapshot specifics) {
    Doula user = Doula();
    AppState currState = AppState.initialState();

    Persistence.loadUserFile(userId).then((File userFile) {
      if (userFile != null) {
        currState = AppState.fromJson(jsonDecode(userFile.readAsStringSync()));
        user = currState.currentUser;
      }
    });

    // overwrite local info with guaranteed server info
    print("user obj is null: ${user == null}");
    user.userid = userId;
    user.userType = "doula";

    // copy ensures that local values will not be overwritten by nulls
    if (specifics != null) {
      // userData/specifics doc is created when application has been submitted
      user = user.copy(
          name: basics["name"],
          status: basics["status"],
          bday: specifics["bday"],
          bio: specifics["bio"],
          birthsNeeded: specifics["birthsNeeded"],
          certInProgress: specifics["certInProgress"],
          certProgram: specifics["certProgram"],
          certified: specifics["certified"],
          email: specifics["email"],
          phones: convertPhones(specifics["phones"]),
          availableDates: convertStringArray(specifics["unavailableDates"]));
    }

    return currState.copy(currentUser: user);
  }

  @override
  Future<AppState> reduce() async {
    print("Attempting to login user with email: $email");
    Firestore fs = Firestore.instance;

    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;
      String userId = user.uid;

      if (userId.length > 0 && userId != null) {
        print("received valid user id: $userId");

        AppState current;

        DocumentSnapshot basics =
            await fs.collection("users").document(userId).get();

        DocumentSnapshot specifics = await fs
            .collection("users/$userId/userData")
            .document("specifics")
            .get();

        String userType;

        if (basics.exists) {
          // in case user logged out before choosing user type
          userType = basics["userType"];
        }

        switch (userType) {
          case "admin":
            {
              current = populateAdmin(userId, basics, specifics);
            }
            break;
          case "client":
            {
              current = populateClient(userId, basics, specifics);
            }
            break;
          case "doula":
            {
              current = populateDoula(userId, basics, specifics);
            }
            break;
          default:
            {
              // user logged out before selecting user type
              current =
                  AppState(currentUser: User(userId, email), waiting: false);
            }
            break;
        }

        Map<String, dynamic> init = {"lastUser": userId, "loggedIn": true};

        getApplicationDocumentsDirectory().then((Directory dir) {
          // mark user as logged in
          File initializer = File("${dir.path}/initializer.json");
          initializer.writeAsStringSync(jsonEncode(init));

          // automatically save what was synced
          File userFile = File("${dir.path}/$userId.json");
          userFile.writeAsStringSync(jsonEncode(current.toJson()));
        });

        return current;
      } else {
        // invalid user id
        print("invalid user id returned");
        // TODO set login error
        return null;
      }
    } on PlatformException catch (e) {
      // cases for diff types of errors
      switch (e.code) {
        case "ERROR_USER_NOT_FOUND":
          {
            throw UserErrorException(
                "There is no account associated with this email address");
          }
          break;
        case "ERROR_WRONG_PASSWORD":
          {
            throw UserErrorException("Incorrect password");
          }
          break;
        case "ERROR_USER_DISABLED":
          {
            throw UserErrorException(
                "This account has been disabled. Contact the admins to re-enable it");
          }
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          {
            throw UserErrorException(
                "There have been too many login attempts. Wait and try again later.");
          }
        default:
          {
            throw UserErrorException("There was an internal error");
          }
      }
    }
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

class LogoutUserAction extends ReduxAction<AppState> {
  LogoutUserAction();

  @override
  Future<AppState> reduce() async {
    String userid = state.currentUser.userid;
    print("Attempting to logout user with email: ${state.currentUser.email}");
    print("state b/f fb auth signout: ${state.toString()}");

    print(
        "LOGOUT ACTION usertype: ${state.currentUser.userType} status: ${state.currentUser.status}");

    if (state.currentUser.userType != null &&
        (state.currentUser.status == "incomplete" ||
            state.currentUser.status == null)) {
      print("LOGOUT ACTION usertype not null, status incomplete");
      final dbRef = Firestore.instance;
      switch (state.currentUser.userType) {
        case "client":
          {
            Client user = state.currentUser as Client;
            await dbRef.collection("users").document(user.userid).setData({
              "userid": user.userid,
              "status": "incomplete",
              "name": user.name,
              "userType": user.userType,
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
            });
          }
          break;
        case "doula":
          {
            print("LOGOUT ACTION switch case doula");
            Doula user = state.currentUser as Doula;
            await dbRef.collection("users").document(user.userid).setData({
              "userid": user.userid,
              "status": "incomplete",
              "name": user.name,
              "userType": user.userType,
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
              "bio": user.bio,
              "photoRelease": user.photoRelease,
              "certified": user.certified,
              "certInProgress": user.certInProgress,
              "certProgram": user.certProgram,
              "birthsNeeded": user.birthsNeeded,
              "unavailableDates": user.availableDates,
            });
          }
          break;
        default:
          {
            print(
                "LOGOUT ACTION. User type is not null but is: ${state.currentUser.userType}");
          }
      }
    }

    try {
      await FirebaseAuth.instance.signOut();
      print("FirebaseAuth signout success");

      Map<String, dynamic> init = {"lastUser": userid, "loggedIn": false};

      getApplicationDocumentsDirectory().then((Directory dir) {
        File initializer = File("${dir.path}/initializer.json");
        initializer.writeAsStringSync(jsonEncode(init));

        // save currentState to local storage
        File userFile = File("${dir.path}/$userid.json");
        userFile.writeAsStringSync(jsonEncode(state.toJson()));
      });

      return AppState.initialState();
    } catch (e, stacktrace) {
      print("SIGN OUT ERROR: $e\n$stacktrace");
      return null;
    }
  }

  void before() => dispatch(LoadingAction(true));

  void after() => dispatch(LoadingAction(false));
}

class ClearAppStateAction extends ReduxAction<AppState> {
  ClearAppStateAction();

  @override
  AppState reduce() {
    // clearing state object
    return AppState.initialState();
  }
}

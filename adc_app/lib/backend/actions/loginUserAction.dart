import 'common.dart';
import '../util/persistence.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../actions/waitAction.dart';

class LoginUserAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginUserAction(this.email, this.password)
      : assert(email != null && password != null);

  Set<String> convertChats(String chatList) {
    if (chatList != null) {
      return chatList.split(", ").toSet();
    }
    return null;
  }

  List<Phone> convertPhones(List<dynamic> phoneList) {
    List<Phone> phones = List<Phone>();

    if (phoneList != null) {
      if (phoneList.length > 0) {
        phoneList.forEach((element) {
          phones.add(Phone(element["number"].toString(), element["isPrimary"]));
        });
      }
    }

    return phones;
  }

  List<String> convertStringArray(List<dynamic> array) {
    if (array != null) {
      List<String> list = List<String>();
      array.forEach((element) => list.add(element.toString()));
      return list;
    }
    return null;
  }

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

    return currState.copy(
        currentUser: user,
        messagesState: currState.messagesState
            .copy(chats: convertChats(specifics["chats"])));
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
          bday: specifics["bday"],
          birthLocation: specifics["birthLocation"],
          birthType: specifics["birthType"],
          deliveryTypes: convertStringArray(specifics["deliveryTypes"]),
          dueDate: specifics["dueDate"],
          email: specifics["email"],
          epidural: specifics["epidural"],
          homeVisit: specifics["homeVisit"],
          liveBirths: specifics["liveBirths"],
          lowWeight: specifics["lowWeight"],
          meetBefore: specifics["meetBefore"],
          multiples: specifics["multiples"],
          phones: convertPhones(specifics["phones"]),
          photoRelease: specifics["photoRelease"]
          // emergency contacts
          // primary and backup doulas
          );
    }

    return currState.copy(
        currentUser: user,
        messagesState: currState.messagesState
            .copy(chats: convertChats(specifics["chats"])));
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
          bday: specifics["bday"],
          bio: specifics["bio"],
          birthsNeeded: specifics["birthsNeeded"],
          certInProgress: specifics["certInProgress"],
          certProgram: specifics["certProgram"],
          certified: specifics["certified"],
          email: specifics["email"],
          phones: convertPhones(specifics["phones"]));
    }

    return currState.copy(
        currentUser: user,
        messagesState: currState.messagesState
            .copy(chats: convertChats(specifics["chats"])));
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
        //print("populating AppState currentUser");

        AppState current;

        DocumentSnapshot basics =
            await fs.collection("users").document(userId).get();

        DocumentSnapshot specifics = await fs
            .collection("users/$userId/userData")
            .document("specifics")
            .get();

        String userType;
        if (basics != null) {
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
              current = AppState(
                  currentUser: User(userId, email),
                  waiting: false,
                  formState: ApplicationState.initialState(),
                  messagesState: MessagesState.initialState());
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
    } catch (e, stacktrace) {
      // TODO set login error in error state
      print("LOGIN ERROR: $e\n$stacktrace");
      return null;
    }
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class LogoutUserAction extends ReduxAction<AppState> {
  LogoutUserAction();

  @override
  Future<AppState> reduce() async {
    String userid = state.currentUser.userid;
    print("Attempting to logout user with email: ${state.currentUser.email}");
    print("state bf fb auth signout: ${state.toString()}");
    try {
      await FirebaseAuth.instance.signOut();
      print("FirebaseAuth signout success");

      Map<String, dynamic> init = {"lastUser": userid, "loggedIn": false};

      getApplicationDocumentsDirectory().then((Directory dir) {
        File initializer = File("${dir.path}/initializer.json");
        initializer.writeAsStringSync(jsonEncode(init));

        // save to local storage
        File userFile = File("${dir.path}/$userid.json");
        userFile.writeAsStringSync(jsonEncode(state.toJson()));
      });

      return AppState.initialState();
    } catch (e, stacktrace) {
      print("SIGN OUT ERROR: $e\n$stacktrace");
      return null;
    }
  }

  void before() => dispatch(WaitAction(true));

  void after() => dispatch(WaitAction(false));
}

class ClearAppStateAction extends ReduxAction<AppState> {
  ClearAppStateAction();

  @override
  AppState reduce() {
    // clearing state object
    return AppState.initialState();
  }
}

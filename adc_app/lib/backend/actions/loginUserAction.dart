import 'common.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../actions/waitAction.dart';

class LoginUserAction extends ReduxAction<AppState> {
  final String email;
  final String password;

  LoginUserAction(this.email, this.password)
      : assert(email != null && password != null);

  Admin populateAdmin(String userId, DocumentSnapshot ds) {
    Admin user = Admin(userid: userId, userType: "admin", name: ds["name"]);
    // print("pop admin: ${ds["aa"]}");
    return user;
  }

  Client populateClient(String userId, DocumentSnapshot ds) {
    Client user = Client(userid: userId, userType: "client", name: ds["name"]);

    return user;
  }

  Doula populateDoula(String userId, DocumentSnapshot ds) {
    Doula user = Doula(userid: userId, userType: "doula", name: ds["name"]);

    return user;
  }

  @override
  Future<AppState> reduce() async {
    print("Attempting to login user with email: $email");

    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = result.user;
      String userId = user.uid;

      if (userId.length > 0 && userId != null) {
        print("received valid user id: $userId");
        print("populating AppState currentUser");

        User current;

        await Firestore.instance
            .collection("users")
            .document(userId)
            .get()
            .then((DocumentSnapshot ds) {
          String userType = ds["userType"];

          switch (userType) {
            case "admin":
              {
                current = populateAdmin(userId, ds);
              }
              break;
            case "client":
              {
                current = populateClient(userId, ds);
              }
              break;
            case "doula":
              {
                current = populateDoula(userId, ds);
              }
              break;
            default:
              {
                // user logged out before selecting user type
                current = User(userId, email);
              }
              break;
          }
        });

        Map<String, dynamic> init = {"lastUser": userId, "loggedIn": true};

        getApplicationDocumentsDirectory().then((Directory dir) {
          File initializer = File("${dir.path}/initializer.json");
          initializer.writeAsStringSync(jsonEncode(init));
        });

        print("update AppState with current user: ${current.toString()}");
        return state.copy(currentUser: current);
      } else {
        // invalid user id
        print("invalid user id returned");
        return null;
      }
    } catch (e) {
      // TODO set login error
      print("login error: $e");
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

      Map<String, dynamic> init = {
        "lastUser": state.currentUser.userid,
        "loggedIn": false
      };

      getApplicationDocumentsDirectory().then((Directory dir) {
        File initializer = File("${dir.path}/initializer.json");
        initializer.writeAsStringSync(jsonEncode(init));
      });

      // clearing state object
      return AppState.initialState();
    } catch (e) {
      print("sign out error $e");
      return null;
    }
  }
}

import '../common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AdminHomeScreen extends StatelessWidget {
  final Admin currentUser;
  final VoidCallback logout;
  final VoidCallback toRegisteredDoulas;
  final VoidCallback toPendingApps;
  final VoidCallback toRegisteredClients;
  final VoidCallback toHome;

  AdminHomeScreen(this.currentUser, this.logout, this.toRegisteredDoulas,
      this.toRegisteredClients, this.toPendingApps, this.toHome)
      : assert(logout != null &&
            toRegisteredDoulas != null &&
            toRegisteredClients != null &&
            toPendingApps != null &&
            toHome != null);

  int getPendingDoulaCount() {
    int pendingDoulaCount = 0;
    StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection("users")
            .where("userType", isEqualTo: "doula")
            .where("status", isEqualTo: "submitted")
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("");
          }
          pendingDoulaCount = snapshot.data.documents.length;
          return Text("");
        });
    return pendingDoulaCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Home Page"),
        ),
        drawer: Menu(),
        body: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Text(
                "Welcome ${currentUser != null ? currentUser.name : ""}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 7.0),
              child: Text(
                "2 Pending Client Application(s)",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 40.0),
              child: Text(
                "${getPendingDoulaCount()} Pending Doula Application(s)",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(color: themeColors['mediumBlue'])),
                onPressed: () {
                  // TODO active matches screen
                  toPendingApps();
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "Pending Applications",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(50.0),
//                    side: BorderSide(color: themeColors['gold'])),
//                onPressed: TODO: list all active matches,
//                color: themeColors['gold'],
//                textColor: Colors.black,
//                padding: EdgeInsets.all(15.0),
//                splashColor: themeColors['gold'],
//                child: Text(
//                  "See Active Matches",
//                  style: TextStyle(fontSize: 20.0),
//                ),
//              ),
//            ),
            Padding(
              padding: EdgeInsets.only(bottom: 25.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(color: themeColors['mediumBlue'])),
                onPressed: () {
                  // TODO active matches screen
                  toPendingApps();
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "Unmatched Clients",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
//            Padding(
//              padding: EdgeInsets.only(bottom: 25.0),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(10.0),
//                    side: BorderSide(color: themeColors['mediumBlue'])),
//                onPressed: () {
//                  toRegisteredClients();
//                },
//                color: themeColors['mediumBlue'],
//                textColor: Colors.white,
//                padding: EdgeInsets.all(15.0),
//                splashColor: themeColors['mediumBlue'],
//                child: Text(
//                  "All Registered Clients",
//                  style: TextStyle(fontSize: 20.0),
//                ),
//              ),
//            ),
//            Padding(
//              padding: EdgeInsets.only(bottom: 30.0),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(10.0),
//                    side: BorderSide(color: themeColors['mediumBlue'])),
//                onPressed: () {
//                  toRegisteredDoulas();
//                },
//                color: themeColors['mediumBlue'],
//                textColor: Colors.white,
//                padding: EdgeInsets.all(15.0),
//                splashColor: themeColors['mediumBlue'],
//                child: Text(
//                  "All Registered Doulas",
//                  style: TextStyle(fontSize: 20.0),
//                ),
//              ),
//            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: themeColors['yellow'])),
              color: themeColors['yellow'],
              textColor: Colors.white,
              padding: EdgeInsets.all(15.0),
              child: Text(
                "LOG OUT",
                style: TextStyle(
                  fontSize: 20.0,
                  color: themeColors['black'],
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                logout();
                toHome();
              },
            ),
          ],
        )));
  }
}

class AdminHomeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) {
        return AdminHomeScreen(vm.currentUser, vm.logout, vm.toRegisteredDoulas,
            vm.toRegisteredClients, vm.toPendingApps, vm.toHome);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Admin currentUser;
  VoidCallback logout;
  VoidCallback toRegisteredDoulas;
  VoidCallback toPendingApps;
  VoidCallback toRegisteredClients;
  VoidCallback toHome;

  ViewModel.build(
      {@required this.currentUser,
      @required this.logout,
      @required this.toRegisteredDoulas,
      @required this.toRegisteredClients,
      @required this.toHome,
      @required this.toPendingApps})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        logout: () {
          dispatch(LogoutUserAction());
          dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
        },
        toRegisteredDoulas: () =>
            dispatch(NavigateAction.pushNamed("/registeredDoulas")),
        toRegisteredClients: () =>
            dispatch(NavigateAction.pushNamed("/registeredClients")),
        toHome: () => dispatch(NavigateAction.pushNamed("/")),
        toPendingApps: () =>
            dispatch(NavigateAction.pushNamed("/pendingApps")));
  }
}

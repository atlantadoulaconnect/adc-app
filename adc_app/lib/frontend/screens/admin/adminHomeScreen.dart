import '../common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomeScreen extends StatelessWidget {
  final Admin currentUser;
  final VoidCallback logout;
  final VoidCallback toRegisteredDoulas;
  final VoidCallback toRegisteredClients;
  final VoidCallback toHome;
  final VoidCallback toPendingApps;
  final VoidCallback toUnmatchedClients;
  final VoidCallback toActiveMatches;
  final VoidCallback toAllUsers;

  int numPendingClients;
  int numPendingDoulas;

  AdminHomeScreen(
    this.currentUser,
    this.logout,
    this.toRegisteredDoulas,
    this.toRegisteredClients,
    this.toHome,
    this.toPendingApps,
    this.toUnmatchedClients,
    this.toActiveMatches,
    this.toAllUsers,
  ) : assert(logout != null &&
            toRegisteredDoulas != null &&
            toRegisteredClients != null &&
            toPendingApps != null &&
            toHome != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Admin Home Page"),
        ),
        drawer: Menu(),
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
            NotificationHandler(),
            Padding(
              padding: EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Text(
                "Welcome${currentUser != null && currentUser.name != null ? ", ${currentUser.name}" : ""}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, left: 40.0, right: 40.0, bottom: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: themeColors["lighterGray"],
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  border: Border.all(
                    color: themeColors["coolGray2"],
                    width: 3.0,
                  ),
                ),
                child: ListView(shrinkWrap: true, children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
                    child: Center(
                        child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: Firestore.instance
                            .collection("users")
                            .where("status", isEqualTo: "submitted")
                            .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    themeColors["lightBlue"]),
                              ));
                            }
                            int clients = 0;
                            int doulas = 0;

                            for (int i = 0;
                                i < snapshot.data.documents.length;
                                i++) {
                              DocumentSnapshot ds = snapshot.data.documents[i];
                              if (ds["userType"] == "client") {
                                clients++;
                              } else if (ds["userType"] == "doula") {
                                doulas++;
                              }
                            }

                            return Text(
                              "$doulas Pending Doula Application(s)\n$clients Pending Client Application(s)\n",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            );
                      },
                    ))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.0, right: 50.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          side: BorderSide(color: themeColors['mediumBlue'])),
                      onPressed: () {
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
                ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 5, 15, 5),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    side: BorderSide(color: themeColors['mediumBlue'])),
                onPressed: () {
                  toUnmatchedClients();
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
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 5, 15, 5),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    side: BorderSide(color: themeColors['gold'])),
                onPressed: () {
                  toActiveMatches();
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "See Active Matches",
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
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 5, 15, 5),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(color: themeColors['mediumBlue'])),
                onPressed: () {
                  toAllUsers();
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "All Users",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
//            Padding(
//              padding: EdgeInsets.only(bottom: 30.0),
//              child: RaisedButton(
//                shape: RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(15.0),
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
            Padding(
              padding: EdgeInsets.fromLTRB(15.0, 5, 15, 5),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                    side: BorderSide(color: themeColors['yellow'])),
                color: themeColors['yellow'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
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
        return AdminHomeScreen(
            vm.currentUser,
            vm.logout,
            vm.toRegisteredDoulas,
            vm.toRegisteredClients,
            vm.toHome,
            vm.toPendingApps,
            vm.toUnmatchedClients,
            vm.toActiveMatches,
            vm.toAllUsers);
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
  VoidCallback toUnmatchedClients;
  VoidCallback toActiveMatches;
  VoidCallback toAllUsers;

  ViewModel.build({
    @required this.currentUser,
    @required this.logout,
    @required this.toRegisteredDoulas,
    @required this.toRegisteredClients,
    @required this.toHome,
    @required this.toPendingApps,
    @required this.toUnmatchedClients,
    @required this.toActiveMatches,
    @required this.toAllUsers,
  }) : super(equals: []);

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
      toPendingApps: () => dispatch(NavigateAction.pushNamed("/pendingApps")),
      toUnmatchedClients: () =>
          dispatch(NavigateAction.pushNamed("/unmatchedClients")),
      toActiveMatches: () =>
          dispatch(NavigateAction.pushNamed("/activeMatches")),
      toAllUsers: () => dispatch(NavigateAction.pushNamed("/allUsers")),
    );
  }
}

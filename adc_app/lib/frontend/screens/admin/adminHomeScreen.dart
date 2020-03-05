import 'dart:math';

import '../common.dart';

class AdminHomeScreen extends StatelessWidget {
  final Admin currentUser;
  final Future<void> Function() logout;
  final VoidCallback toRegisteredDoulas;
  final VoidCallback toRegisteredClients;
  final VoidCallback toHome;

  AdminHomeScreen(this.currentUser, this.logout, this.toRegisteredDoulas,
      this.toRegisteredClients, this.toHome)
      : assert(currentUser != null &&
            logout != null &&
            toRegisteredDoulas != null &&
            toRegisteredClients != null &&
            toHome != null);

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
                "Welcome, Admin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 7.0),
              child: Text(
                "2 New Clients",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 40.0),
              child: Text(
                "1 Pending Doula Application",
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
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "Active Matches",
                  style: TextStyle(fontSize: 20.0),
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
                  toRegisteredClients();
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "All Registered Clients",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    side: BorderSide(color: themeColors['mediumBlue'])),
                onPressed: () {
                  toRegisteredDoulas();
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "All Registered Doulas",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
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
            vm.toRegisteredClients, vm.toHome);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Admin currentUser;
  Future<void> Function() logout;
  VoidCallback toRegisteredDoulas;
  VoidCallback toRegisteredClients;
  VoidCallback toHome;

  ViewModel.build(
      {@required this.currentUser,
      @required this.logout,
      @required this.toRegisteredDoulas,
      @required this.toRegisteredClients,
      @required this.toHome})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
      currentUser: state.currentUser,
      logout: () => dispatchFuture(LogoutUserAction()),
      toRegisteredDoulas: () =>
          dispatch(NavigateAction.pushNamed("/registeredDoulas")),
      toRegisteredClients: () =>
          dispatch(NavigateAction.pushNamed("/registeredClients")),
      toHome: () => dispatch(NavigateAction.pushNamed("/")),
    );
  }
}

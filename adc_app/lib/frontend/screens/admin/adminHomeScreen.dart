import '../common.dart';

class AdminHomeScreen extends StatelessWidget {
  final Admin currentUser;
  final Future<void> Function() logout;
  final VoidCallback toRegisteredDoulas;
  final VoidCallback toPendingApps;

  AdminHomeScreen(this.currentUser, this.logout, this.toRegisteredDoulas,
      this.toPendingApps);

  @override
  Widget build(BuildContext context) {
    // TODO: sprint 1 'your application has been submitted. you will be notified when ADC has finished their review'
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
                  toPendingApps();
                },
                color: themeColors['mediumBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['mediumBlue'],
                child: Text(
                  "Pending Matches",
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
                  // TODO show registered clients
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
        return AdminHomeScreen(
            vm.currentUser, vm.logout, vm.toRegisteredDoulas, vm.toPendingApps);
      },
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Admin currentUser;
  Future<void> Function() logout;
  VoidCallback toRegisteredDoulas;
  VoidCallback toPendingApps;

  ViewModel.build(
      {@required this.currentUser,
      @required this.logout,
      @required this.toRegisteredDoulas,
      @required this.toPendingApps})
      : super(equals: []);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        logout: () => dispatchFuture(LogoutUserAction()),
        toRegisteredDoulas: () =>
            dispatch(NavigateAction.pushNamed("/registeredDoulas")),
        toPendingApps: () =>
            dispatch(NavigateAction.pushNamed("/pendingApps")));
  }
}

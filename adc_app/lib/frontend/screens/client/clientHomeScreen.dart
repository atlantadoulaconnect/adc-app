import '../common.dart';

class ClientHomeScreen extends StatelessWidget {
  final Client currentUser;
  final Future<void> Function() logout;
  final VoidCallback toHome;
  final VoidCallback toRecentMessages;
  final VoidCallback toInfo;

  ClientHomeScreen(this.currentUser, this.logout, this.toHome,
      this.toRecentMessages, this.toInfo)
      : assert(currentUser != null &&
            logout != null &&
            toHome != null &&
            toRecentMessages != null &&
            toInfo != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Welcome ${currentUser.name}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                onPressed: toRecentMessages,
                color: themeColors['lightBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['lightBlue'],
                child: Text(
                  "See Messages",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: themeColors['gold'])),
                onPressed: toInfo,
                color: themeColors['gold'],
                textColor: Colors.black,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['gold'],
                child: Text(
                  "Frequently Asked Questions",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                    side: BorderSide(color: themeColors['lightBlue'])),
                //TODO change route to messaging doula
                onPressed: toRecentMessages,
                color: themeColors['lightBlue'],
                textColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                splashColor: themeColors['lightBlue'],
                child: Text(
                  "I'm going into labor!",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(50.0),
                ),
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("LOG OUT"),
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

class ClientHomeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => ClientHomeScreen(
          vm.currentUser, vm.logout, vm.toHome, vm.toRecentMessages, vm.toInfo),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  Future<void> Function() logout;
  VoidCallback toHome;
  VoidCallback toRecentMessages;
  VoidCallback toInfo;

  ViewModel.build(
      {@required this.currentUser,
      @required this.logout,
      @required this.toHome,
      @required this.toRecentMessages,
      @required this.toInfo})
      : super(equals: [currentUser]);

  @override
  ViewModel fromStore() {
    return ViewModel.build(
        currentUser: state.currentUser,
        logout: () => dispatchFuture(LogoutUserAction()),
        toHome: () => dispatch(NavigateAction.pushNamed("/")),
        toRecentMessages: () =>
            dispatch(NavigateAction.pushNamed("/recentMessages")),
        toInfo: () => dispatch(NavigateAction.pushNamed("/info")));
  }
}

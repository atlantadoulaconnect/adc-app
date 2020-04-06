import '../common.dart';

class DoulaHomeScreen extends StatelessWidget {
  final Doula currentUser;
  final VoidCallback logout;
  final VoidCallback toHome;
  final VoidCallback toRecentMessages;
  final VoidCallback toInfo;

  DoulaHomeScreen(this.currentUser, this.logout, this.toHome,
      this.toRecentMessages, this.toInfo)
      : assert(logout != null &&
            toHome != null &&
            toRecentMessages != null &&
            toInfo != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Menu(),
        body: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Center(
              child: Column(
            children: <Widget>[
              NotificationHandler(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Welcome ${currentUser != null ? currentUser.name : ""}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              //TODO ADD IN CLIENT NAME AFTER MATCHING PAGE IS UP
              Text("Current Client: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )),
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
                  onPressed: toRecentMessages,
                  color: themeColors['lightBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['lightBlue'],
                  child: Text(
                    "Discussion Boards",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              RaisedButton(
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
            ],
          )),
        ));
  }
}

class DoulaHomeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => DoulaHomeScreen(
          vm.currentUser, vm.logout, vm.toHome, vm.toRecentMessages, vm.toInfo),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  VoidCallback logout;
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
      logout: () {
        dispatch(LogoutUserAction());
        dispatch(NavigateAction.pushNamedAndRemoveAll("/"));
      },
      toHome: () => dispatch(NavigateAction.pushNamed("/")),
      toRecentMessages: () =>
          dispatch(NavigateAction.pushNamed("/recentMessages")),
      toInfo: () => dispatch(NavigateAction.pushNamed("/info")),
    );
  }
}

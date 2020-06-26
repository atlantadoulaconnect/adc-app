import '../common.dart';

class ClientHomeScreen extends StatelessWidget {
  final Client currentUser;
  final VoidCallback logout;
  final VoidCallback toHome;
  final VoidCallback toRecentMessages;
  final VoidCallback toInfo;
  final VoidCallback toProfile;
  final Future<void> Function(String, String) setProfileUser;

  ClientHomeScreen(this.currentUser, this.logout, this.toHome,
      this.toRecentMessages, this.toInfo, this.toProfile, this.setProfileUser)
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
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              children: <Widget>[
                NotificationHandler(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 8.0),
                  child: Text(
                      "Welcome, \n${currentUser != null ? currentUser.name : ""}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: themeColors['mediumBlue'], width: 3.0)),
                    onPressed: () async {
                      await setProfileUser(currentUser.primaryDoulaId, "doula");
                      toProfile();
                    },
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "See Doula's Profile",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: toRecentMessages,
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "See Messages",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: () async {
                      await setProfileUser(
                          currentUser.userid, currentUser.userType);
                      toProfile();
                    },
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "See Profile",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: themeColors['mediumBlue'])),
                    onPressed: toInfo,
                    color: themeColors['mediumBlue'],
                    textColor: Colors.white,
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['mediumBlue'],
                    child: Text(
                      "Frequently Asked Questions",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: themeColors['darkPurple'], width: 2.0)),
                    //TODO change route to messaging doula
                    onPressed: toRecentMessages,
                    color: themeColors['hItPink'],
                    textColor: themeColors['darkPurple'],
                    padding: EdgeInsets.all(15.0),
                    splashColor: themeColors['hItPink'],
                    child: Text(
                      "I'm going into labor!",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: RaisedButton(
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
                ),
              ],
            ))));
  }
}

class ClientHomeScreenConnector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ViewModel>(
      model: ViewModel(),
      builder: (BuildContext context, ViewModel vm) => ClientHomeScreen(
          vm.currentUser,
          vm.logout,
          vm.toHome,
          vm.toRecentMessages,
          vm.toInfo,
          vm.toProfile,
          vm.setProfileUser),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Client currentUser;
  VoidCallback logout;
  VoidCallback toHome;
  VoidCallback toRecentMessages;
  VoidCallback toInfo;
  VoidCallback toProfile;
  Future<void> Function(String, String) setProfileUser;

  ViewModel.build({
    @required this.currentUser,
    @required this.logout,
    @required this.toHome,
    @required this.toRecentMessages,
    @required this.toInfo,
    @required this.toProfile,
    @required this.setProfileUser,
  }) : super(equals: [currentUser]);

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
      toProfile: () => dispatch(NavigateAction.pushNamed("/userProfile")),
      setProfileUser: (String userid, String userType) =>
          dispatchFuture(SetProfileUser(userid, userType)),
    );
  }
}

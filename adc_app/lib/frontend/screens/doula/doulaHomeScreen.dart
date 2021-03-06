import '../common.dart';

class DoulaHomeScreen extends StatelessWidget {
  final Doula currentUser;
  final VoidCallback logout;
  final VoidCallback toHome;
  final VoidCallback toInfo;
  final VoidCallback toProfile;
  final Future<void> Function(String, String) setProfileUser;

  DoulaHomeScreen(this.currentUser, this.logout, this.toHome,
      this.toInfo, this.toProfile, this.setProfileUser)
      : assert(logout != null &&
            toHome != null &&
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
//              Text("Current Client: ",
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.bold,
//                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                padding: const EdgeInsets.all(8.0),
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
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color: themeColors['mediumBlue'])),
                  onPressed: toHome,
                  color: themeColors['mediumBlue'],
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15.0),
                  splashColor: themeColors['mediumBlue'],
                  child: Text(
                    "Discussion Boards",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
          vm.currentUser,
          vm.logout,
          vm.toHome,
          vm.toInfo,
          vm.toProfile,
          vm.setProfileUser),
    );
  }
}

class ViewModel extends BaseModel<AppState> {
  ViewModel();

  Doula currentUser;
  VoidCallback logout;
  VoidCallback toHome;
  VoidCallback toInfo;
  VoidCallback toProfile;
  Future<void> Function(String, String) setProfileUser;

  ViewModel.build({
    @required this.currentUser,
    @required this.logout,
    @required this.toHome,
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
      toInfo: () => dispatch(NavigateAction.pushNamed("/info")),
      toProfile: () => dispatch(NavigateAction.pushNamed("/userProfile")),
      setProfileUser: (String userid, String userType) =>
          dispatchFuture(SetProfileUser(userid, userType)),
    );
  }
}
